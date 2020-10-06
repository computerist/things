default_depth = 7;

module clip(depth = default_depth) {
    linear_extrude(height = depth)
        import("clip.dxf");
}

module cutout1(depth = (default_depth / 2) + 0.01) {
    linear_extrude(height = depth)
        import("cutout1.dxf");
}

module cutout2(depth = (default_depth / 2) + 0.01) {
    linear_extrude(height = depth)
        import("cutout2.dxf");
}

module cutout() {
    union() {
        translate([0, 0, -0.01]) cutout1();
        translate([0, 0, default_depth / 2]) cutout2();
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