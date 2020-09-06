/*
 * (c) Mark Goodwin 2020.
 * CC BY-SA 4.0
 */

// rounded edges on the sides, square-edged front and rear face
module mono_rounded_cube(dimensions = [200, 150, 300], radius = 3, $fn = 30) {
    minkowski() {
        translate([radius, 0, radius]) {
            cube([dimensions[0] - (radius *  2), dimensions[1] - 1, dimensions[2] -  (radius * 2)]);
        }
        rotate([270, 0, 0]) {
            cylinder(r = radius, h = 1);
        }
    }
}

// side edges have radius1, end edges have radius2
module dual_rounded_cube(dimensions = [200, 150, 300], radius1 = 6, radius2 = 3, $fn = 30) {
    combined_radius = radius1 + radius2;
    minkowski()  {
        minkowski() {
            translate([combined_radius, radius2, combined_radius]) {
                cube([dimensions[0] - (combined_radius *  2), dimensions[1] - (radius2 * 2), dimensions[2] -  (combined_radius * 2)]);
            }
            rotate([270, 0, 0]) {
                cylinder(r = radius1, h = 1, $fn = $fn);
            }
        }
        rotate([0, 270, 0]) {
            sphere(r = radius2, $fn = $fn);
        }
    }
}

// all edges have the specified radius
module rounded_cube(dimensions = [200, 150, 300], radius = 3, $fn = 30) {
    translate([radius, radius, radius]) {
        minkowski() {
            cube([dimensions[0] - (radius * 2), dimensions[1] - (radius * 2), dimensions[2] - (radius * 2)]);
            sphere(r = radius, $fn = $fn);
        }
    };
}



// attempt to reproduce the inside curve beneath the face
module inside_curve(width = 330, depth = 60, angle = 80, radius = 100) {
    rotate([90, 0, 0])
    rotate([0, 90, 0])
    rotate_extrude(angle = 80, convexity = 2, $fn = 100)
    
        projection(cut = false)
            translate([radius, 0, 0]) 
                rotate([270, 0, 0])
                    translate([0, 0, -width / 2])
                        mono_rounded_cube(dimensions = [depth, 2, width],
                                      radius = 9, $fn = 100);
}

// A sketch of a Macintosh Plus main body
module plus_face(
        screen_recess_dimensions = [
            200, // max width of the screen recess
            7,   // some depth - needs to be bigger than the screen recess radius
            150  // max height of the screen recess
        ],
        screen_recess_radius = 3, // radius of the rounded corner on the face end of the screen recess
        screen_recess_inner_radius = 9,  // radius of the rounded corner at the screen end of the screen recess
        screen_recess_z = 140, // height of the bottom of the screen recess from the bottom of the face
        screen_to_bevel = 15, // edge of the screen recess to the front edge of the face bevel
        bevel_to_edge_x = 10,
        bevel_to_edge_z = 15
) {
    // Calculate some dimensions for size, shape and positions
    bevel_width     = screen_recess_dimensions[0] + (screen_to_bevel * 2);
    face_height     = screen_recess_z + screen_recess_dimensions[2]
                        + screen_to_bevel + bevel_to_edge_z;
    face_width      = bevel_width + (bevel_to_edge_x * 2);
    bevel_height    = face_height - bevel_to_edge_z * 2;

    // some dimensions for the screen recess
    recess_taper        = 10;
    recess_taper_depth  = 20;
    inner_width         = screen_recess_dimensions[0]
                            - (recess_taper * 2);
    inner_height        = screen_recess_dimensions[2]
                            - (recess_taper * 2);
    
    // neck measurements
    neck_curve_radius = 10;
    chin_depth = 20;
    base_height = 40;

    // Neck and chin
    translate([0, 0, base_height]) inside_curve(width = face_width, radius = neck_curve_radius);
    translate([-face_width / 2, 60 + neck_curve_radius, 0])
        rotate([90,0,0])
            mono_rounded_cube(dimensions = [face_width, base_height, 60], radius = 9, $fn = 100);

    // We draw a face as the difference between:
    // - 1) the convex hull of:
    //   - a) a rounded cube for the bevel that protrudes from the face
    //   - b) a rounded cube for the outside edge of the face
    // - 2) the union of:
    //   - a) a screen recess
    //   - b) a floppy drive cutout
    //   - c) a logo stamp
    rotate([-10, 0, 0])
        translate([0, -chin_depth, neck_curve_radius + base_height - 0.5])
            difference() {
        // the face itself
        hull() {
            translate([-face_width / 2, 5, 0]) {
                dual_rounded_cube(dimensions = [face_width, 30, face_height], radius1 = 9, radius2 = 1.5, $fn = 100);
            }
            translate([-bevel_width / 2, 0, bevel_to_edge_z]) {
                dual_rounded_cube(dimensions = [bevel_width, 30, bevel_height], radius1 = 6, radius2 = 1, $fn = 100);
            }
        }
        
        // cut the screen recess, etc. from the face
        union() {
            // the screen recess
            hull() {
                translate(
                    [
                        - screen_recess_dimensions[0] / 2,
                        - 4, // around half of the screen recess radius
                        screen_recess_z  // z offset of the bottom of the screen recess
                    ]) {
                    rounded_cube(
                        dimensions = screen_recess_dimensions,
                        radius = screen_recess_radius,
                        $fn = 100
                    );
                }
                translate([-inner_width / 2, 0, screen_recess_z + recess_taper]) {
                    mono_rounded_cube(
                        dimensions = [inner_width, recess_taper_depth, inner_height],
                        radius = screen_recess_inner_radius,  $fn = 100
                    );
                }
            }
        }
    }
}

plus_face();