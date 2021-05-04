$fn = 100;

module socket(inner = 52 / 2, thickness = 1, height = 110, flange = 5, $fn = $fn) {
    difference() {
        union() {
            cylinder(r = inner + thickness, h = height, $fn = $fn);
            translate([0, 0, height]) {
                translate([0, 0, -1]) cylinder(r1 = inner + thickness, r2 = inner + (thickness * 2), h = thickness);
                cylinder(r = inner + (thickness * 2), h = flange);
            }
        }
        union() {
            cylinder(r = inner, h = height, $fn = $fn);
            translate([0, 0, height]) {
                cylinder(r = inner + thickness, h = flange);
            }
        }
    }
}

module base(inner = 52 / 2, thickness = 1, flange = 5, $fn = $fn) {
    difference() {
        cylinder(r = inner + (thickness * 2), h = flange);
        translate([0, 0, thickness]) cylinder(r = inner + thickness, h = flange);

    }
}

base();