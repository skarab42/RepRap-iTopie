// iTopie RepRap - Vertical plate
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

// base plate
module vertical_base_plate() {
    translate([0, feet_height, 0]) {
        render() difference() {
            translate([0, sheet_thickness, 0])
            rounded_square(vertical_plate_width, vertical_plate_height - feet_height - sheet_thickness, corner_radius = [vertical_plate_outer_corners[0], vertical_plate_outer_corners[1], 0, 0]);
            translate([vertical_plate_borders[3], 0, 0])
                y_mount(vertical_plate_inner_width, vertical_plate_inner_height - feet_height, [vertical_plate_inner_corners[0], vertical_plate_inner_corners[1], 0, 0]);
            
        }
    }
    rounded_square(foot_width, feet_height + sheet_thickness, corner_radius = [0, 0, feet_corners[1], feet_corners[0]]);
    translate([vertical_plate_width - foot_width, 0, 0])
        rounded_square(foot_width, feet_height + sheet_thickness, corner_radius = [0, 0, feet_corners[3], feet_corners[2]]);
}

// triangles screws holes
module _triangle_holes() {
    half_pocket = feet_connectors_size[0] / 2;
    min = 20 + half_pocket;
    max = _triangle_height - feet_connectors_size[0] + half_pocket;
    mid = (max - min) / 4;
    translate([0, min + mid, 0])
        circle(triangle_holes_radius);
    translate([0, max - mid, 0])
        circle(triangle_holes_radius);
}

module triangle_holes() {
    translate([0, feet_height + sheet_thickness, 0]) {
        translate([vertical_plate_borders[3] / 2, 0, 0])
            _triangle_holes();
        translate([vertical_plate_width - (vertical_plate_borders[1] / 2), 0, 0])
            _triangle_holes();
    }
}

// z rod holder holes
module _z_rod_holder_holes() {
    circle(z_rod_holder_holes_radius);
    translate([z_rod_holder_holes_spacing, 0, 0])
        circle(z_rod_holder_holes_radius);
}

module z_rod_holder_holes() {
    z_motor_pos = [
        (vertical_plate_width - z_motor_spacing) / 2,
        (vertical_plate_width + z_motor_spacing) / 2
    ];
    translate([0, vertical_plate_height - z_rod_holder_holes_margin[0], 0]) {
        translate([z_motor_pos[0] - z_rod_spacing + z_rod_holder_holes_margin[1], 0, 0])
            _z_rod_holder_holes();
        translate([z_motor_pos[1] - z_rod_holder_holes_spacing + z_rod_spacing - z_rod_holder_holes_margin[1], 0, 0])
            _z_rod_holder_holes();
    }         
}

// triangle pockets
module _triangle_connectors_holes() {
    translate([-triangle_connectors_size[0], 20, 0])
        square([triangle_connectors_size[0], triangle_connectors_size[1]]);
    translate([-triangle_connectors_size[0], (_triangle_height - 20 + triangle_connectors_size[1]) / 2, 0])
        square([triangle_connectors_size[0], triangle_connectors_size[1]]);
    translate([-triangle_connectors_size[0], _triangle_height - triangle_connectors_size[1], 0])
        square([triangle_connectors_size[0], triangle_connectors_size[1]]);
}

module triangle_connectors_holes() {
    translate([triangle_connectors_margin[3] + triangle_connectors_size[0], feet_height + sheet_thickness, 0])
        _triangle_connectors_holes();
    translate([vertical_plate_width - triangle_connectors_margin[1], feet_height + sheet_thickness, 0])
        _triangle_connectors_holes();
}

// iTopie logo
module logo() {
    translate([vertical_plate_width / 2, vertical_plate_height - (vertical_plate_borders[0] / 2), 0])
        import(dxf_logo);
}

// holes
module vertical_plate_holes() {
    triangle_holes();
    z_rod_holder_holes();
    triangle_connectors_holes();
}

// pockets
module vertical_plate_pockets() {
    color(pockets_color) 
        logo();
}

// vertical plate 2D
module vertical_plate_2D() {
    difference() {
        vertical_base_plate();
        vertical_plate_holes();
    }
}

// vertical plate 3D
module vertical_plate_3D() {
    offset = sheet_thickness - pockets_depth;
    if (output_version == 1) {
        color(pockets_color)
            linear_extrude(offset)
                vertical_plate_2D();
    }
    y = output_version == 1 ? offset : 0;
    h = output_version == 1 ? pockets_depth : sheet_thickness;
    d = output_version == 1 ? pockets_depth : logo_depth;
    translate([0, 0, y])
        render() difference() {
            linear_extrude(h)
                vertical_plate_2D();
            translate([0, 0, h - d])
                linear_extrude(d)
                     logo();
        }
    
}

// vertical plate
module vertical_plate() {
    // 0 : 2D preview (default)
    // 1 : extruded view
    // 2 : export first layer
    // 3 : export second layer (pockets)
    if (output_mode == 0) {
        vertical_plate_2D();
        vertical_plate_pockets();
    } 
    else if (output_mode == 1) {
        vertical_plate_3D();
    } 
    else if (output_mode == 2) {
        vertical_plate_2D();
    } 
    else if (output_mode == 3) {
        difference() {
            if (output_version == 1) {
                vertical_plate_2D();
            }
            vertical_plate_pockets();
        }
    } 
    else {
        vertical_plate_3D();
    }
}

vertical_plate();
