include<slice.scad>

$fn = 30;

width = 20;
depth = 12;

fl = [-width / 2, -depth / 2];
fr = [width / 2, -depth / 2];
rl = [-width / 2, depth / 2];
rr = [width / 2, depth / 2];

hole_radius = 1.7 / 2;

slice(height = 20);

translate([37.5 - 30 / 2, 2, 0]) rotate([90, 0, 0]) slice(width = 30, height = 30, lug = 0.5,
								holes = [
								[fl[0],fl[1],hole_radius],
								[fr[0],fr[1],hole_radius],
								[rl[0],rl[1],hole_radius],
								[rr[0],rr[1],hole_radius],
								]);
for (x = [37.5 - 30 / 2, 37.5 - 2 + 30 / 2]) {
	translate([x, 0, 0]) hull() {
		cube([2, 2, 30]);
		cube([2, 20, 2]);
	}
}
