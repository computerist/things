include<lego_hub.scad>

$fn = 200;

main_radius = 20;
neck_radius = 8.5;
main_height = 75;
neck_height = 10;


module airbag(main_radius = main_radius, neck_radius = neck_radius, main_height = main_height, neck_height = neck_height,
$fn = $fn) {
    neck_join = main_height + 25;
    cylinder(r= neck_radius, h=neck_join + neck_height, $fn = $fn);
    cylinder(r= main_radius, h=main_height, $fn = $fn);
    translate([0, 0, main_height])
        cylinder(r1 = main_radius, r2 = neck_radius, h = neck_join - main_height, $fn = $fn);
}

module airbag_mould(main_height = main_height) {
    difference() {
        minkowski() {
            airbag(main_height = main_height);
            cylinder(r = 1, h = 1);
        };
        union() {
            translate([-4.5, 0, 0]) cylinder(r = 4, h = main_height * 2);
            airbag(main_height = main_height);
        }
    };
}

module mould_lid(main_radius = main_radius, neck_radius = neck_radius) {
    minkowski() {
        cylinder(r= main_radius, h = 1, $fn = $fn);
        cylinder(r = 1, h = 1, $fn = $fn);
    }
    cylinder(r = main_radius, h = 4, $fn = $fn);
}

// airbag_mould(main_height = 60);
difference() {
    union() {
        translate([0,0,5]) mould_lid();
        cylinder(r1 = 6, r2 = main_radius, h = 5, $fn = $fn);
    }
    lego_spindle(height = 20);
}