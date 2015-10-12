// iTopie RepRap - Horizontal plate
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

// local configuration
motor_pos   = [(horizontal_plate_width - y_motor_mount_width) / 2, horizontal_plate_height - horizontal_plate_borders[0]];
idler_pos   = [(horizontal_plate_width - y_idler_mount_width) / 2, horizontal_plate_borders[2]];
endstop_pos = [horizontal_plate_borders[3], horizontal_plate_height - y_endstop_mount_position];

// y idler pocket auto width
_y_idler_pocket_width = y_idler_pocket_width ? y_idler_pocket_width : y_idler_mount_width - 20;


// y endstop holes
module y_endstop_holes() {
    holes_center = y_endstop_mount_height / 2;
    translate([horizontal_plate_borders[3], horizontal_plate_height - y_endstop_mount_position, 0]) {
        translate([7, -holes_center, 0])
            circle(y_endstop_holes_radius);
        translate([7 + y_endstop_holes_spacing, -holes_center, 0])
            circle(y_endstop_holes_radius);
    }
}

// y endstop mount
module endstop_mount() {
    translate([endstop_pos[0], endstop_pos[1], 0])
        rotate([0, 0, -90])
            y_mount(y_endstop_mount_height, y_endstop_mount_width, y_endstop_mount_corners);
}

// horizontal base plate
module horizontal_base_plate() {
    // base plate
    render() difference() {
        rounded_square(horizontal_plate_width, horizontal_plate_height, corner_radius = horizontal_plate_outer_corners);
        translate([horizontal_plate_borders[3], horizontal_plate_borders[2], 0])
            rounded_square(horizontal_plate_inner_width, horizontal_plate_inner_height, corner_radius = horizontal_plate_inner_corners);
    }
    // motor mount
    translate([motor_pos[0], motor_pos[1], 0])
        mirror([0, 1, 0])
            y_mount(y_motor_mount_width, y_motor_mount_height, y_motor_mount_corners);
    // idler mount
    translate([idler_pos[0], idler_pos[1], 0])
        y_mount(y_idler_mount_width, y_idler_mount_height, y_idler_mount_corners);
    // endstop mount
    endstop_mount();
}

// feet holes
module _feet_connectors_holes() {
    // feet connector holes
    translate([feet_connectors_margin[3], 0, 0])
        square(feet_connectors_size);
    translate([(horizontal_plate_width - feet_connectors_size[0]) / 2, 0, 0])
        square(feet_connectors_size);
    translate([horizontal_plate_width - feet_connectors_size[0] - feet_connectors_margin[1], 0, 0])
        square(feet_connectors_size);
    // feet screws holes
    center        = horizontal_plate_width / 2;
    half_pocket   = feet_connectors_size[0] / 2;
    spacing_left  = (center - feet_connectors_margin[3] - half_pocket) / 2;
    spacing_right = (center - feet_connectors_margin[1] - half_pocket) / 2;
    y_pos         = feet_connectors_size[1] / 2;
    translate([center - spacing_left - feet_holes_margin, y_pos, 0])
        circle(feet_holes_radius);
    translate([center + spacing_right + feet_holes_margin, y_pos, 0])
        circle(feet_holes_radius);
}

// holes
module feet_connectors_holes() {
    // feet connector holes (top)
    translate([0, horizontal_plate_height - feet_connectors_size[1] - feet_connectors_margin[0], 0])
        _feet_connectors_holes();
    // feet connector holes (bottom)
    translate([0, feet_connectors_margin[2], 0])
        _feet_connectors_holes();
}

// triangle screws holes
module triangle_screws_holes() {
    center = triangle_connectors_size[0] / 2;
    translate([center, -triangle_holes_margin, 0])
        circle(triangle_holes_radius);
    translate([center, triangle_connectors_size[1] + triangle_holes_margin, 0])
        circle(triangle_holes_radius);
}

