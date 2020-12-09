module chamber(inner = 100, outer = 200, height = 100, thickness = 2, $fn = 30) {
    difference() {
        cylinder(r = inner + thickness, h = height, $fn = $fn);
        cylinder(r = inner, h = height, $fn = $fn);
    }
    difference() {
        cylinder(r = outer + thickness, h = height, $fn = $fn);
        cylinder(r = outer, h = height, $fn = $fn);
    }
    difference() {
        cylinder(r = outer + thickness, h = thickness, $fn = $fn);
        cylinder(r = inner, h = thickness, $fn = $fn);
    }
    translate([0, 0, height - thickness]) cylinder(r = inner, h = thickness, $fn = $fn);
}

chamber($fn = 100);