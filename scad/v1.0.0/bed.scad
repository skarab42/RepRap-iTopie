// iTopie RepRap - Bed
//
// @version 1.1.0
// @license GPLv3
// @docs    http://reprap.org/wiki/ITopie  
// @sources https://github.com/lautr3k/RepRap-iTopie 
// @author  Sébastien Mischler <skarab>
// @author  http://www.onlfait.ch
//
// @upddate 2015-07-05 <skarab> first write
// @upddate 2015-07-07 <skarab> add holes
include <config.scad>

// bed triangles
module _triangle(width, height) {
    minkowski() {
        circle(bed_corner_radius);
        offset(-bed_triangle_offset) 
            polygon(points=[[0, 0], [width, 0],[width / 2, height / 2]], paths=[[0, 1, 2]]);
    }
}

// bed triangles
module bed_triangles() {
    translate([bed_margin[0], bed_margin[1], 0]) {
        _triangle(bed_base_width, bed_base_height);
        translate([bed_width - (bed_margin[0] * 2), bed_height - (bed_margin[1] * 2), 0])
            rotate([0, 0, 180])
            _triangle(bed_base_width, bed_base_height);
    }
    translate([bed_margin[0] + bed_base_width, bed_margin[1], 0])
        rotate([0, 0, 90])
            _triangle(bed_base_height, bed_base_width);
    translate([bed_margin[0], bed_height - bed_margin[1], 0])
        rotate([0, 0, 270])
            _triangle(bed_base_height, bed_base_width);
    
}

// bed cross
module bed_cross() {
    hull() {
        translate([bed_corner_radius, bed_corner_radius, 0])
            circle(bed_corner_radius);
        translate([bed_width - bed_corner_radius, bed_height - bed_corner_radius, 0])
            circle(bed_corner_radius);
    }
    hull() {
        translate([bed_corner_radius, bed_height - bed_corner_radius, 0])
            circle(bed_corner_radius);
        translate([bed_width - bed_corner_radius, bed_corner_radius, 0])
            circle(bed_corner_radius);
    }
}

// bed 3 points ergots
module bed_ergots() {
    translate([bed_width / 2, bed_corner_radius, 0]) {
        circle(bed_corner_radius);
        render() difference() {
            translate([-(2 * bed_corner_radius), 0, 0])
                square([4 * bed_corner_radius, bed_corner_radius]);
            translate([bed_corner_radius * 2, 0, 0])
                circle(bed_corner_radius);
            translate([-(bed_corner_radius * 2), 0, 0])
                circle(bed_corner_radius);
        }
    }
    translate([bed_width - bed_corner_radius, bed_height / 2, 0]) {
        circle(bed_corner_radius);
        render() difference() {
            translate([-bed_corner_radius, -(2 * bed_corner_radius), 0])
                square([bed_corner_radius, 4 * bed_corner_radius]);
            translate([0, bed_corner_radius * 2, 0])
                circle(bed_corner_radius);
            translate([0, -(bed_corner_radius * 2), 0])
                circle(bed_corner_radius);
        }
    }
}

// bed base plate
module bed_base() {
    translate([bed_half_width, bed_half_height, 0])
        square([bed_base_width, bed_base_height], center = true);
    bed_ergots();
    bed_cross();
}

// bed holes
module y_lm8_holder_holes() {
    translate([y_lm8_holder_screw_spacing / 2, 0, 0]) 
        circle(bed_holes_radius);
    translate([-y_lm8_holder_screw_spacing / 2, 0, 0]) 
        circle(bed_holes_radius);
}

// bed holes
module bed_holes() {
    // corners
    translate([bed_corner_radius, bed_corner_radius, 0])
        circle(bed_holes_radius);
    translate([bed_width - bed_corner_radius, bed_height - bed_corner_radius, 0])
        circle(bed_holes_radius);
    translate([bed_corner_radius, bed_height - bed_corner_radius, 0])
        circle(bed_holes_radius);
    translate([bed_width - bed_corner_radius, bed_corner_radius, 0])
        circle(bed_holes_radius);

    // ergots
    translate([bed_width / 2, bed_corner_radius, 0])
        circle(bed_holes_radius);
    translate([bed_width - bed_corner_radius, bed_height / 2, 0])
        circle(bed_holes_radius);

    // belt holder
    translate([bed_width / 2, bed_height / 2, 0]) {
        translate([0, y_belt_holder_screw_spacing / 2, 0]) 
            circle(bed_holes_radius);
        translate([0, -y_belt_holder_screw_spacing / 2, 0]) 
            circle(bed_holes_radius);
    }

    // lm8uu holder
    translate([bed_width / 2, bed_height / 2, 0]) {
        spacing = _y_rod_pocket_spacing / 2;
        translate([-spacing, _y_lm8_holder_vspacing, 0]) 
            y_lm8_holder_holes();
        translate([spacing, _y_lm8_holder_vspacing, 0]) 
            y_lm8_holder_holes();
        translate([-spacing, -_y_lm8_holder_vspacing, 0]) 
            y_lm8_holder_holes();
        translate([spacing, -_y_lm8_holder_vspacing, 0]) 
            y_lm8_holder_holes();
    }

    // endstop flag (screw)
    translate([bed_margin[0] + (bed_triangle_offset - bed_corner_radius) / 2, bed_height / 2]) { 
        translate([0, 9, 0])
            circle(bed_holes_radius);
        translate([0, 3, 0])
            circle(bed_holes_radius);
        translate([0, -3, 0])
            circle(bed_holes_radius);
        translate([0, -9, 0])
            circle(bed_holes_radius);
    }
}

// bed
module bed() {
    render() difference() {
        bed_base();
        bed_holes();
        bed_triangles();
    }
}
