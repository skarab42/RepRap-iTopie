// iTopie RepRap - Shapes modules
//
// @version 1.1.0
// @license GPLv3
// @docs    http://reprap.org/wiki/ITopie  
// @sources https://github.com/lautr3k/RepRap-iTopie 
// @author  Sébastien Mischler <skarab>
// @author  http://www.onlfait.ch
//
module corner(radius = 0) {
    render() difference() {
        square([radius, radius]);
        translate([radius, radius, 0])
            circle(radius);
    }
}

module rounded_square(width, height, radius = 0, corner_radius = [0, 0, 0, 0]) {
    render() difference() {
        square([width, height]);
        if (radius > 0 || corner_radius[3] > 0) {
            corner(radius > 0 ? radius : corner_radius[3]);
        }
        if (radius > 0 || corner_radius[0] > 0) {
            translate([0, height, 0])
                rotate([0, 0, -90])
                    corner(radius > 0 ? radius : corner_radius[0]);
        }
        if (radius > 0 || corner_radius[1] > 0) {
            translate([width, height, 0])
                rotate([0, 0, -180])
                    corner(radius > 0 ? radius : corner_radius[1]);
        }
        if (radius > 0 || corner_radius[2] > 0) {
            translate([width, 0, 0])
                rotate([0, 0, -270])
                    corner(radius > 0 ? radius : corner_radius[2]);
        }
    }
}

module y_mount(width, height, corner_radius) {
    render() union() {    
        rounded_square(width, height, corner_radius = [corner_radius[0], corner_radius[1], 0, 0]);
        translate([width, 0, 0])
            corner(corner_radius[2]);
        rotate([0, 180, 0])
            corner(corner_radius[3]);
    }
}
