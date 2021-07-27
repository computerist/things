include<../common/hexnut.scad>;
$fn = 40;
outer_dia = 13;
hinge_thickness = 3.1;
nut_head_depth = 3.5;

module nut_thing(thread_dia = 6.5, length = 14.5, flats = 9, flange_dia = 10.3, flange_thickness = 1) {
  hexnut(flats = 9, nut_head_depth = 3.5);
  cylinder(r = thread_dia / 2, h = length, $fn = $fn);
  cylinder(r = flange_dia / 2, h = flange_thickness, $fn = $fn);
}

module hinge_flange(outer_dia = outer_dia, inner_dia = 5,  offset = 2) {
  rotate([90, 0, 0]) difference(){
    union() {
      translate([0, (outer_dia / 2) + offset, 0]) cylinder(r = outer_dia / 2, h = hinge_thickness, $fn = $fn);
      translate([-outer_dia / 2, 0, 0]) cube([outer_dia, (outer_dia / 2) + offset, hinge_thickness]);
    }

   translate([0, (outer_dia / 2) + offset, 0]) cylinder(r = inner_dia / 2, h = hinge_thickness, $fn = $fn);
  }
}

module hinge(hinge_gap = 3.5, thickness = 4) {
  width = (hinge_thickness * 2) + hinge_gap;

  for (m = [0, 1]) {
    mirror([0, m, 0]) translate([0, - hinge_gap / 2, thickness]) hinge_flange();
  }
  
  difference() {
    cylinder(r = 16.3 / 2, h = thickness, $fn = $fn);
    cylinder(r = 10.5 / 2, h = nut_head_depth, $fn = $fn);
  }
}

// nut_thing();
// hinge_flange();
hinge();
