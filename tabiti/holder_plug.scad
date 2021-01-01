screws = [[-15,0], [15,0]];
plug_radius = 7.5;

screw_radius = 2;
plug_thickness = 2;

module inner(screws = screws, plug_radius = plug_radius) {
    difference() {
        hull() {
            cylinder(r = plug_radius + plug_thickness, h = plug_thickness);
            for (screw = screws) {
                translate([screw[0], screw[1], 0]) cylinder(r = screw_radius + plug_thickness, h = plug_thickness);
            }
        }
        union() {
            cylinder(r = plug_radius, h = plug_thickness);
            for (screw = screws) {
                translate([screw[0], screw[1], 0]) cylinder(r = screw_radius, h = plug_thickness);
            }
        }
    }
}

module outer(screws = screws, plug_radius = plug_radius) {
    for (screw = screws) {
        echo(screw);
    }
}

module mould(crews = screws, plug_radius = plug_radius) {
    difference() {
        minkowski() {
            hull() inner();
            cylinder (r = 3, h = 0.1);
        }
        translate([0, 0, 1]) inner();
    }
    
}

mould();