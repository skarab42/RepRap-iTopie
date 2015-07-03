// iTopie RepRap - Rear triangle
//
// @version 1.1.0
// @license GPLv3
// @docs    http://reprap.org/wiki/ITopie  
// @sources https://github.com/lautr3k/RepRap-iTopie 
// @author  Sébastien Mischler <skarab>
// @author  http://www.onlfait.ch
//
// @upddate 2015-07-03 <skarab> first write
include <config.scad>
use     <shapes.scad>

// rear triangle fingers
module rear_triangle_fingers() {
    translate([-feet_pocket_size[1], 20, 0])
        square([feet_pocket_size[1], feet_pocket_size[0]]);
    translate([-feet_pocket_size[1], (triangle_height - 20 + feet_pocket_size[0]) / 2, 0])
        square([feet_pocket_size[1], feet_pocket_size[0]]);
    translate([-feet_pocket_size[1], triangle_height - feet_pocket_size[0], 0])
        square([feet_pocket_size[1], feet_pocket_size[0]]);
}

// rear triangle
module rear_triangle() {
    render() difference() {
        square([triangle_width, triangle_height]);
        translate([triangle_width, 0, 0])
            rotate([0, 0, triangle_angle])
                square([triangle_width * 2, triangle_height * 2]);
    }
    rear_triangle_fingers();
    
}

module rear_triangles() {
    translate([0, total_feet_height - triangle_margin[0], 0]) {
        translate([vertical_plate_borders[3] + feet_pocket_size[1] + triangle_margin[1], 0, 0])
            rear_triangle();
        translate([vertical_plate_inner_width + vertical_plate_borders[3] - feet_pocket_size[1] - triangle_margin[3], triangle_height, 0])
            rotate([0, 0,180])
                rear_triangle();
    }
}
