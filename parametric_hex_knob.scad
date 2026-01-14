
module FaceToFaceHex(width,height){

    cube([width/sqrt(3),width,height],center = true,$fn=64);
    rotate([0,0,120])cube([width/sqrt(3),width,height],center = true);
    rotate([0,0,240])cube([width/sqrt(3),width,height],center = true);

}
// a=angle, r=radius of rotation
module rotate_on_circle(angle, radius) {
    dx=radius*sin(angle);
    dy=radius*cos(angle);
    translate([dx,dy,0])
    children();   
}

// Call this function to place Knob on schematic.
// Will 'centred?' palce on Origin
module hex_knob(knob_height, knob_diam,screwhead_facetoface,screwhead_depth, thru_hole_diam,num_grip_cutouts, grip_cutout_diam,cutout_radius_adj ) {

//knob parameters
KNOB_HEIGHT= is_undef( knob_height )?15:knob_height; //
KNOB_DIAM=is_undef( KNOB_DIAM )?30:knob_diam; //30;

//screw parameters
SCREWHEAD_FACETOFACE=is_undef( SCREWHEAD_FACETOFACE )?8:screwhead_facetoface; //8;
SCREWHEAD_DEPTH=is_undef( SCREWHEAD_DEPTH )?12:screwhead_depth; //12;
THRU_HOLE_DIAM=is_undef( THRU_HOLE_DIAM )?4:thru_hole_diam; //4;

//grippy cutouts parameters
NUM_GRIP_CUTOUTS=is_undef( NUM_GRIP_CUTOUTS )?20:num_grip_cutouts; //20;
GRIP_CUTOUT_DIAM=is_undef( GRIP_CUTOUT_DIAM )?4:grip_cutout_diam; //4;
CUTOUT_RADIUS_ADJ=is_undef( CUTOUT_RADIUS_ADJ )?1:cutout_radius_adj; //1;



 difference(){

      //Knob
      union(){
          translate([0, 0, -(((KNOB_HEIGHT-SCREWHEAD_DEPTH)/2)+0.01)]) 
              cylinder(r=KNOB_DIAM/2, h=KNOB_HEIGHT, center=true,$fn=64);
          translate([0, 0, -(((KNOB_HEIGHT-SCREWHEAD_DEPTH+KNOB_HEIGHT)/2))]) {
              cylinder(r=KNOB_DIAM/4, h=KNOB_HEIGHT/2, center=true,$fn=64);
          }
          
      };

      //screw
      union(){
          //screwHead
          FaceToFaceHex(SCREWHEAD_FACETOFACE,SCREWHEAD_DEPTH);
          //screwHole
          translate([0, 0, -(((KNOB_HEIGHT+SCREWHEAD_DEPTH)/2)+0.001)]) 
              cylinder(r=THRU_HOLE_DIAM/2, h=KNOB_HEIGHT+KNOB_HEIGHT/2+0.001, center=true,$fn=64);
          };

      //grippyCutouts
      for(i=[1:NUM_GRIP_CUTOUTS]){

          rot_angle=(360/NUM_GRIP_CUTOUTS)*i;
          translate([0,0,-(((KNOB_HEIGHT-SCREWHEAD_DEPTH)/2)+0.01)])
              rotate_on_circle(rot_angle,(KNOB_DIAM/2)+CUTOUT_RADIUS_ADJ)
              cylinder(r=GRIP_CUTOUT_DIAM/2,h=KNOB_HEIGHT+0.01,center=true,$fn=64);
      };
      
      //top filet
      translate([0, 0,-(((KNOB_HEIGHT-SCREWHEAD_DEPTH)/2)-0.1)])
        rotate_extrude()
          polygon(points = [[KNOB_DIAM,KNOB_HEIGHT], [0,KNOB_HEIGHT+2],[0,KNOB_HEIGHT],[KNOB_DIAM/1.29,0]],$fn=100);
      //down filet
      translate([0, 0,-(((KNOB_HEIGHT-SCREWHEAD_DEPTH)/2)+0.1)])
        rotate_extrude()
          polygon(points = [[-KNOB_DIAM,-KNOB_HEIGHT], [0,-KNOB_HEIGHT-2],[0,-KNOB_HEIGHT],[-KNOB_DIAM/1.29,0]],$fn=100);

  }
}
    
