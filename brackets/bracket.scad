$fn = 100;

module bracket(r = 2, thickness = 3, padding = 5, countersink = true) {
    difference() {
        union() {
            cube([r * 2 + padding * 2, r * 2 + padding * 2, thickness]);
            translate([-thickness, 0, 0]) {
                cube([thickness, r * 2 + padding * 2, thickness + r * 2 + padding * 2]);
            }
        }
        union() {
            upper_radius = countersink ? r + thickness : r;
            translate([padding + r, padding + r, 0]) {
                cylinder(r1 = r, r2 = upper_radius, h = thickness, $fn = $fn);
            }
            rotate([0, 270, 0]) 
            translate([thickness + padding + r, padding + r, 0]) {
                cylinder(r2 = r, r1 = upper_radius, h = thickness, $fn = $fn);
            }
        }
    }
}

bracket(r = 3, padding = 5, countersink = false);