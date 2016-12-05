// iTopie RepRap - Configuration
//
// @version 1.0.1
// @license GPLv3
// @docs    http://reprap.org/wiki/ITopie  
// @sources https://github.com/lautr3k/RepRap-iTopie 
// @author  Sébastien Mischler <skarab>
// @author  http://www.onlfait.ch
//
$fn = 50;

// ---------------------------------------------------------------- //
// output settings
// ---------------------------------------------------------------- //
// output version
// 0 : CNC milling (default)
// 1 : Laser cutting
output_version = 0;

// output mode
// 0 : 2D preview (default)
// 1 : extruded view (slow)
// 2 : export first layer (plates)
// 3 : export second layer (pockets)
// 4 : build preview (slow)
output_mode = 0;

// output type
// 0 : all parts
// 1 : plate 1 (horizontal_plate, y_carriage, feet)
// 2 : plate 2 (vertical_plate, triangles, feet)
// 3 : horizontal_plate
// 4 : vertical_plate
// 5 : y_carriage
// 6 : triangle
// 7 : feet
output_type = 0;

// parts margin (mode : 0-3)
parts_margin = 10;

// ---------------------------------------------------------------- //
// drawing settings
// ---------------------------------------------------------------- //
sheet_thickness = 16;                    // raw sheet thickness
pockets_depth   = 6;                     // pockets depth
pockets_color   = "RoyalBlue";           // pockets color
connector_size  = [20, sheet_thickness]; // pockets/fingers [width, height]
cutter_size     = 3.175;                 // size of the smallest cutter you are using 1/8" = 3.175
dogbone         = false;                 // cut dogbones?
cutter_size     = 3.175/2;                 // size of the smallest cutter you are using 1/4" = 3.175

// ---------------------------------------------------------------- //
// shortcuts
// ---------------------------------------------------------------- //
m3_screw_radius = 1.5;
m4_screw_radius = 2;
dogbone_offset = sqrt(cutter_size*cutter_size/2);

// ---------------------------------------------------------------- //
// horizontal plate
// ---------------------------------------------------------------- //
horizontal_plate_width         = 390;              // 
horizontal_plate_height        = 440;              // 
horizontal_plate_borders       = [40, 82, 40, 82]; // borders weight       [top, right, bottom, left]
horizontal_plate_outer_corners = [10, 10, 10, 10]; // outer corners radius [topLeft, topRight, bottomRight, bottoLeft]
horizontal_plate_inner_corners = [30, 30, 30, 30]; // inner corners radius [topLeft, topRight, bottomRight, bottoLeft]

// y motor mount
y_motor_mount_width   = 50;              //
y_motor_mount_height  = 36;              //
y_motor_mount_corners = [5, 5, 10, 10];  // corners radius [topLeft, topRight, bottomRight, bottoLeft]
y_motor_mount_angle   = 8;               // motor rotation angle (belt tensionner) 0 = disabled
y_motor_holes_radius  = m3_screw_radius; // y motor screw holes radius

// z_motor mount
z_motor_mount_margin  = 8;     // between the "motor" and the "z_plate" (border to border)
z_motor_mount_spacing = undef; // between the two motor mount (axis to axis) [undef = auto]

z_motor_holes_radius = m3_screw_radius; // z motor screw holes radius

// z rods
z_rod_spacing = 17; // between the "motor" and the "z rod" (axis to axis)
z_rod_radius  = 4;  // z smoothe rod radius

z_rod_holder_holes_radius  = m3_screw_radius; // z rod top holder holes radius
z_rod_holder_holes_margin  = [12, 6];         // [from the top frame border, between the z rod and the first holder hole (axis to axis)]
z_rod_holder_holes_spacing = 20;              // between the two holder holes (axis to axis)

// y idler mount
y_idler_mount_width       = 44;             //
y_idler_mount_height      = 24;             //
y_idler_mount_corners     = [5, 5, 10, 10]; // corners radius [topLeft, topRight, bottomRight, bottoLeft]
y_idler_mount_hole_radius = 2.5;            // y idler bearing hole radius

// y idler pocket
y_idler_pocket_width   = undef;                 // idler pocket width [undef = auto]
y_idler_pockets_height = y_idler_mount_height;  // idler pocket height

// y endstop mount
y_endstop_mount_width    = 25;                 //
y_endstop_mount_height   = 16.4;               //
y_endstop_mount_corners  = [8.2, 8.2, 10, 10]; // corners radius [topLeft, topRight, bottomRight, bottoLeft]
y_endstop_mount_position = 82;                 // from the frame top border to the endstop top border

// ---------------------------------------------------------------- //
// vertical plate
// ---------------------------------------------------------------- //
// vertical plate
vertical_plate_width         = horizontal_plate_width;  // outer width
vertical_plate_height        = horizontal_plate_height; // outer height
vertical_plate_borders       = [60, 60, undef, 60];     // borders weight       [top, right, bottom, left]
vertical_plate_outer_corners = [10, 10, 10, 10];        // outer corners radius [topLeft, topRight, bottomRight, bottoLeft]
vertical_plate_inner_corners = [10, 10, 10, 10];        // inner corners radius [topLeft, topRight, bottomRight, bottoLeft]
vertical_plate_position      = undef;                   // y position from the horizontal plate bottom border      

// ---------------------------------------------------------------- //
// logo
// ---------------------------------------------------------------- //
dxf_logo   = "logo.dxf"; // path to DXF logo
logo_depth = 2;          // logo pocket depth (set to undef for through cut)


