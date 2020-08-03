module bracket(r = 2, thickness = 3, padding = 5) {
    difference() {
        union() {
            cube([r * 2 + padding * 2, r * 2 + padding * 2, thickness]);
            translate([-thickness, 0, 0]) {
                cube([thickness, r * 2 + padding * 2, thickness + r * 2 + padding * 2]);
            }
        }
        union() {
            translate([padding + r, padding + r, 0]) {
                cylinder(r1 = r, r2 = r + thickness, h = thickness);
            }
            rotate([0, 270, 0]) 
            translate([thickness + padding + r, padding + r, 0]) {
                cylinder(r2 = r, r1 = r + thickness, h = thickness);
            }
        }
    }
}

bracket();