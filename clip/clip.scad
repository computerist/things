module clip(depth = 5) {
    linear_extrude(height = depth)
        import("clip.dxf");
}

module cutout1(depth = 2.51) {
    linear_extrude(height = depth)
        import("cutout1.dxf");
}

module cutout2(depth = 2.51) {
    linear_extrude(height = depth)
        import("cutout2.dxf");
}

module cutout() {
    union() {
        translate([0, 0, -0.01]) cutout1();
        translate([0, 0, 2.49]) cutout2();
    }
}

module outer() {
    difference() {
        clip();
        minkowski() {
            cutout();
            cylinder(r = 0.25, h = 0.5, center = true);
        }
    }
}

cutout();

outer();