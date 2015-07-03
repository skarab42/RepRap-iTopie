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
include <config.scad>
use     <shapes.scad>
use     <rear_triangle.scad>
use     <feet.scad>

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