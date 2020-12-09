module straight_track(gauge = 100, length = 380) {
    for (reflect = [0, 1])
        mirror([reflect, 0, 0])
            translate([gauge / 2, length, 0])
                rotate([90, 0, 0])
                    linear_extrude(height = length) import("track_xs.dxf");
}

module curve(angle = 12, gauge = 100, radius = 2000) {
    steps = radius / 10;
    translate([-radius + (gauge / 2), 0, 0]) rotate_extrude(angle = angle, $fn = steps) union() {
        translate([radius - gauge, 0, 0]) mirror([1, 0, 0]) import("track_xs.dxf");
        translate([radius, 0, 0]) import("track_xs.dxf");
    }
}


translate([0, -380, 0]) straight_track(gauge = 80);

curve(gauge = 80);