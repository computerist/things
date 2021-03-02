
// rounded edges on the sides, square-edged top and bottom face
module mono_rounded_cube(dimensions = [200, 150, 300], radius = 3, $fn = 30) {
    minkowski() {
        translate([radius, radius, 0]) {
            cube([dimensions[0] - (radius *  2), dimensions[1] - (radius * 2), dimensions[2] - 1]);
        }
        cylinder(r = radius, h = 1);
    }
}

difference() {
    union() {
        translate([-6, -6, 0]) mono_rounded_cube(dimensions = [12,12,5], radius = 0.5);
        translate([-6.2, -6.2, 0]) mono_rounded_cube(dimensions = [12.4, 12.4, 1.5], radius = 0.7);
    }
    union() {
        cylinder(r = 4, h = 2.5, $fn = 30);
        cylinder(r = 2, h = 6, $fn = 30);
    }
}