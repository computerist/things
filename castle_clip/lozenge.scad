module lozenge(radius = 4.5, depth = 18, length = 20, $fn = 50) {
    difference() {
        union() {
            cylinder(r = radius, h = length, $fn = $fn);
            translate([-radius, 0, 0]) cube([radius * 2, depth, length]);
            translate([0, depth, 0]) cylinder(r = radius, h = length, $fn = $fn);
        }
        union() {
            cube([radius * 2, depth + radius, length]);
        }
    }
}

module mid_section() {
    difference() {
        union() {
            // make the outer shell
            translate([15, 0, 0]) rotate([0, 270, 0]) lozenge(length = 30);
            translate([-15, 0, -5.5]) cube([30, 18, 2]);
        }
        union() {
            // subtract the wood
            mirror([1, 0, 0]) translate([21, 0, 0]) rotate([0, 270, 0]) lozenge(length = 20);
            translate([21, 0, 0]) rotate([0, 270, 0]) lozenge(length = 20);
        }
    }

    translate([10.5, 9, -4.5]) cylinder(r = 2, h = 4.5);
    mirror([1, 0, 0]) translate([10.5, 9, -4.5]) cylinder(r = 2, h = 4.5);
}


module corner_edge() {
    translate([22.5, 0, 0]) {
        difference() {
            union() {
                // make the outer shell
                translate([15, 0, 0]) rotate([0, 270, 0]) lozenge(length = 15+22.5);
                translate([-22.5, 0, -5.5]) cube([15+22.5, 18, 2]);
            }
            union() {
                // subtract the wood
                translate([20, 0, 0]) rotate([0, 270, 0]) lozenge(length = 20);
            }
        }

        translate([10.5, 9, -4.5]) cylinder(r = 2, h = 4.5);
    }
}

module corner() {
    rotate([0, 0, 270]) mirror([1, 0, 0]) corner_edge();
    corner_edge();
    difference() {
        sphere(r = 4.5, $fn = 50);
        cube([5, 5, 5]);
    }
}

mid_section();