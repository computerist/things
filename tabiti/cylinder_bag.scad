$fn = 200;
main_radius = 20;
thickness = 1;
height = 75;

module cylinder_bag_mould(
    main_radius = main_radius,
    height = height,
    thickness = thickness) {
    difference() {
        cylinder(r = main_radius + thickness, h = height, $fn = $fn);
        cylinder(r = main_radius, h = height, $fn = $fn);
    }
}

cylinder_bag_mould();