// units in mm
// y-rod holders (4x to be printed in case pockets_depth = 0)
include <../config.scad>
blockX = 24;
blockY = 24;
blockZ = 12;

difference(){
    translate([-blockX/2,0,0]) cube([blockX,blockY,blockZ]);
    translate([0,0,y_rod_pockets_size[0]/2]) rotate([-90,0,0]) cylinder(d=y_rod_pockets_size[0],h=y_rod_pockets_size[1]);
    translate([y_rod_holes_margin+y_rod_pockets_size[0]/2,y_rod_pockets_size[1]/2,0]) cylinder(r=m3_screw_radius,h=blockZ);
    translate([-y_rod_holes_margin-y_rod_pockets_size[0]/2,y_rod_pockets_size[1]/2,0]) cylinder(r=m3_screw_radius,h=blockZ);
}

