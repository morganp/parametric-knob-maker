# parametric-knob-maker
Generate customizable knobs for making toolless hex screws.


## easily create knobs with full customizable parameters
![img](https://github.com/aminGhafoory/parametric-knob-maker/blob/main/images/2022-08-20_191937.png)

![img](https://github.com/aminGhafoory/parametric-knob-maker/blob/main/images/2022-08-20_191947.png)
![img](https://github.com/aminGhafoory/parametric-knob-maker/blob/main/images/2022-08-20_191952.png)
![img](https://github.com/aminGhafoory/parametric-knob-maker/blob/main/images/2022-08-20_192119.png)
![img](https://github.com/aminGhafoory/parametric-knob-maker/blob/main/images/2022-08-20_192142.png)


## Issues
This is cloned from [/aminGhafoory/parametric-knob-maker][2];

[2]: https://github.com/aminGhafoory/parametric-knob-maker/


## HOW TO USE

PreRequisit OpenSCAD installed.

Download to you [Library Location][1]
[1]: https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Libraries

In Openscad file load library and call hex_knob

    include <parametric-knob-maker/parametric_hex_knob.scad> 

    hex_knob();

    //Optional paramters

    // hex_knob(
    //   knob_height, 
    //   knob_diam, 
    //   screwhead_facetoface,
    //   screwhead_depth,
    //   thru_hole_diam,
    //   num_grip_cutouts,
    //   grip_cutout_diam,
    //   cutout_radius_adj
    // );


## DIN standard 

s in this sheet is equivalent for face-to-face length in code

![DIN933](https://user-images.githubusercontent.com/74732606/185756495-7f6f163c-b045-4414-8dcd-da2969b41138.jpg)


