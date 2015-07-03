// iTopie RepRap - Main file
//
// @version 1.1.0
// @license GPLv3
// @docs    http://reprap.org/wiki/ITopie  
// @sources https://github.com/lautr3k/RepRap-iTopie 
// @author  Sébastien Mischler <skarab>
// @author  http://www.onlfait.ch
//
// @upddate 2015-06-27 <skarab> first write
// @update  2015-07-02 <skarab> add: vertical plate
// @upddate 2015-07-03 <skarab> add: feet
include <config.scad>
use     <horizontal_plate.scad>
use     <vertical_plate.scad>

// build
translate([-horizontal_plate_width - 10, 10, 0])
    horizontal_plate();
translate([10, 10, 0])
    vertical_plate();
