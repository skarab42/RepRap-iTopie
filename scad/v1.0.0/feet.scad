// iTopie RepRap - Feet
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

// feet
module feet() {
    render() difference() {
        rounded_square(feet_width, feet_height, corner_radius = [0, 0, feet_corners[3], feet_corners[0]]);
        translate([z_plate_pocket_size[0], 0, 0])
            y_mount(feet_width - (z_plate_pocket_size[0] * 2), feet_height - feet_gap_height, [feet_corners[1], feet_corners[2], feet_corners[3], feet_corners[0]]);
    }
    translate([feet_pocket_margin[3], feet_height, 0])
        square(feet_pocket_size);
    translate([(horizontal_plate_width - feet_pocket_size[0]) / 2, feet_height, 0])
        square(feet_pocket_size);
    translate([horizontal_plate_width - feet_pocket_size[0] - feet_pocket_margin[1], feet_height, 0])
        square(feet_pocket_size);
}
