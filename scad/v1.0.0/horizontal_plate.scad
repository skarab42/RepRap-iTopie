// iTopie RepRap - Horizontal plate
//
// @version 1.1.0
// @license GPLv3
// @docs    http://reprap.org/wiki/ITopie  
// @sources https://github.com/lautr3k/RepRap-iTopie 
// @author  Sébastien Mischler <skarab>
// @author  http://www.onlfait.ch
//
// @upddate 2015-06-27 at 10:00 <skarab> first write
include <config.scad>
use     <shapes.scad>

// z triangle screws holes
module z_triangle_holes() {
    center = z_triangle_pocket_size[0] / 2;
    translate([center, -z_triangle_holes_margin, 0])
        circle(z_triangle_holes_radius);
    translate([center, z_triangle_pocket_size[1] + z_triangle_holes_margin, 0])
        circle(z_triangle_holes_radius);
}

// z triangle pockets
module z_triangle_pockets() {
    margin_top = horizontal_plate_height - z_triangle_pocket_size[1] - z_triangle_pocket_margin[0];
    translate([z_triangle_pocket_margin[3], margin_top, 0]) {
        square(z_triangle_pocket_size);
        z_triangle_holes();
    }
    translate([horizontal_plate_width - z_triangle_pocket_size[0] - z_triangle_pocket_margin[1], margin_top, 0]) {
        square(z_triangle_pocket_size);
        z_triangle_holes();
    }
}

// z plate pockets
module z_plate_pockets() {
    margin_top = horizontal_plate_height - z_plate_pocket_size[1] - z_plate_pocket_margin[0];
    translate([z_plate_pocket_margin[3], margin_top, 0])
        square(z_plate_pocket_size);
    translate([horizontal_plate_width - z_plate_pocket_size[0] - z_plate_pocket_margin[3], margin_top, 0])
        square(z_plate_pocket_size);
}

// y rod pockets
module _y_rod_pockets() {
    center  = (horizontal_plate_width - y_rod_pocket_size[0]) / 2;
    spacing = _y_rod_pocket_spacing / 2;
    translate([center - spacing, 0, 0])
        square(y_rod_pocket_size);
    translate([center + spacing, 0, 0])
        square(y_rod_pocket_size);
}

module y_rod_pockets() {
    translate([0, horizontal_plate_borders[2] - y_rod_pocket_size[1], 0])
        _y_rod_pockets();
    translate([0, horizontal_plate_height - horizontal_plate_borders[0], 0])
        _y_rod_pockets();
}

// feet screws holes
module _feet_holes() {
    center        = horizontal_plate_width / 2;
    half_pocket   = feet_pocket_size[0] / 2;
    spacing_left  = (center - feet_pocket_margin[3] - half_pocket) / 2;
    spacing_right = (center - feet_pocket_margin[1] - half_pocket) / 2;
    translate([center - spacing_left - feet_holes_margin, 0, 0])
        circle(feet_holes_radius);
    translate([center + spacing_right + feet_holes_margin, 0, 0])
        circle(feet_holes_radius);
}

// feet pockets
module _feet_pockets() {
    translate([feet_pocket_margin[3], 0, 0])
        square(feet_pocket_size);
    translate([(horizontal_plate_width - feet_pocket_size[0]) / 2, 0, 0])
        square(feet_pocket_size);
    translate([horizontal_plate_width - feet_pocket_size[0] - feet_pocket_margin[1], 0, 0])
        square(feet_pocket_size);
}

module feet_pockets() {
    translate([0, feet_pocket_margin[2], 0]) {
        _feet_pockets();
        translate([0, feet_pocket_size[1] / 2, 0])
            _feet_holes();
    }
    translate([0, horizontal_plate_height - feet_pocket_size[1] - feet_pocket_margin[0], 0]) {
        _feet_pockets();
        translate([0, feet_pocket_size[1] / 2, 0])
            _feet_holes();
    }
}