// triangle connectors holes
module triangle_connectors_holes() {
    margin_top = horizontal_plate_height - triangle_connectors_size[1] - triangle_connectors_margin[0];
    translate([triangle_connectors_margin[3], margin_top, 0]) {
        square(triangle_connectors_size);
        triangle_screws_holes();
    }
    translate([horizontal_plate_width - triangle_connectors_size[0] - triangle_connectors_margin[1], margin_top, 0]) {
        square(triangle_connectors_size);
        triangle_screws_holes();
    }
}

// vertical plate connectors holes
module vertical_plate_holes() {
    translate([0, vertical_plate_y_position, 0])
        square([foot_width, sheet_thickness]);
    translate([horizontal_plate_width - foot_width, vertical_plate_y_position, 0])
        square([foot_width, sheet_thickness]);
}

// motor mount & z rod pockets
// 0 = none, 1 = left, 2 = right
module motor_mount(radius, z_holes = 0, centerOnly = 0) {
    if (centerOnly == 0) {
        circle(radius);
        translate([31, 0, 0])
            circle(radius);
        translate([31, 31, 0])
            circle(radius);
        translate([0, 31, 0])
            circle(radius);
    }
    translate([15.5, 15.5, 0]) {
        circle(12);
        // z rod pockets
        if (z_holes == 1) {
            translate([-z_rod_spacing, 0, 0])
                circle(z_rod_radius);
        }
        if (z_holes == 2) {
            translate([z_rod_spacing, 0, 0])
                circle(z_rod_radius);
        }
    }
}

// z motors mounts
module z_motor_mount() {
    y_position = vertical_plate_y_position - 36.5 - z_motor_mount_margin;
    translate([((horizontal_plate_width - z_motor_spacing) / 2) - 15.5, y_position, 0])
        motor_mount(z_motor_holes_radius, 1);
    translate([((horizontal_plate_width + z_motor_spacing) / 2) - 15.5, y_position, 0])
        motor_mount(z_motor_holes_radius, 2);
}

// y motor mount
module y_motor_mount(centerOnly = 0) {
    translate([(horizontal_plate_width - 31) / 2, horizontal_plate_height - horizontal_plate_borders[0] - 27.5, 0]) {
        motor_mount(y_motor_holes_radius, 0, centerOnly);
        if (y_motor_mount_angle > 0) {
            render() translate([31, 31, 0])
                for ( i = [1:y_motor_mount_angle] ) {
                    rotate([0, 0, 180 + i])
                        motor_mount(y_motor_holes_radius, 0, centerOnly);
                }
        }
    }
}

module y_motor_pocket() {
    radius  = (y_motor_mount_width - 24) / 4;
    translate([motor_pos[0], motor_pos[1] - y_motor_mount_height, 0]) {
        render() difference() {
            square([y_motor_mount_width, y_motor_mount_height]);
            translate([0, (y_motor_mount_height / 2) + radius, 0]) {
                translate([radius, 0, 0]) 
                    circle(radius);
                translate([y_motor_mount_width - radius, 0, 0]) 
                    circle(radius);
                square([y_motor_mount_width, (y_motor_mount_height / 2)]);
            }
        }
    }
    y_motor_mount(1);
}

module y_idler_pocket() {
    top_radius    = _y_idler_pocket_width / 2;
    bottom_radius = (y_idler_mount_width - _y_idler_pocket_width) / 4;
    render() difference() {
        translate([(horizontal_plate_width - _y_idler_pocket_width) / 2, horizontal_plate_borders[2] + y_idler_mount_height, 0])
            mirror([0, 1, 0])
                y_mount(_y_idler_pocket_width, y_idler_pockets_height, [top_radius, top_radius, bottom_radius, bottom_radius]);
    }
}

// y idler mount
module y_idler_hole() {
    translate([horizontal_plate_width  / 2, horizontal_plate_borders[2] + y_idler_mount_height / 2, 0])
        circle(y_idler_mount_hole_radius);
}

