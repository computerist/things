module hinge_inner(hinge_radius = 10, hinge_thickness = 5, plate_thickness = 2, web = 10) {
    hinge_centre = [0, - hinge_radius, hinge_radius];
    hull() {
        translate([-hinge_thickness / 2, 0, 0]) cube([hinge_thickness, web, plate_thickness]);
        translate(hinge_centre) {
            rotate([0, 90, 0]) cylinder(r = hinge_radius, h = hinge_thickness, center = true, $fn = 50);
        }
    }
    translate(hinge_centre) sphere(r = hinge_radius / (3/2), $fn = 50);
}

module hinge_outer(hinge_radius = 10, hinge_thickness = 5, peg_width = 22, peg_depth = 7.5, peg_wall_thickness = 2, peg_wall_height = 10) {
    // make a cylinder and cut out the hinge inner
    hinge_centre = [0, -hinge_radius, hinge_radius];
    outer_width = hinge_thickness * 3;
    difference() {
        union() {
            translate([(-outer_width / 2) - peg_width - peg_wall_thickness, -(hinge_radius * 2) - 4, 0]) {
                difference() {
                    cube([peg_width + (peg_wall_thickness * 2), peg_depth + (peg_wall_thickness * 2), peg_wall_height]);
                    translate([peg_wall_thickness, peg_wall_thickness, 0]) cube([peg_width, peg_depth, peg_wall_height]);
                }
            }
            mirror([1, 0, 0]) translate([(-outer_width / 2) - peg_width - peg_wall_thickness, -(hinge_radius * 2) - 4, 0]) {
                difference() {
                    cube([peg_width + (peg_wall_thickness * 2), peg_depth + (peg_wall_thickness * 2), peg_wall_height]);
                    translate([peg_wall_thickness, peg_wall_thickness, 0]) cube([peg_width, peg_depth, peg_wall_height]);
                }
            }

            translate([-outer_width / 2, -(hinge_radius * 2) - 4, 0]) cube([outer_width, 4  + hinge_radius, hinge_radius * 2]);
            translate(hinge_centre) {
                rotate([0, 90, 0]) cylinder(r = hinge_radius, h = outer_width, center = true, $fn = 50);
            }
        }
        union() {
            translate([-(hinge_thickness + 0.3) / 2, -2 * (hinge_radius + 0.15), 0])
                cube([(hinge_thickness + 0.3), (hinge_radius + 0.15), (hinge_radius + 0.15) * 2]);
            hinge_inner(hinge_radius + 0.15, hinge_thickness + 0.3);
            translate(hinge_centre) cylinder(r = (hinge_radius / (3/2)) - 0.5, h = hinge_radius);
        }
    }
}

module mirror_piece(width = 50, height = 50, thickness = 2, hinge_thickness = 5, hinge_radius = 10) {
    translate([-width / 2, -2, 0]) cube([width, height, thickness]);
    hinge_inner(hinge_radius, hinge_thickness, plate_thickness = thickness, web = height / 2);
}

mirror_piece();

translate([0, -21, 0])
    hinge_outer();