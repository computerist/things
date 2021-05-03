min_clip = 89;
max_clip = 105;
width = 55;
spoke_dia = 2;
h_thickness = 2;

module wheel_clip(inner_flat = 38.8, inner_radius = 42 / 2, min_clip = min_clip, max_clip = max_clip, clip_width = 50, thickness = 2) {
    offset = inner_radius - min_clip / 2;
    
    difference() {
        union() {
            translate([-clip_width / 2, offset - (min_clip / 2), 0])
                cube([thickness, min_clip, 2 * thickness + spoke_dia]);
            translate([(clip_width / 2) - thickness, offset - (min_clip / 2), 0])
                cube([thickness, min_clip, 2 * thickness + spoke_dia]);
            cylinder(r = inner_radius + h_thickness, h = h_thickness);
            translate([-clip_width / 2, offset - (max_clip / 2), 0])
                cube([clip_width, max_clip, thickness]);
            translate([-clip_width / 2, offset - max_clip / 2, thickness])
                difference() {
                   cube([clip_width, ((max_clip - min_clip) / 2) + h_thickness, thickness + spoke_dia]);
                    cube([clip_width, ((max_clip - min_clip) / 2) , spoke_dia]);
                    
                }
             translate([-clip_width / 2, offset + max_clip / 2, thickness])
                mirror([0, 1, 0]) difference() {
                   cube([clip_width, ((max_clip - min_clip) / 2) + h_thickness, thickness + spoke_dia]);
                    cube([clip_width, ((max_clip - min_clip) / 2) , spoke_dia]);
                    
                }
        }
        union() {
            intersection() {
                cylinder(r = inner_radius, h= thickness * 2 + spoke_dia);
                translate([-inner_flat / 2, -inner_radius, 0]) cube([inner_flat, inner_radius * 2, thickness * 2 + spoke_dia]);
            }
            translate([-(inner_flat - thickness) / 2, 0, 0]) cube([inner_flat - thickness, clip_width, thickness * 2 + spoke_dia]);
        }
    }
}

wheel_clip(thickness = 1);