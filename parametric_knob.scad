// 
// 
// Call 'knob' function to place Knob on schematic centred on the xy origin, z=0 to KNOB_HEIGHT + OFFSET_HEIGHT.
// FUTURE
//   Cutouts params should scale based on knob diameter to always give a good look


module knob(knob_height, knob_diam, offset_height, offset_diam, knob_chamfer, base_chamfer, num_grip_cutouts, grip_cutout_diam, cutout_radius_adj, knob_color ) {

  //Set defaults for parameters not specified
  //knob parameters
  KNOB_HEIGHT          = is_undef( knob_height )? 15 : knob_height;
  KNOB_DIAM            = is_undef( knob_diam )?   30 : knob_diam;

  //Offset under Knob
  OFFSET_HEIGHT        = is_undef( offset_height )?          5 : offset_height;
  OFFSET_DIAM          = is_undef( offset_diam )?  KNOB_DIAM/2 : offset_diam;

  //edge chamfers
  KNOB_CHAMFER         = is_undef( knob_chamfer )? 2 : knob_chamfer; // at 45Degrees
  BASE_CHAMFER         = is_undef( base_chamfer )? 1 : base_chamfer; // at 45Degrees
  
  //grippy cutouts parameters
  NUM_GRIP_CUTOUTS     = is_undef( num_grip_cutouts )? 15 : num_grip_cutouts; 
  GRIP_CUTOUT_DIAM     = is_undef( grip_cutout_diam )?  4 : grip_cutout_diam; 
  CUTOUT_RADIUS_ADJ    = is_undef( cutout_radius_adj )? 1 : cutout_radius_adj;

  KNOB_COLOR           = is_undef( knob_color )? "red" : knob_color;

  //Knob Profile
  color( KNOB_COLOR ) {
    difference() {
      rotate_extrude(){
        union() {
          translate([0,OFFSET_HEIGHT]){
            difference(){
              //Main body of the Knob
              translate([0, 0]) {
                square([(KNOB_DIAM)/2,KNOB_HEIGHT],center=false);
              }
              //Knob Top Chamfer
              translate([KNOB_DIAM/2, KNOB_HEIGHT]) {
                polygon([[0,0],[-KNOB_CHAMFER,0],[0, -KNOB_CHAMFER]]);
              }
              //Knob Base Chamfer
              translate([KNOB_DIAM/2, 0]) {
                polygon([[0,0], [0, KNOB_CHAMFER],[-KNOB_CHAMFER,0]]);
              }
            }
          } // Translate OFFSET_HEIGHT
             
          //Offset with Chamfer
          difference(){
            //Offset body of the Knob
            translate([0, 0]) {
              square([(OFFSET_DIAM)/2,OFFSET_HEIGHT],center=false);
            }
            //Base Chamfer
            translate([OFFSET_DIAM/2, 0]) {
              polygon([[0,0], [0, BASE_CHAMFER],[-BASE_CHAMFER,0]]);
            }
          } // Offset with Chamfer
        } //Union Knob & Offset
      } //rotate_extrude      
    
      //grippyCutouts
      for(i=[1:NUM_GRIP_CUTOUTS]){
        rot_angle=(360/NUM_GRIP_CUTOUTS)*i;
          translate([0,0,OFFSET_HEIGHT])
            rotate_on_circle(rot_angle,(KNOB_DIAM/2)+CUTOUT_RADIUS_ADJ)
              cylinder(r=GRIP_CUTOUT_DIAM/2,h=KNOB_HEIGHT+0.01,center=false,$fn=64);
      } //Grippy cutout
    } //DIFF sub grips
  } // Close color
}// module knob
      
      
  // a=angle, r=radius of rotation
  module rotate_on_circle(angle, radius) {
    dx=radius*sin(angle);
    dy=radius*cos(angle);
    translate([dx,dy,0])
    children();   
  }

      


