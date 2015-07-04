// iTopie RepRap - Configuration
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
// @upddate 2015-07-03 <skarab> add: feet and triangle
$fn = 50;

// sheet thickness (raw material)
sheet_thickness                = 16;                    // raw sheet thickness

// ---------------------------------------------------------------- //
// ------------------- horizontal plate --------------------------- //
// ---------------------------------------------------------------- //

// horizontal plate
horizontal_plate_width         = 390;                   // outer width
horizontal_plate_height        = 440;                   // outer height
horizontal_plate_borders       = [40, 82, 40, 82];      // borders weight       [top, right, bottom, left]
horizontal_plate_outer_corners = [10, 10, 10, 10];      // outer corners radius [topLeft, topRight, bottomRight, bottoLeft]
horizontal_plate_inner_corners = [30, 30, 30, 30];      // inner corners radius [topLeft, topRight, bottomRight, bottoLeft]

// y idler mount
y_idler_mount_width            = 44;                    // idler mount width
y_idler_mount_height           = 24;                    // idler mount height
y_idler_mount_corners          = [5, 5, 10, 10];        // corners radius [topLeft, topRight, bottomRight, bottoLeft]

// y idler pocket
y_idler_pocket_width           = undef;                 // idler pocket width [undef = auto]
y_idler_pocket_height          = y_idler_mount_height;  // idler pocket height


// y motor mount
y_motor_mount_width            = 50;                    // motor mount width
y_motor_mount_height           = 36;                    // motor mount width
y_motor_mount_corners          = [5, 5, 10, 10];        // corners radius [topLeft, topRight, bottomRight, bottoLeft]
y_motor_mount_angle            = 8;                     // motor rotation angle (belt tensionner) 0 = disabled

// y endstop mount
y_endstop_mount_width          = 25;                    // endstop mount width
y_endstop_mount_height         = 16.4;                  // endstop mount width
y_endstop_mount_corners        = [8.2, 8.2, 10, 10];    // corners radius [topLeft, topRight, bottomRight, bottoLeft]
y_endstop_mount_position       = 82;                    // from the frame top border to the endstop top border

// y endstop screws holes
y_endstop_holes_radius         = 1.5;                   // endstop screws holes radius
y_endstop_holes_spacing        = 9.5;                   // between the two endstop screws (axis to axis)

// feet pockets
feet_pocket_size               = [20, sheet_thickness]; // pockets size   [width, height]
feet_pocket_margin             = [10.5, 40, 10.5, 40];  // pockets margin [top, right, bottom, left]

// feet holes
feet_holes_radius              = 2;                     // feet screws holes radius
feet_holes_margin              = 10;                    // feet screws horizontal margin (for fine adjustement)

// z triangle pockets
z_triangle_pocket_size         = [sheet_thickness, 20]; // pockets size   [width, height]
z_triangle_pocket_margin       = [63, 22, undef, 22];   // pockets margin [top, right, ---, left]

// feet holes
z_triangle_holes_radius        = 2;                     // z triangle screws holes radius
z_triangle_holes_margin        = 20;                    // z triangle screws margin (from z triangle pocket border)

// z plate pockets
z_plate_pocket_size            = [40, sheet_thickness]; // pockets size   [width, height]
z_plate_pocket_margin          = [138, 0, undef, 0];    // pockets margin [top, right, ---, left]        

// y rod pockets
y_rod_pocket_size              = [8, 20];               // pockets size   [width, height]
y_rod_pocket_spacing           = undef;                 // pockets spacing (axis to axis) [undef = auto]

// y rod holes
y_rod_holes_radius             = 1.5;                   // y rod screws holes radius
y_rod_holes_margin             = 4;                     // y rod screws margin (from y rod pocket border)

// z motor mount
z_motor_mount_margin           = 8;                     // between the "motor" and the "z_plate" (border to border)
z_motor_mount_spacing          = undef;                 // between the two motor mount (axis to axis) [undef = auto]

// z motor mount
z_rod_pocket_spacing           = 17;                    // between the "motor" and the "z rod" (axis to axis)
z_rod_pocket_radius            = 4;                     // z smoothe rod radius

