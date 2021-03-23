$fn = 30;

module plug_mould(plug_radius = 9, wall = 1, height = 40, pipe_radius = 4, positions = [-4.5, 4.5], bottom = false, $fn = $fn) {
    bottom_offset = bottom ? 3 * wall : 0;
    total_height = height + bottom_offset;
    
    difference() {
        cylinder(r = plug_radius + wall, h = total_height, $fn = $fn);
        union() {
            translate([0, 0, bottom_offset]) cylinder(r = plug_radius, h = height, $fn = $fn);
            if (bottom) {
                for(offset = positions) {
                    translate([offset, 0, 0]) cylinder(r = pipe_radius, h = height);
                }
            }
            translate([0, 0, (height - 10) + (3 * wall)]) rotate([0,90, 0]) cylinder(r = pipe_radius, h = height);
        }
    }
}

module plug_lid(plug_radius = 9, wall = 1, height = 40, pipe_radius = 4, positions = [-4.5, 4.5], $fn = $fn) {
    union() {
        cylinder(r = plug_radius + wall, h = wall);
        cylinder(r = plug_radius - 0.1, h = wall * 2);
        for(offset = positions) {
            translate([offset, 0, wall * 2]) cylinder(r = 2.5, h = wall * 4);
        }
    }
}

plug_mould();