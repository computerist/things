hinge_length = 40;
door_thickness = 18;
pin_dia = 6.5;
offset = 4;
$fn = 100;
screw_positions = [10, 30];
screw_radius = 1.5;
screw_head_radius = 4;
screw_countersink_depth = 4;


module hinge(hinge_length = hinge_length, door_thickness = door_thickness, pin_dia = pin_dia, offset = offset) {
    
    //plate
    width = door_thickness;
    hinge_radius = width / 2;
    centre_height = offset + hinge_radius;
    difference() {
        union() {
            translate([-width / 2, 0, 0]) 
                cube([width, hinge_length, centre_height]);
            translate([0, 0, centre_height])
                rotate([-90, 0,0])
                    cylinder(r = hinge_radius,
                             h = hinge_length,
                             $fn = $fn);
            }
        union() {
            translate([0, 0, centre_height])
                rotate([-90, 0,0])
                    cylinder(r = pin_dia / 2,
                             h = hinge_length,
                             $fn = $fn);
            for (screw_pos = screw_positions) {
                translate([0, screw_pos, 0]) {
                    cylinder(r = screw_radius, h = 50, $fn = $fn);
                    translate([0, 0, offset]) cylinder(r1 = screw_radius, r2 = screw_head_radius, h = screw_countersink_depth, $fn = $fn);
                    translate([0, 0, offset + screw_countersink_depth]) cylinder(r = screw_head_radius, h = hinge_radius * 2, $fn = $fn);
                }
            }
        }
    }
}

hinge();