$fn = 100;

module spacer(depth = 15, inner_dia = 4, outer_dia = 20) {
    difference() {
        cylinder(h = depth, r = outer_dia / 2, $fn = $fn);
        cylinder(h = depth, r = inner_dia / 2, $fn = $fn);
    }
}

spacer();