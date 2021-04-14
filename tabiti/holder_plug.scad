screws = [[-15,0], [15,0]];
pipe_max_radius = 5;
plug_max_radius = 7.5;
plug_taper = 2;
plug_depth = 5;

tube_inner_radius = 1.75;
tube_outer_radius = 2.5;

screw_radius = 2;
plug_thickness = 5;

$fn = 30;

module inner(screws = screws, plug_max_radius = plug_max_radius, screw_radius = screw_radius) {
    difference() {
        hull() {
            cylinder(r = plug_max_radius + plug_thickness, h = plug_thickness);
            for (screw = screws) {
                translate([screw[0], screw[1], 0]) cylinder(r = screw_radius + plug_thickness, h = plug_thickness);
            }
        }
        union() {
            cylinder(r = plug_max_radius, h = plug_thickness);
            for (screw = screws) {
                translate([screw[0], screw[1], 0]) cylinder(r = screw_radius, h = plug_thickness);
            }
        }
    }
}

module outer(screws = screws, pipe_max_radius = pipe_max_radius, plug_max_radius = plug_max_radius, screw_radius = screw_radius) {
    difference() {
        hull() {
            cylinder(r = plug_max_radius + plug_thickness, h = plug_thickness);
            for (screw = screws) {
                translate([screw[0], screw[1], 0]) cylinder(r = screw_radius + plug_thickness, h = plug_thickness);
            }
        }
        union() {
            cylinder(r = pipe_max_radius, h = plug_thickness);
            for (screw = screws) {
                translate([screw[0], screw[1], 0]) cylinder(r = screw_radius, h = plug_thickness);
            }
        }
    }
}

module seal_mould(screws = screws, plug_max_radius = plug_max_radius, screw_radius = screw_radius) {
    difference() {
        minkowski() {
            hull() inner(screws = screws, plug_max_radius = plug_max_radius, screw_radius = screw_radius);
            cylinder (r = 3, h = 0.1);
        }
        union() {
            translate([0, 0, 3]) inner(screws = screws, plug_max_radius = plug_max_radius, screw_radius = screw_radius);
            translate([0, 0, 1.5]) difference() {
                minkowski() {
                    hull() inner(screws = screws, plug_max_radius = plug_max_radius, screw_radius = screw_radius);
                    cylinder (r = 1.5, h = 0.1);
                   }

                hull() inner(screws = screws, plug_max_radius = plug_max_radius, screw_radius = screw_radius);
            }
        }
    }
    
}

module plug(tube_inner_radius = tube_inner_radius, plug_depth = plug_depth, plug_taper = plug_taper, plug_max_radius = plug_max_radius) {
    difference() {
        union() {
            cylinder(r = plug_max_radius - plug_taper, h = 1, $fn=$fn);
            cylinder(r = tube_outer_radius, h = 20, $fn=$fn);
            translate([0, 0, 15]) cylinder(r1 = tube_outer_radius, r2 = tube_outer_radius + 1, h = 2.5, $fn=$fn);
            translate([0, 0, 17.5]) cylinder(r2 = tube_outer_radius, r1 = tube_outer_radius + 1, h = 2.5, $fn=$fn);
            cylinder(r = plug_max_radius - plug_taper - 1, h = plug_depth, $fn=$fn);
            translate([0, 0, plug_depth - plug_taper]) cylinder(r1 = plug_max_radius - plug_taper - 1, r2 = plug_max_radius, h = plug_taper + 1, $fn=$fn);
        }
        union() {
            cylinder(r = tube_inner_radius, h = 20, $fn=$fn);
        }
    }
}

module plug_mould(screws = screws, plug_depth = plug_depth, plug_taper = plug_taper, plug_max_radius = plug_max_radius) {
    difference() {
        cylinder(r1 = plug_max_radius - plug_taper + 1.5, r2 = plug_max_radius + 1.5, h = plug_depth);
        cylinder(r1 = plug_max_radius - plug_taper + 0.5, r2 = plug_max_radius + 0.5, h = plug_depth);
    }
}

module mould_base(screws = screws, plug_depth = plug_depth, plug_taper = plug_taper, plug_max_radius = plug_max_radius, $fn = $fn) {
    difference() {
        cylinder(r = plug_max_radius - plug_taper + 2.5, h = 2, $fn = $fn);
        translate([0, 0, 1]) difference() {
            cylinder(r = plug_max_radius - plug_taper + 2, h = 2, $fn = $fn);
            cylinder(r = tube_inner_radius - 0.5, h = 2, $fn = $fn);
        }
    }
}

//seal_mould(screw_radius = 2);
//outer();

plug();