// pitch = 1.562;
pitch = 200 / 128;
tooth_base = 1.2;
tooth_tip = 0.3;
tooth_height = 3.20 - 2.22;
length = 200;
rail_width = 2.5;

flare_width = 3.5;
flare_height = 0.82;

rail_height = 2.4 - flare_height;

module tooth() {
    hull() {
        translate([-rail_width / 2, -tooth_base / 2, 0])
            cube([rail_width, tooth_base, 0.1]);
        translate([-rail_width / 2, -tooth_tip / 2, tooth_height - 0.1])
            cube([rail_width, tooth_tip, 0.1]);
    }
}

module track() {
    translate([-flare_width / 2, 0, - flare_height]) cube([flare_width, length, flare_height]);
    translate([-rail_width / 2, 0, 0]) cube([rail_width, length, rail_height]);
    for(y = [(tooth_base / 2) : pitch : length]) {
        translate([0, y, rail_height]) tooth();
    }
}

track();