// iTopie RepRap - Feet
//
// @version 1.0.1
// @license GPLv3
// @docs    http://reprap.org/wiki/ITopie  
// @sources https://github.com/lautr3k/RepRap-iTopie 
// @author  Sébastien Mischler <skarab>
// @author  http://www.onlfait.ch
//
include <../config.scad>
use     <../shapes.scad>

// feet
module feet_2D() {
    render() difference() {
        rounded_square(feet_width, feet_height, corner_radius = [0, 0, feet_corners[3], feet_corners[0]]);
        translate([foot_width, 0, 0])
            y_mount(feet_width - (foot_width * 2), feet_gap_height, [feet_corners[1], feet_corners[2], feet_corners[3], feet_corners[0]]);
    }
    translate([feet_connectors_margin[3], feet_height, 0])
        square(connector_size);
    translate([(horizontal_plate_width - connector_size[0]) / 2, feet_height, 0])
        square(connector_size);
    translate([horizontal_plate_width - connector_size[0] - feet_connectors_margin[1], feet_height, 0])
        square(connector_size);
}

module feet_3D() {
    if (output_version == 1) {
        offset = sheet_thickness - pockets_depth;
        color(pockets_color)
            linear_extrude(offset)
                feet_2D();
        translate([0, 0, offset])
            linear_extrude(pockets_depth)
                feet_2D();

    } 
    else {
        linear_extrude(sheet_thickness)
            feet_2D();
    }
}

module feet() {
    // 0 : 2D preview (default)
    // 1 : extruded view
    // 2 : export first layer
    // 3 : export second layer (pockets)
    if (output_mode == 0) {
        feet_2D();
    } 
    else if (output_mode == 1) {
        feet_3D();
    } 
    else if (output_mode == 2) {
        feet_2D();
    } 
    else if (output_mode == 3) {
        if (output_version == 1)
            feet_2D();
    } 
    else {
        feet_3D();
    }
}

feet();
