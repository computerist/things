main_radius = 24.5;
thickness = 1;
bit_radius = 5 / 2;
bit_depth = 20;

$fn = 30;

module spinner(height = 50) {
    difference() {
        cylinder(r = main_radius + (thickness * 2), h = height, $fn = $fn);
        union() {
            translate([0, 0, bit_depth + thickness * 5]) cylinder(r = main_radius + thickness, h = height, $fn = $fn);
            translate([0, 0, bit_depth + thickness]) cylinder(r = main_radius, h = height, $fn = $fn);
            cylinder(r = bit_radius, h = bit_depth, $fn = $fn);
        }
    }
}


spinner();