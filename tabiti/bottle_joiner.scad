inner_radius = 25;
outer_radius = 27;
thickness = 2;
flange = 5;
taper = outer_radius - inner_radius;
$fn = 100;

module half_join(
    inner_radius = inner_radius,
    outer_radius = outer_radius,
    thickness = thickness,
    flange = flange,
    taper = taper) {
    translate([0, 0, -(flange + taper)]) difference() {
        union() {
            cylinder(r = inner_radius, h = flange);
            cylinder(r1 = inner_radius + 0.5, r2 = inner_radius, h = 0.5);
            translate([0, 0, flange]) cylinder(r1 = inner_radius, r2 = outer_radius, h = taper);
        }
        union() {
            cylinder(r = inner_radius - thickness, h = flange);
            translate([0, 0, flange]) cylinder(r1 = inner_radius - thickness, r2 = outer_radius - thickness, h = taper);
        }
    }
}

module bottle_joiner(
    inner_radius = inner_radius,
    outer_radius = outer_radius,
    thickness = thickness,
    flange = flange,
    taper = taper) {
    half_join(
    inner_radius = inner_radius,
    outer_radius = outer_radius,
    thickness = thickness,
    flange = flange,
    taper = taper);
    mirror([0, 0, 1]) {
        half_join(
        inner_radius = inner_radius,
        outer_radius = outer_radius,
        thickness = thickness,
        flange = flange,
        taper = taper);
    }
}

bottle_joiner();