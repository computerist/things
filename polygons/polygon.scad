module polygon(side = 30, height = 1, width = 1, sides = 5, drawn = 0) {
    angle = 360 / sides;
    if (drawn < sides) {
        
        cylinder(r = width / 2, h = height, $fn = 30);
        translate([-width / 2, 0, 0]) {
            cube([width, side, height]);
        }
        translate([0, side, 0])
            rotate([0, 0, angle])
                polygon(side = side,
                       height = height, 
                       width = width,
                       sides = sides,
                       drawn = drawn + 1);
    }
}

polygon(height = 10, sides = 6);