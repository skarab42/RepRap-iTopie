// iTopie RepRap - Y carriage
//
// @version 1.0.1
// @license GPLv3
// @docs    http://reprap.org/wiki/ITopie  
// @sources https://github.com/lautr3k/RepRap-iTopie 
// @author  Sébastien Mischler <skarab>
// @author  http://www.onlfait.ch
//
include <../config.scad>

// local configuration
half_width  = y_carriage_width  / 2;
half_height = y_carriage_height / 2;
base_width  = y_carriage_width  - (y_carriage_outer_offset[0] * 2);
base_height = y_carriage_height - (y_carriage_outer_offset[1] * 2);

ergots_width = y_carriage_ergots_radius * 4;

bed_holes_min_x = y_carriage_ergots_radius;
bed_holes_min_y = y_carriage_ergots_radius;
bed_holes_max_x = y_carriage_width - y_carriage_ergots_radius;
bed_holes_max_y = y_carriage_height - y_carriage_ergots_radius;

bed_holes_pos = [
    // 0 = bottom-left
    [bed_holes_min_x, bed_holes_min_y],
    // 1 = top-left
    [bed_holes_min_x, bed_holes_max_y],
    // 2 = top-right
    [bed_holes_max_x, bed_holes_max_y],
    // 3 = middle-right
    [bed_holes_max_x, half_height],
    // 4 = bottom-right
    [bed_holes_max_x, bed_holes_min_y],
    // 5 = middle-bottom
    [half_width, bed_holes_min_y]
];

lm8_hspacing = y_rod_pockets_spacing / 2;
lm8_vspacing = y_carriage_lm8_holder_vspacing ? y_carriage_lm8_holder_vspacing : y_carriage_height / 4;

lm8_min_x = half_width - lm8_hspacing;
lm8_min_y = half_height - lm8_vspacing;
lm8_max_x = half_width + lm8_hspacing;
lm8_max_y = half_height + lm8_vspacing;

lm8_holder_pos = [
    // 0 = bottom-left
    [lm8_min_x, lm8_min_y],
    // 1 = top-left
    [lm8_min_x, lm8_max_y],
    // 2 = top-right
    [lm8_max_x, lm8_max_y],
    // 3 = bottom-right
    [lm8_max_x, lm8_min_y],
];

belt_holder_spacing = y_carriage_belt_holder_screw_spacing / 2;

belt_holes_pos = [
    // 0 = top
    [half_width, half_height + belt_holder_spacing],
    // 1 = bottom
    [half_width, half_height - belt_holder_spacing]
];
    
_endstop_flag_x_margin = y_carriage_triangle_margin[0] / 2;
endstop_flag_x_margin  = _endstop_flag_x_margin > 6 ? 6 : _endstop_flag_x_margin;
endstop_flag_x         = y_carriage_outer_offset[0] + endstop_flag_x_margin;

endstop_flag_holes = [
    [endstop_flag_x, half_height + 9],
    [endstop_flag_x, half_height + 3],
    [endstop_flag_x, half_height - 3],
    [endstop_flag_x, half_height - 9],
];

// cross
module y_carriage_cross() {
    hull() {
        translate(bed_holes_pos[0]) circle(y_carriage_ergots_radius);
        translate(bed_holes_pos[2]) circle(y_carriage_ergots_radius);
    }
    hull() {
        translate(bed_holes_pos[1]) circle(y_carriage_ergots_radius);
        translate(bed_holes_pos[4]) circle(y_carriage_ergots_radius);
    }
}

// ergots
module y_carriage_ergot(width, radius) {
    ergot_diameter = radius * 2;
    circle(radius);
    difference() {
        translate([-ergot_diameter, 0, 0]) square([width, radius]);
        translate([-ergot_diameter, 0, 0]) circle(radius);
        translate([ergot_diameter, 0, 0])  circle(radius);
    }
}

module y_carriage_ergots() {
    translate(bed_holes_pos[5])
        y_carriage_ergot(ergots_width, y_carriage_ergots_radius);
    translate(bed_holes_pos[3])
        rotate([0, 0, 90])
            y_carriage_ergot(ergots_width, y_carriage_ergots_radius);
}

// lm8uu holder holes
module y_carriage_lm8_holder_holes() {
    translate([y_carriage_lm8_holder_screw_spacing / 2, 0, 0]) 
        circle(y_carriage_holes_radius);
    translate([-y_carriage_lm8_holder_screw_spacing / 2, 0, 0]) 
        circle(y_carriage_holes_radius);
}

