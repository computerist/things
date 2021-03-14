$fn = 30;

module plug_mould(plug_radius = 9, wall = 1, height = 20, pipe_radius = 4, positions = [-4.5, 4.5], $fn = $fn) {
    difference() {
        cylinder(r = plug_radius + wall, h = height + (3 * wall), $fn = $fn);
        union() {
            translate([0, 0, wall * 3]) cylinder(r = plug_radius, h = height, $fn = $fn);
            for(offset = positions) {
                translate([offset,0,wall]) cylinder(r = pipe_radius, h = wall * 2);
            }
            translate([0, 0, (height * (2 / 3)) + (3 * wall)]) rotate([0,90, 0]) cylinder(r = pipe_radius, h = height);
        }
    }
}

plug_mould();