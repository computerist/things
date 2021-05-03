$fn = 200;
bolt_radius = 1.25;
flange_thickness = 4;

tube_inner_radius = 1.5;
tube_outer_radius = 2.75;

module lobes(from_centre = 20, count = 4, radius = bolt_radius, thickness = 2, flange = 0) {
    for (a = [0 : 360 / count : 360]) {
        rotate([0, 0, a]) translate([0, from_centre, 0]) cylinder(r = radius + flange, h = thickness);
    }
}

module chamber_form(chamber_radius = 30, pimple_radius = 5, wall = 0) {
    union () {
        difference() {
            sphere(r = chamber_radius + wall, $fn = $fn);
            translate([0, 0, -chamber_radius - wall]) cylinder(r = chamber_radius + wall, h = chamber_radius + wall, $fn = $fn);
        }
        translate([0, 0, chamber_radius + wall]) sphere(r = pimple_radius + wall, $fn = $fn);
    }
}

module plug(tube_inner_radius = tube_inner_radius, plug_height = 12.5, inner = false) {
    if (!inner) {
        union() {
            cylinder(r = tube_outer_radius, h = plug_height, $fn=$fn);
            translate([0, 0, plug_height - 5]) cylinder(r1 = tube_outer_radius, r2 = tube_outer_radius + 1, h = 2.5, $fn=$fn);
            translate([0, 0, plug_height - 2.5]) cylinder(r2 = tube_outer_radius, r1 = tube_outer_radius + 1, h = 2.5, $fn=$fn);
        }
    } else {
        union() {
            cylinder(r = tube_inner_radius, h = 20, $fn=$fn);
        }
    }
}

module chamber(chamber_radius = 30, pimple_radius = 5, thickness = 2, flange = 10, flange_thickness = flange_thickness) {
    difference() {
        union() {
            // main outer shell
            hull() chamber_form(
                chamber_radius = chamber_radius,
                pimple_radius = pimple_radius,
                wall = thickness
            );
            hull() {
                // flange
                cylinder(r = chamber_radius + flange, h = flange_thickness);
                // lobes
                lobes(thickness = flange_thickness, from_centre = chamber_radius + flange + bolt_radius, radius = bolt_radius, flange = 5);
            }
            // plug
            translate([0, 0, chamber_radius + pimple_radius]) plug();
        }
        union() {
            hull() chamber_form(
                chamber_radius = chamber_radius,
                pimple_radius = pimple_radius
            );
            translate([0, 0, - thickness]) cylinder(r = chamber_radius + thickness, h = thickness);
            // screw holes
            lobes(thickness = flange_thickness, from_centre = chamber_radius + flange + bolt_radius, radius = bolt_radius, flange = 0);
            // plug hole
            translate([0, 0, chamber_radius + pimple_radius - 5]) plug(inner = true, plug_height = 20);
        }
    }
}

chamber();