// horizontal base plate
module horizontal_base_plate() {
    render() difference() {
        rounded_square(horizontal_plate_width, horizontal_plate_height, corner_radius = horizontal_plate_outer_corners);
        translate([horizontal_plate_borders[3], horizontal_plate_borders[2], 0])
            rounded_square(horizontal_plate_inner_width, horizontal_plate_inner_height, corner_radius = horizontal_plate_inner_corners);
    }
}

// motor mount & z rod pockets
module motor_mount(pos = 0) {
    circle(1.5);
    translate([31, 0, 0])
        circle(1.5);
    translate([31, 31, 0])
        circle(1.5);
    translate([0, 31, 0])
        circle(1.5);
    translate([15.5, 15.5, 0]) {
        circle(12);
        // z rod pockets
        if (pos == 1) {
            translate([-z_rod_pocket_spacing, 0, 0])
                circle(z_rod_pocket_radius);
        }
        if (pos == 2) {
            translate([z_rod_pocket_spacing, 0, 0])
                circle(z_rod_pocket_radius);
        }
    }
}

// z motor mount
module z_motor_mount() {
    y_position = horizontal_plate_height - z_plate_pocket_size[1] - z_plate_pocket_margin[0] - 36.5 - z_motor_mount_margin;
    translate([((horizontal_plate_width - _z_motor_mount_spacing) / 2) - 15.5, y_position, 0])
        motor_mount(1);
    translate([((horizontal_plate_width + _z_motor_mount_spacing) / 2) - 15.5, y_position, 0])
        motor_mount(2);
}

// y idler mount
module y_idler_mount() {
    render() difference() {
        translate([(horizontal_plate_width - y_idler_mount_width) / 2, horizontal_plate_borders[2], 0])
            y_mount(y_idler_mount_width, y_idler_mount_height, y_idler_mount_radius);
        translate([(horizontal_plate_width - _y_idler_pocket_width) / 2, horizontal_plate_borders[2] + y_idler_mount_height, 0])
            mirror([0, 1, 0])
                y_mount(_y_idler_pocket_width, y_idler_pocket_height, [_y_idler_pocket_width / 2, (y_idler_mount_width - _y_idler_pocket_width) / 4]);
    }
}

// y motor mount
module y_motor_mount() {
    translate([(horizontal_plate_width - y_motor_mount_width) / 2, horizontal_plate_height - horizontal_plate_borders[0], 0])
        mirror([0, 1, 0])
            y_mount(y_motor_mount_width, y_motor_mount_height, y_motor_mount_radius);
}

module y_motor_pockets() {
    translate([(horizontal_plate_width - 31) / 2, horizontal_plate_height - horizontal_plate_borders[0] - 27.5, 0]) {
        motor_mount(0);
        if (y_motor_mount_angle > 0) {
            translate([31, 31, 0])
                for ( i = [1:y_motor_mount_angle] ){
                    rotate([0, 0, 180 + i])
                        motor_mount(0);
                }
        }
    }
}

// y endstop mount
module y_endstop_mount() {
    holes_center = y_endstop_mount_height / 2;
    translate([horizontal_plate_borders[3], horizontal_plate_height - y_endstop_mount_position, 0]) {
        render() difference() {
            rotate([0, 0, -90])
                y_mount(y_endstop_mount_height, y_endstop_mount_width, y_endstop_mount_radius);
            translate([7, -holes_center, 0])
                circle(y_endstop_holes_radius);
            translate([7 + y_endstop_holes_spacing, -holes_center, 0])
                circle(y_endstop_holes_radius);
        }
    }
}

// horizontal plate
module horizontal_plate() {
// base plate
    render() difference() {
        render() union() { 
            horizontal_base_plate();
            y_endstop_mount();
            y_idler_mount();
            y_motor_mount();
        }
        z_triangle_pockets();
        z_plate_pockets();
        y_motor_pockets();
        y_rod_pockets();
        feet_pockets();
        z_motor_mount();
    }
}
