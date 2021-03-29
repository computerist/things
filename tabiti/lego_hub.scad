spindle_dia = 5;
inner = 1.85;
$fn = 100;



module spindle_piece (spindle_dia = spindle_dia, inner = inner, height) {
    intersection() {
        translate([-spindle_dia / 2, -inner / 2, 0]) cube([spindle_dia, inner, height]);
        cylinder(r = spindle_dia / 2, h = height, $fn = $fn);
    }
}

module lego_spindle (height) {
    union() {
        spindle_piece (height = height);
        rotate([0, 0, 90]) spindle_piece (height = height);
    }
}

module lego_hub (hub_dia = 7, height = 10) {
    difference() {
        cylinder(r = hub_dia / 2, h = height, $fn = $fn);
        lego_spindle(height = height);
    }
}

lego_hub();
//spindle_piece(height = 10);