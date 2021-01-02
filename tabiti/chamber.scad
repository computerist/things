module chamber(inner = 11.5, outer = 180, height = 100, thickness = 2, $fn = 30) {
    difference() {
        cylinder(r = inner + thickness, h = height, $fn = $fn);
        cylinder(r = inner, h = height, $fn = $fn);
    }
    difference() {
        cylinder(r1 = 100 + thickness, r2 = inner + thickness, h = height - thickness, $fn = $fn);
        cylinder(r1 = 100, r2 = inner, h = height - thickness, $fn = $fn);
    }
    difference() {
        cylinder(r = outer + thickness, h = height, $fn = $fn);
        union() {
            cylinder(r = outer, h = height, $fn = $fn);
            for (angle = [0 : 60 : 360]) {
                rotate([0, 0, angle]) {
                    translate([outer, 0, height / 2]) rotate([0, 90, 0]) {
                        for(offset = [-1, 1]) {
                            translate([offset * 15, 0, 0]) cylinder(r = 2, h = 3 * thickness, center = true);
                        }
                        cylinder(r = 7.5, h = 3 * thickness, center = true);
                    }
                }
            }
        }
    }
    difference() {
        cylinder(r = outer + thickness, h = thickness, $fn = $fn);
        cylinder(r = inner, h = thickness, $fn = $fn);
    }
    
    for (angle = [0 : 60 : 360]) {
        rotate([0, 0, angle]) {
            translate([0, -1 * (outer - 5), 0]) cylinder(r = 5, h = height - thickness);
            translate([0, -1 * (inner + 5), 0]) cylinder(r = 5, h = height - thickness);
        }
    }
}

chamber($fn = 100);