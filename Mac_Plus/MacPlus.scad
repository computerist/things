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
                cube([dimensions[0] - (combined_radius *  2) - 1, dimensions[1] - (radius2 * 2), dimensions[2] -  (combined_radius * 2)]);
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

// A sketch of a Macintosh Plus main body
difference() {
    hull() {
        translate([-260 / 2, 5, 0]) {    
            dual_rounded_cube(dimensions = [260, 150, 330], radius1 = 9, radius2 = 1.5, $fn = 100);
        }
        translate([-230 / 2, 0, 20]) {
            dual_rounded_cube(dimensions = [230, 150, 290], radius1 = 6, radius2 = 1, $fn = 100);
        }
    }
    hull() {  
        translate([-200 / 2, -4, 140]) {
            rounded_cube(dimensions = [200, 7, 150], radius = 3, $fn = 100);
        }
        
        translate([-180 / 2, 0, 150]) {
            rounded_cube(dimensions = [180, 20, 130], r = 9,  $fn = 100);
        }
    }
}