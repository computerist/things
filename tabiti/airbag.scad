$fn = 30;

module airbag(main_radius = 22.5, neck_join = 100, neck_radius = 6, main_height = 75, neck_height = 10,
$fn = $fn) {
    cylinder(r= neck_radius, h=neck_join + neck_height, $fn = $fn);
    cylinder(r= main_radius, h=main_height, $fn = $fn);
    translate([0, 0, main_height])
        cylinder(r1 = main_radius, r2 = neck_radius, h = neck_join - main_height, $fn = $fn);
}

module airbag_mould() {
    difference() {
        minkowski() {
            airbag();
            cylinder(r = 1, h = 1);
        };
        airbag();
    };
}

airbag_mould();