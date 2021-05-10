$fn = 100;

module taper_plug(taper_small = 22 / 2, taper_large = 25 / 2, height = 8, hole = 3.5 / 2) {
    difference() {
        cylinder(r1 = taper_small, r2 = taper_large, h = height, $fn = $fn);
        cylinder(r = hole, h = height, $fn = $fn);
        }
}

module taper_plug_mould(taper_small = 22 / 2, taper_large = 25 / 2, height = 8, hole = 3.5 / 2, thickness = 2) {
    difference() {
        translate([0, 0, -2]) cylinder(r1 = taper_small + thickness, r2 = taper_large + thickness, h = height + thickness);
            
        taper_plug(taper_small = taper_small, taper_large = taper_large, height = height, hole = hole);
    }
}

taper_plug_mould(height = 15, thickness = 1);
//taper_plug(height = 15);