// screws holes
module y_carriage_holes() {
    // corners
    translate(bed_holes_pos[0]) circle(y_carriage_holes_radius);
    translate(bed_holes_pos[1]) circle(y_carriage_holes_radius);
    translate(bed_holes_pos[2]) circle(y_carriage_holes_radius);
    translate(bed_holes_pos[4]) circle(y_carriage_holes_radius);
    // ergots
    translate(bed_holes_pos[3]) circle(y_carriage_holes_radius);
    translate(bed_holes_pos[5]) circle(y_carriage_holes_radius);
    // lm8uu holder
    translate(lm8_holder_pos[0]) y_carriage_lm8_holder_holes();
    translate(lm8_holder_pos[1]) y_carriage_lm8_holder_holes();
    translate(lm8_holder_pos[2]) y_carriage_lm8_holder_holes();
    translate(lm8_holder_pos[3]) y_carriage_lm8_holder_holes();
    // belt holder
    translate(belt_holes_pos[0]) circle(y_carriage_holes_radius);
    translate(belt_holes_pos[1]) circle(y_carriage_holes_radius);
    // endstop flag (screw)
    translate(endstop_flag_holes[0]) circle(y_carriage_holes_radius);
    translate(endstop_flag_holes[1]) circle(y_carriage_holes_radius);
    translate(endstop_flag_holes[2]) circle(y_carriage_holes_radius);
    translate(endstop_flag_holes[3]) circle(y_carriage_holes_radius);
}

// triangles
module y_carriage_triangle(width, height) {
    minkowski() {
        circle(y_carriage_ergots_radius);
        offset(-y_carriage_triangle_offset - y_carriage_ergots_radius) 
            polygon(points=[[0, 0], [width, 0],[width / 2, height / 2]], paths=[[0, 1, 2]]);
    }
}

module y_carriage_triangles() {
    margin = [
        y_carriage_outer_offset[0] + y_carriage_triangle_margin[0],
        y_carriage_outer_offset[1] + y_carriage_triangle_margin[1]
    ];
    triangle_width  = base_width - (y_carriage_triangle_margin[0] * 2);
    triangle_height = base_height- (y_carriage_triangle_margin[1] * 2);
    translate(margin) {
        // bottom
        translate([0, -y_carriage_triangle_offset, 0])
            y_carriage_triangle(triangle_width, triangle_height);
        // left
        translate([-y_carriage_triangle_offset, triangle_height, 0])
            rotate([0, 0, 270])
                y_carriage_triangle(triangle_height, triangle_width);
        // right
        translate([triangle_width + y_carriage_triangle_offset, 0, 0])
            rotate([0, 0, 90])
                y_carriage_triangle(triangle_height, triangle_width);
        // top
        translate([triangle_width, triangle_height + y_carriage_triangle_offset, 0])
            rotate([0, 0, 180])
                y_carriage_triangle(triangle_width, triangle_height);
    }
}

// holes screws pockets
module y_carriage_holes_pocket() {
    corners_radius = y_carriage_thumbwheel_radius * 1.75;
    // corners
    translate(bed_holes_pos[0]) circle(corners_radius);
    translate(bed_holes_pos[1]) circle(corners_radius);
    translate(bed_holes_pos[2]) circle(corners_radius);
    translate(bed_holes_pos[4]) circle(corners_radius);
    // ergots
    translate(bed_holes_pos[3]) circle(y_carriage_thumbwheel_radius);
    translate(bed_holes_pos[5]) circle(y_carriage_thumbwheel_radius);
}

// base
module y_carriage_base() {
    translate([y_carriage_outer_offset[0], y_carriage_outer_offset[1], 0])
        square([base_width, base_height]);
    y_carriage_cross();
    y_carriage_ergots();
}

// carriage 2D
module y_carriage_2D() {
    difference() {
        y_carriage_base();
        if (output_mode != 3)
            y_carriage_holes();
        y_carriage_triangles();
    }
}

// carriage 3D
module y_carriage_3D() {
    difference() {
        linear_extrude(sheet_thickness) 
            y_carriage_2D();
        translate([0, 0, pockets_height])
            linear_extrude(pockets_depth)
                y_carriage_holes_pocket();
    }
}

// pockets
module y_carriage_pockets() {
    color(pockets_color) render() intersection() {
        y_carriage_2D();
        y_carriage_holes_pocket();
    }
}

// carriage
module y_carriage() {
    // 0 : 2D preview (default)
    // 1 : extruded view
    // 2 : export first layer
    // 3 : export second layer (pockets)
    if (output_mode == 1) {
        y_carriage_3D();
    } 
    else if (output_mode == 2) {
        y_carriage_2D();
    } 
    else if (output_mode == 3) {
        y_carriage_pockets();
    } 
    else {
        y_carriage_2D();
        y_carriage_pockets();
    }
}

y_carriage();
