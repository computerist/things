$fn = 100;

module toothed_ring() {
    //difference() {
        linear_extrude(height = 18) import("teeth.dxf");
    //    cylinder(r = 377, h = 18, $fn = $fn);
    //}
}

//intersection() {
//    linear_extrude(height = 18) polygon([[0,0], [0, 400], [400,400]]);
    rotate([0, 0, (360 / 240) / 2]) difference() {
        toothed_ring();
        scale([0.99, 0.99, 1]) toothed_ring();
    }
//}