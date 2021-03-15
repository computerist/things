
pipe_max_radius = 5;
plug_max_radius = 8.5;
plug_taper = 0;
plug_depth = 15;

tube_inner_radius = 1.5;
tube_outer_radius = 2.5;

screw_radius = 2;
plug_thickness = 5;

$fn = 30;

module chamber_plug(tube_inner_radius = tube_inner_radius, plug_depth = plug_depth, plug_taper = plug_taper, plug_max_radius = plug_max_radius) {
    difference() {
        union() {
            cylinder(r = plug_max_radius - plug_taper, h = 1, $fn=$fn);
            translate([0, 4.5, 0]) cylinder(r = tube_outer_radius, h = 30, $fn=$fn);
            translate([0, 4.5, 25]) cylinder(r1 = tube_outer_radius, r2 = tube_outer_radius + 1, h = 2.5, $fn=$fn);
            translate([0, 4.5, 27.5]) cylinder(r2 = tube_outer_radius, r1 = tube_outer_radius + 1, h = 2.5, $fn=$fn);
            translate([0, -4.5, 0]) cylinder(r = tube_outer_radius, h = 30, $fn=$fn);
            translate([0, -4.5, 25]) cylinder(r1 = tube_outer_radius, r2 = tube_outer_radius + 1, h = 2.5, $fn=$fn);
            translate([0, -4.5, 27.5]) cylinder(r2 = tube_outer_radius, r1 = tube_outer_radius + 1, h = 2.5, $fn=$fn);
            cylinder(r = plug_max_radius - plug_taper - 1, h = plug_depth, $fn=$fn);
            translate([0, 0, plug_depth - plug_taper]) cylinder(r1 = plug_max_radius - plug_taper - 1, r2 = plug_max_radius, h = plug_taper + 1, $fn=$fn);
            translate([0, 0, (plug_depth / 3) - plug_taper]) cylinder(r1 = plug_max_radius - plug_taper - 1, r2 = plug_max_radius, h = plug_taper + 1, $fn=$fn);
        }
        union() {
            translate([0, 4.5, 0]) cylinder(r = tube_inner_radius, h = 30, $fn=$fn);
            translate([0, -4.5, 8]) cylinder(r = tube_inner_radius, h = 30, $fn=$fn);
            translate([0, -4.5, 8]) sphere(r = tube_inner_radius, $fn=$fn);
            translate([0, -4.5, 8]) rotate([90,0,0]) cylinder(r = tube_inner_radius, h = 30, $fn=$fn);
        }
    }
}

chamber_plug();