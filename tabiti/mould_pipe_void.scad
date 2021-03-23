$fn = 30;

module mould_void(inner_radius = 2, outer_radius = 4, length = 20) {
    difference() {
        union() {
            cylinder(r = outer_radius, h = length - outer_radius, $fn = $fn);
            translate([0,0, length - outer_radius]) {
                sphere(r = outer_radius, $fn = $fn);
            }
        }
        translate([0, 0, length - outer_radius]) rotate([90, 0, 0]) {
            difference() {
                cylinder(r = outer_radius, h = outer_radius);
                cylinder(r = inner_radius, h = outer_radius);
            }
        }
    }
}

mould_void();