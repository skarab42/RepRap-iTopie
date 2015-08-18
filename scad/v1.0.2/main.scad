// iTopie RepRap - Main file
//
// @version 1.0.1
// @license GPLv3
// @docs    http://reprap.org/wiki/ITopie  
// @sources https://github.com/lautr3k/RepRap-iTopie 
// @author  Sébastien Mischler <skarab>
// @author  http://www.onlfait.ch
//
include <config.scad>
use     <parts/vertical_plate.scad>
use     <parts/triangle.scad>
use     <parts/horizontal_plate.scad>
use     <parts/y_carriage.scad>
use     <parts/feet.scad>

// parts module 
if (output_mode != 4) {
    // vertical plate
    translate([-vertical_plate_width - parts_margin, parts_margin, 0]) {
        vertical_plate();
        // triangles
        translate([vertical_plate_borders[3] + triangle_margin[3], triangle_margin[2], 0])
            triangle();
        // triangles
        rotate([0, 0, 180])
            translate([-vertical_plate_width + vertical_plate_borders[1] + triangle_margin[3], -_triangle_height - triangle_margin[2] - triangle_connectors_size[0], 0])
                triangle();
    }


    // horizontal plate
    translate([parts_margin, parts_margin, 0]) {
        horizontal_plate();
        // y carriage
        translate([(horizontal_plate_width - y_carriage_width) / 2, horizontal_plate_borders[2] + y_idler_mount_height + parts_margin, 0]) 
            y_carriage();
    }

    // feet
    translate([parts_margin, -feet_height - feet_connectors_size[1] - parts_margin, 0]) 
        feet();
    translate([-feet_width - parts_margin, -feet_height - feet_connectors_size[1] - parts_margin, 0]) 
        feet();
}

// 3D build
if (output_mode == 4) {
    // horizontal plate
    horizontal_plate();
    // vertical plate
    rotate([90, 0, 0])
        translate([0, -feet_height+sheet_thickness, -vertical_plate_y_position-sheet_thickness])
            vertical_plate();
    // feet
    rotate([90, 0, 0])
        translate([0, -feet_height, -feet_connectors_margin[2] - feet_connectors_size[1]])
            feet();
    rotate([90, 0, 0])
        translate([0, -feet_height, -vertical_plate_height + feet_connectors_margin[0]])
            feet();
    // triangles
    translate([triangle_connectors_margin[3], vertical_plate_y_position, 0]) {
        rotate([90, 0, 90])
            triangle();
    }
    translate([vertical_plate_width - triangle_connectors_margin[1] - sheet_thickness, vertical_plate_y_position, 0]) {
        rotate([90, 0, 90])
            triangle();
    }
}
