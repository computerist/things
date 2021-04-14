$fn = 200;

module hemisphere_form(radius = 50, thickness = 1, flange = 10, flange_thickness = 2, inner = true, outer = true) {
    difference() {
        if (outer) union() {
            // flange
            cylinder(r = radius + flange, h = flange_thickness, $fn = $fn);
            // outside of hemisphere
            intersection() {
                cylinder(r = radius, h = radius, $fn = $fn);
                sphere(r = radius, $fn = $fn);
            }
        }
        if (inner) union() {
            // inside of hemisphere()
            intersection() {
                inner_r = radius - thickness;
                cylinder(r = inner_r, h = inner_r, $fn = $fn);
                sphere(r = inner_r, $fn = $fn);
            }        
        }
    }
}

module hemisphere_mould(inner = true, outer = true, extra = 5, flange = 10, radius = 50) {
    if (outer) difference() {
        intersection() {
            translate([0, 0, -extra]) cylinder(r = radius + flange + extra * 2, h = radius + extra + 1);
            translate([0, 0, -extra]) sphere(r = radius + flange + extra * 2);
        }
        union() {
            hemisphere_mould (inner = true, outer = false, extra = extra, flange = flange, radius = radius);
            hemisphere_form (radius = radius, flange = flange, outer = true, inner = false);
        }
    }
    if (inner) union() {
        translate([0, 0, -extra]) cylinder(r = radius + flange + extra / 2, h = extra);
        intersection() {
            translate([0, 0, -extra]) cylinder(r = radius + flange + extra, h = radius + extra);
            hemisphere_form(radius = radius, flange = flange, outer = false, inner = true);
        }
    }
}

hemisphere_mould(outer = false, radius = 30);
//translate([0,0, 30]) hemisphere_mould(inner = false);