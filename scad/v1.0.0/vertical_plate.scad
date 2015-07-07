// iTopie RepRap - Vertical plate
//
// @version 1.1.0
// @license GPLv3
// @docs    http://reprap.org/wiki/ITopie  
// @sources https://github.com/lautr3k/RepRap-iTopie 
// @author  Sébastien Mischler <skarab>
// @author  http://www.onlfait.ch
//
// @upddate 2015-07-02 <skarab> first write
// @upddate 2015-07-03 <skarab> add feet
// @upddate 2015-07-06 <skarab> add missed holes
include <config.scad>
use     <shapes.scad>
use     <rear_triangle.scad>
use     <feet.scad>

// triangles screws holes
module z_triangle_holes() {
    half_pocket = feet_pocket_size[0] / 2;
    min = 20 + half_pocket;
    max = _triangle_height - feet_pocket_size[0] + half_pocket;
    mid = (max - min) / 4;
    
    translate([0, min + mid, 0])
        circle(z_triangle_holes_radius);
    translate([0, max - mid, 0])
        circle(z_triangle_holes_radius);
}

// z rod holder holes
module z_rod_holder_holes() {
    circle(z_rod_holder_holes_radius);
    translate([z_rod_holder_holes_spacing, 0, 0])
        circle(z_rod_holder_holes_radius);
}

// vertical base plate
module vertical_base_plate() {
    translate([0, total_feet_height, 0]) {
        render() difference() {
            rounded_square(vertical_plate_width, vertical_plate_height - total_feet_height, corner_radius = [vertical_plate_outer_corners[0], vertical_plate_outer_corners[1], 0, 0]);
            translate([vertical_plate_borders[3], 0, 0])
                y_mount(vertical_plate_inner_width, vertical_plate_inner_height - total_feet_height, [vertical_plate_inner_corners[0], vertical_plate_inner_corners[1], 0, 0]);
            translate([z_triangle_pocket_margin[3] + z_triangle_pocket_size[0], 0, 0])
                rear_triangle_pockets();
            translate([vertical_plate_width - z_triangle_pocket_margin[1], 0, 0])
                rear_triangle_pockets();
            translate([vertical_plate_width / 2, vertical_plate_height - (vertical_plate_borders[0] / 2) - total_feet_height, 0])
                logo();
            translate([vertical_plate_borders[3] / 2, 0, 0])
                z_triangle_holes();
            translate([vertical_plate_width - (vertical_plate_borders[1] / 2), 0, 0])
                z_triangle_holes();
            translate([0, vertical_plate_height - total_feet_height - z_rod_holder_holes_spacing, 0]) {
                width  = (horizontal_plate_width - _z_motor_mount_spacing) / 2;
                margin = width - z_rod_pocket_spacing + z_rod_holder_holes_margin[1];
                translate([margin, 0, 0])
                    z_rod_holder_holes();
                translate([horizontal_plate_width - z_rod_holder_holes_spacing - margin, 0, 0])
                    z_rod_holder_holes();
            }
        }
    }
    rounded_square(z_plate_pocket_size[0], total_feet_height, corner_radius = [0, 0, feet_corners[1], feet_corners[0]]);
    translate([vertical_plate_width - z_plate_pocket_size[0], 0, 0])
        rounded_square(z_plate_pocket_size[0], total_feet_height, corner_radius = [0, 0, feet_corners[3], feet_corners[2]]);
}

// iTopie logo
module logo() {
    import(dxf_logo);
}

// rear triangle pockets
module rear_triangle_pockets() {
    rear_triangle_fingers();
}

// vertical plate
module vertical_plate() {
    vertical_base_plate();
    rear_triangles();
    translate([0, -feet_height - sheet_thickness - 20, 0])
        feet();
}
