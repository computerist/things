main_radius = 22.5;
neck_radius = 9.5;
neck_length = 10;
taper_length = 25;
entry_radius = 3;
entry_offset = 4.5;
flange_depth = 10;
wall = 2;
$fn = 200;

module cylinder_bag_lid(main_radius = main_radius, neck_radius = neck_radius, neck_length = neck_length, taper_length = taper_length, entry_radius = entry_radius, flange_depth = flange_depth, wall = wall) {
    difference() {
        union() {
            translate([0, 0, neck_length]) cylinder(r1 = neck_radius, r2 = main_radius, h = taper_length);
            translate([0, 0, neck_length + taper_length]) cylinder(r = main_radius, h = flange_depth);
            cylinder (r = neck_radius, h = neck_length, $fn = $fn);
        }
        union() {
            translate([0, 0, neck_length]) cylinder(r1 = neck_radius - wall, r2 = main_radius - wall, h = taper_length);
            translate([0, 0, neck_length + taper_length]) cylinder(r = main_radius - wall, h = flange_depth);
            translate([entry_offset, 0, 0]) cylinder(r = entry_radius, h = neck_length);
        }
    }
}

//cylinder_bag_lid();

module test_ring() {
    difference() {
        test_radius = 24.25;
        cylinder(r = test_radius, h = 10, $fn = $fn);
        cylinder(r = test_radius - 1, h = 10, $fn = $fn);
     } 
 }
 
 test_ring();