// ---------------------------------------------------------------- //
// ------------------- vertical plate ----------------------------- //
// ---------------------------------------------------------------- //

// logo
dxf_logo                     = "logo.dxf";              // path to DXF logo

// vertical plate
vertical_plate_width         = horizontal_plate_width;  // outer width
vertical_plate_height        = horizontal_plate_height; // outer height
vertical_plate_borders       = [60, 60, undef, 60];     // borders weight       [top, right, bottom, left]
vertical_plate_outer_corners = [10, 10, 10, 10];        // outer corners radius [topLeft, topRight, bottomRight, bottoLeft]
vertical_plate_inner_corners = [10, 10, 10, 10];        // inner corners radius [topLeft, topRight, bottomRight, bottoLeft]

// ---------------------------------------------------------------- //
// ------------------------- feet --------------------------------- //
// ---------------------------------------------------------------- //
feet_width                   = horizontal_plate_width;  // feet width...
feet_height                  = 60;                      // feet height...
feet_corners                 = [10, 10, 10, 10];        // corners radius [leftOut, leftIn, rightIn, rightOut]
feet_gap_height              = 40;                      // gap height ?

// ---------------------------------------------------------------- //
// ----------------------- triangle ------------------------------- //
// ---------------------------------------------------------------- //
triangle_width               = undef;                   // rear triangle width         [undef = auto]
triangle_height              = undef;                   // rear triangle height        [undef = auto]
triangle_angle               = undef;                   // rear triangle angle         [undef = auto]
triangle_margin              = [20, 20, undef, 20];     // rear triangle margin        [top, right, bottom, left]
triangle_radius              = 10;                      // rear triangle corner radius [undef = auto]


// ---------------------------------------------------------------- //
// --- CHANGE NOTHING BELOW, UNLESS YOU KNOW WHAT YOU ARE DOING --- //
// ---------------------------------------------------------------- //

// horizontal plate computed borders [top+bottom, left+right]
horizontal_plate_computed_borders = [horizontal_plate_borders[0] + horizontal_plate_borders[2], horizontal_plate_borders[1] + horizontal_plate_borders[3]];

// horizontal plate inner size
horizontal_plate_inner_width  = horizontal_plate_width - horizontal_plate_computed_borders[1];
horizontal_plate_inner_height = horizontal_plate_height - horizontal_plate_computed_borders[0];

// y rod pockets auto spacing
_y_rod_pocket_spacing = y_rod_pocket_spacing ? y_rod_pocket_spacing : (horizontal_plate_inner_width) / 2;

// y rod pockets auto spacing
_z_motor_mount_spacing = z_motor_mount_spacing ? z_motor_mount_spacing : horizontal_plate_width - 60;

// y idler pocket auto width
_y_idler_pocket_width = y_idler_pocket_width ? y_idler_pocket_width : y_idler_mount_width - 20;

// ---------------------------------------------------------------- //

// vertical plate computed borders [top+bottom, left+right]
vertical_plate_computed_borders = [vertical_plate_borders[0], vertical_plate_borders[1] + vertical_plate_borders[3]];

// vertical plate inner size
vertical_plate_inner_width  = vertical_plate_width - vertical_plate_computed_borders[1];
vertical_plate_inner_height = vertical_plate_height - vertical_plate_computed_borders[0];

// total feet height
total_feet_height = feet_height + sheet_thickness;

// triangles auto size
triangle_max_width  = z_plate_pocket_margin[0];
triangle_max_height = vertical_plate_inner_height - total_feet_height;

//triangle_width  = (triangle_width > triangle_max_width)   ? triangle_max_width  : triangle_width;
//triangle_height = (triangle_height > triangle_max_height) ? triangle_max_height : triangle_height;

_triangle_width  = triangle_width && triangle_width <= triangle_max_width  ? triangle_width  : triangle_max_width;
_triangle_height = triangle_height && triangle_height <= triangle_max_height ? triangle_height : triangle_max_height;
_triangle_angle  = triangle_angle  ? triangle_angle  : ceil((atan(_triangle_width / _triangle_height) / 4) * 3);