// ---------------------------------------------------------------- //
// rear triangles
// ---------------------------------------------------------------- //
triangle_width  = undef;               // rear triangle width         [undef = auto]
triangle_height = undef;               // rear triangle height        [undef = auto]
triangle_angle  = undef;               // rear triangle angle         [undef = auto]
triangle_margin = [undef, 15, 15, 15]; // rear triangle margin        [top, right, bottom, left]
triangle_radius = 10;                  // rear triangle corner radius [undef = auto]

triangle_connectors_size   = [connector_size[1], connector_size[0]]; // rotate 90°
triangle_connectors_margin = [63, 22, undef, 22];                    // pockets margin [top, right, ---, left]

triangle_holes_radius = m4_screw_radius; // screws holes radius
triangle_holes_margin = 20;              // screws margin (from z triangle pocket border)

// ---------------------------------------------------------------- //
// y carriage
// ---------------------------------------------------------------- //
y_carriage_corners_holes_spacing = [209, 209];      // [x, y] axis to axis
y_carriage_outer_offset          = [11, 11];        // [x, y]
y_carriage_holes_radius          = m3_screw_radius; //
y_carriage_ergots_radius         = 5.5;             //
y_carriage_triangle_offset       = 10;              // inner offset
y_carriage_triangle_margin       = [11, 11];        // [x, y]
y_carriage_thumbwheel_radius     = 10;

y_carriage_belt_holder_offset        = 2;     // offset position from y carriage axis (issue#13)
y_carriage_belt_holder_screw_spacing = 16;    // y belt holder holes spacing (axis to axis) 
y_carriage_lm8_holder_screw_spacing  = 24;    // y lm8uu holder holes spacing (axis to axis) 
y_carriage_lm8_holder_vspacing       = undef; // lm8uu holder vertical spacing (axis to axis)

y_rod_pockets_size = [8, 20];         // pockets size   [rod diameter, length]
y_rod_spacing      = undef;           // pockets spacing (axis to axis) [undef = auto]
y_rod_holes_radius = m3_screw_radius; // y rod screws holes radius
y_rod_holes_margin = 4;               // y rod screws margin (from y rod pocket border)

y_endstop_holes_radius  = m3_screw_radius; // endstop screws holes radius
y_endstop_holes_spacing = 9.5;             // between the two endstop screws (axis to axis)

// ---------------------------------------------------------------- //
// feet
// ---------------------------------------------------------------- //
feet_width      = horizontal_plate_width;  // 
feet_height     = 60;                      // 
feet_corners    = [10, 10, 10, 10];        // corners radius [leftOut, leftIn, rightIn, rightOut]
feet_gap_height = 20;                      // gap height ?

feet_connectors_size   = connector_size;       //
feet_connectors_margin = [10.5, 40, 10.5, 40]; // pockets margin [top, right, bottom, left]

feet_holes_radius = m4_screw_radius; // feet screws holes radius
feet_holes_margin = 10;              // feet screws horizontal margin (for fine adjustement)

foot_width = 40; //

// ---------------------------------------------------------------- //
//     CHANGE NOTHING BELOW, UNLESS YOU KNOW WHAT YOU ARE DOING
// ---------------------------------------------------------------- //

// ---------------------------------------------------------------- //
// pockets
// ---------------------------------------------------------------- //
pockets_height = sheet_thickness - pockets_depth;

// ---------------------------------------------------------------- //
// y carriage
// ---------------------------------------------------------------- //
y_carriage_corners_diameter = y_carriage_ergots_radius * 2;
y_carriage_width            = y_carriage_corners_holes_spacing[0] + y_carriage_corners_diameter;
y_carriage_height           = y_carriage_corners_holes_spacing[1] + y_carriage_corners_diameter;

// ---------------------------------------------------------------- //
// y rods
// ---------------------------------------------------------------- //
y_rod_pockets_spacing = y_rod_spacing ? y_rod_spacing : y_carriage_width / 2;

// ---------------------------------------------------------------- //
// horizontal plate
// ---------------------------------------------------------------- //
horizontal_plate_computed_borders = [horizontal_plate_borders[0] + horizontal_plate_borders[2], horizontal_plate_borders[1] + horizontal_plate_borders[3]];
horizontal_plate_inner_width      = horizontal_plate_width - horizontal_plate_computed_borders[1];
horizontal_plate_inner_height     = horizontal_plate_height - horizontal_plate_computed_borders[0];

// z motor mount auto spacing
z_motor_spacing = z_motor_mount_spacing ? z_motor_mount_spacing : horizontal_plate_width - 60;

// ---------------------------------------------------------------- //
// vertical plate
// ---------------------------------------------------------------- //
vertical_plate_y_position       = vertical_plate_position ? vertical_plate_position : (horizontal_plate_inner_height / 2) + horizontal_plate_borders[2] + 66;
vertical_plate_computed_borders = [vertical_plate_borders[0], vertical_plate_borders[1] + vertical_plate_borders[3]];
vertical_plate_inner_width      = vertical_plate_width - vertical_plate_computed_borders[1];
vertical_plate_inner_height     = vertical_plate_height - vertical_plate_computed_borders[0];

triangle_max_width  = horizontal_plate_height - vertical_plate_y_position - sheet_thickness;
triangle_max_height = vertical_plate_inner_height - feet_height;

_triangle_width  = triangle_width && triangle_width <= triangle_max_width  ? triangle_width  : triangle_max_width;
_triangle_height = triangle_height && triangle_height <= triangle_max_height ? triangle_height : triangle_max_height;
_triangle_angle  = triangle_angle  ? triangle_angle  : ceil((atan(_triangle_width / _triangle_height) / 4) * 3);
