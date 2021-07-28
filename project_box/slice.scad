$fn = 30;

module slice(width = 75, height = 40, thickness = 2, standoff = 4, lug = 3, holes = []) {
  difference() {
    union() {
      cube([width, height, thickness]);
      for (hole = holes) {
	translate([(width/2)+hole[0], (height/2)+hole[1], 0]) cylinder(r = (hole[2] + lug), h = thickness + standoff, $fn = $fn);
      }
    }
    union() {
      for (hole = holes) {
	translate([(width/2)+hole[0], (height/2)+hole[1], 0]) cylinder(r = hole[2], h = thickness + standoff, $fn = $fn);
      }
    }
  }
}
