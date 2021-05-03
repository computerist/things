$fn = 100;

module collar(height = 12, inner = 4.5, thickness = 2) {
    difference() {
        cylinder(r = inner + thickness, h = height, $fn = $fn);
        cylinder(r = inner, h = height, $fn = $fn);
    }
}

collar(inner = 19.5/2, height = 75, thickness = (23 /2) - (19.5 / 2));