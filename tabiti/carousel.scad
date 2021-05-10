thickness = 3.75;
inner = 25.5 / 2;
centres = 88 / 2;

$fn = 100;

module clip() {
    translate([0, inner, 0])
    difference() {
        cylinder(r = inner + thickness, h = thickness, $fn = $fn);
        union() {
            cylinder(r = inner, h = thickness, $fn = $fn);
            translate([-inner + thickness, 0, 0])
                cube([2 * (inner - thickness), 2 * inner, thickness]);
        }
    }
}


module carousel() {
    difference() {
        for(angle = [0 : 60 : 360]) {
            rotate([0, 0, angle]) {
                cube([10, centres, thickness]);
                translate([5, centres, 0]) clip();
            }
        }
        cylinder(r = 4, h = thickness);
    }
}

carousel();