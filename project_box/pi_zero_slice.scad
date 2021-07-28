include<slice.scad>

$fn = 30;

width = 58;
depth = 23;

fl = [-width / 2, -depth / 2];
fr = [width / 2, -depth / 2];
rl = [-width / 2, depth / 2];
rr = [width / 2, depth / 2];

hole_radius = 2.5 / 2;

slice(
								holes = [
								[fl[0],fl[1],hole_radius],
								[fr[0],fr[1],hole_radius],
								[rl[0],rl[1],hole_radius],
								[rr[0],rr[1],hole_radius],
								]);
