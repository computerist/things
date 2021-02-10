module chamber(inner = 11.5, outer = 100, height = 80, thickness = 1.5, $fn = 100, base = true, pad = 0 ) {
    if (base) {
        difference() {
            cylinder(r = inner + thickness + pad, h = height, $fn = $fn);
            cylinder(r = inner - pad, h = height, $fn = $fn);
        }
        difference() {
            cylinder(r1 = 60 + thickness, r2 = inner + thickness, h = height - thickness, $fn = $fn);
            cylinder(r1 = 60, r2 = inner, h = height - thickness, $fn = $fn);
        }
        difference() {
            cylinder(r = outer + thickness + pad, h = height, $fn = $fn);
            union() {
                cylinder(r = outer - pad, h = height, $fn = $fn);
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
                translate([0, -1 * (outer - 5), 0]) cylinder(r = 5 + pad, h = height - thickness);
                translate([0, -1 * (inner + 5), 0]) cylinder(r = 5 + pad, h = height - thickness);
            }
        }
    } else {
        difference() {
            translate([0, 0, height - thickness * 3]) cylinder(r = pad + outer + (thickness * 2), h = (thickness * 4), $fn = $fn);
            union() {
                chamber(inner = inner, outer = outer, height = height, thickness = thickness, $fn = $fn, base = true, pad = pad);
                for (angle = [0 : 60 : 360]) {
                    rotate([0, 0, angle]) {
                        translate([0, -1 * (outer - 5), 0]) cylinder(r = 2, h = height * 2);
                        translate([0, -1 * (inner + 5), 0]) cylinder(r = 2, h = height * 2);
                    }
        }
            }
        }
    }
}

chamber($fn = 100, base = false, pad = 0.75);