// y rod holes
module _y_rod_holes() {
    center = y_rod_pockets_size[1] / 2;
    translate([-y_rod_holes_margin, center, 0])
        circle(y_rod_holes_radius);
    translate([y_rod_pockets_size[0] + y_rod_holes_margin, center, 0])
        circle(y_rod_holes_radius);
}

module y_rod_holes() {
    center  = (horizontal_plate_width - y_rod_pockets_size[0]) / 2;
    spacing = y_rod_pockets_spacing / 2;
    translate([0, horizontal_plate_borders[2] - y_rod_pockets_size[1], 0]) {
        translate([center - spacing, 0, 0]) _y_rod_holes();
        translate([center + spacing, 0, 0]) _y_rod_holes();
    }
    translate([0, horizontal_plate_height - horizontal_plate_borders[0], 0]) {
        translate([center - spacing, 0, 0]) _y_rod_holes();
        translate([center + spacing, 0, 0]) _y_rod_holes();
    }
}

// y rod pockets
module y_rod_pockets() {
    center  = (horizontal_plate_width - y_rod_pockets_size[0]) / 2;
    spacing = y_rod_pockets_spacing / 2;
    translate([0, horizontal_plate_borders[2] - y_rod_pockets_size[1], 0]) {
        translate([center - spacing, 0, 0]) square(y_rod_pockets_size);
        translate([center + spacing, 0, 0]) square(y_rod_pockets_size);
    }
    translate([0, horizontal_plate_height - horizontal_plate_borders[0], 0]) {
        translate([center - spacing, 0, 0]) square(y_rod_pockets_size);
        translate([center + spacing, 0, 0]) square(y_rod_pockets_size);
    }
}

// holes
module horizontal_plate_holes() {
    triangle_connectors_holes();
    feet_connectors_holes();
    vertical_plate_holes();
    y_endstop_holes();
    z_motor_mount();
    y_motor_mount();
    y_idler_hole();
    y_rod_holes();
}

// pockets
module horizontal_plate_pockets() {
    color(pockets_color) {
        difference() {
            endstop_mount();
            if (output_mode != 3) {
                y_endstop_holes();
            }
        }
        difference() {
            y_idler_pocket();
            if (output_mode != 3) {
                y_idler_hole();
            }
        }
        difference() {
            y_motor_pocket();
            if (output_mode != 3) {
                y_motor_mount();
            }
        }
        y_rod_pockets();
    }
}

// horizontal plate 2D
module horizontal_plate_2D() {
    difference() {
        horizontal_base_plate();
        horizontal_plate_holes();
    }
}

// horizontal plate 3D
module horizontal_plate_3D() {
    offset = sheet_thickness - pockets_depth;
    if (output_version == 1) {
        color(pockets_color)
            linear_extrude(offset)
                horizontal_plate_2D();
    }
    y = output_version == 1 ? offset : 0;
    h = output_version == 1 ? pockets_depth : sheet_thickness;
    translate([0, 0, y]) 
        render() difference() {
            linear_extrude(h)
                horizontal_plate_2D();
            translate([0, 0, pockets_height - y])
                linear_extrude(pockets_depth)
                    horizontal_plate_pockets();
        }
}

// horizontal plate
module horizontal_plate() {
    // 0 : 2D preview (default)
    // 1 : extruded view
    // 2 : export first layer
    // 3 : export second layer (pockets)
    if (output_mode == 0) {
        horizontal_plate_2D();
        horizontal_plate_pockets();
    } 
    else if (output_mode == 1) {
        horizontal_plate_3D();
    } 
    else if (output_mode == 2) {
        horizontal_plate_2D();
    } 
    else if (output_mode == 3) {
        difference() {
            if (output_version == 1) {
                horizontal_plate_2D();
            }
            horizontal_plate_pockets();
        }
    } 
    else {
        horizontal_plate_3D();
    }
}

horizontal_plate();
