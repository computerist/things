length = 10450;
width = 4080;
height = 3760;

wall_thickness = 215;

door_offset = 925;
door_width = 840;
door_height = 2080;
door_ground_offset = 65;

window_height = 550;
window_width = 3115;
window_offset = 523;
window_ground_offset = 1440;

barn_door_width = 2472;
barn_door_height = 2800;

barn_door_offset = (width / 2) - (barn_door_width / 2);

shed_width = 5100;

module structure() {
    difference() {
        union() {
            // shed end wall
            translate([-wall_thickness, -wall_thickness, 0])
                cube([width + wall_thickness * 2, wall_thickness, height]);
            // Mike's boundary side wall
            translate([-wall_thickness, -wall_thickness, 0])
                cube([wall_thickness, length + wall_thickness, height]);
            // field side wall
            translate([width, -wall_thickness, 0])
                cube([wall_thickness, length + wall_thickness, height]);
            // pat's end wall
            translate([-wall_thickness, length, 0])
                cube([width + wall_thickness * 2, wall_thickness, height]);
        }
        union() {
            // side door
            translate([0, door_offset, door_ground_offset])
                cube([width + wall_thickness, door_width, door_height]);
            
            // window
            translate([0, length - window_offset - window_width, window_ground_offset])
                cube([width + wall_thickness, window_width, window_height]);
            
            // barn doors
            translate([barn_door_offset, 0, 0])
                cube([barn_door_width, length + wall_thickness, barn_door_height]);
        }
    }
}

structure();