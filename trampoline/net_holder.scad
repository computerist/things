module clip(clip_height = 30, clip_inner = 25, clip_width = 8, depth = 40, entry_height = 12) {
    rotate([0, 270, 0])
    union() {
        translate([clip_width / 2, 0, 0]) cylinder(r = clip_width / 2, h = depth, center = true);
        translate([clip_inner - (clip_width / 2), 0, 0]) cylinder(r = clip_width / 2, h = depth, center = true);
        translate([clip_width / 2, - clip_width / 2 , - depth / 2]) cube([clip_inner - clip_width, clip_width, depth]);
    }
    translate([-depth / 2, 0, clip_inner - entry_height - clip_width]) cube([depth, depth, clip_width]);
}

module net_holder(outer_radius = 15, sleeve = 30, $fn = 40) {
    clip_height = 30;
    
    difference() {
        // outer shape
        union() {
            sphere(r = outer_radius, $fn = $fn);
            cylinder(r = outer_radius, h = sleeve + clip_height, $fn = $fn);
        }
        union() {
            translate([0, 0, clip_height + 2.5]) cylinder(r = (27 / 2), h = 40);
            clip();
        }
    }
    translate([0, 0, clip_height]) cylinder (r = 9.5, h = 34);
}

net_holder();
//clip();