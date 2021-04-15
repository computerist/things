$fn = 100;

module chamber_inner(chamber_radius = 30, pimple_radius = 5) {
    union () {
        difference() {
            sphere(r = chamber_radius, $fn = $fn);
            translate([0, 0, -chamber_radius]) cylinder(r = chamber_radius, h = chamber_radius, $fn = $fn);
        }
        translate([0, 0, chamber_radius]) sphere(r = pimple_radius, $fn = $fn);
    }
}

module chamber(chamber_radius = 30, pimple_radius = 5, thickness = 2) {
    difference() {
        minkowski() {
            chamber_inner(
                chamber_radius = chamber_radius,
                pimple_radius = pimple_radius
            );
            sphere(r = thickness);
        };
        union() {
            chamber_inner(
                chamber_radius = chamber_radius,
                pimple_radius = pimple_radius
            );
            translate([0, 0, - thickness]) cylinder(r = chamber_radius + thickness, h = thickness);
        }
    }
}

chamber();