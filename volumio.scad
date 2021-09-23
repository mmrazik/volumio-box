/* nothing to be proud of here; spaghetti....*/

pi_length = 85.2;
pi_width = 56;
$fn=100;
wall_width = 3;
pi_board_thickness=1.5;
control_board_width = 30;
control_board_length = 70;
control_board_thickness = 1.6;

//translate([wall_width, wall_width, wall_width]) ;

module nut_holder(holder_height, gradual_part_height, include_insert) {
    cylinder_diameter=8;
    hole_diameter=3.4;
    insert_diameter = 5;
    insert_length = 6.2;
    difference() {
        hull() {        
            translate([0, 0 ,0])
                cube([cylinder_diameter, 0.01, 0.01]);
            translate([0, 0 ,holder_height+gradual_part_height])
                cube([cylinder_diameter, 0.01, 0.01]);
            translate([cylinder_diameter/2,cylinder_diameter/2, gradual_part_height]) {                 
                cylinder(r=cylinder_diameter/2, h=0.01);
                cylinder(r=cylinder_diameter/2, h=holder_height+0.01);
            }
        }
        
        translate([cylinder_diameter/2,cylinder_diameter/2, gradual_part_height]) cylinder(r=hole_diameter/2, h = holder_height+0.1, $fn=128);
        
        if (include_insert) {
            translate([cylinder_diameter/2,cylinder_diameter/2, gradual_part_height+ holder_height- insert_length]) cylinder(r=insert_diameter/2, h = insert_length+0.1, $fn=128);
        }
    }
}


pin_mounts_height= 4;
//translate([200,0,0]) raspberry_full();

module raspberry_base() {    
    #translate([0,0,0]) { // this is to move all the pins
          translate([3.5,23.5,0]) cylinder(pin_mounts_height,d=2.7, center=true);     // mount top-r
          translate([3.5,pi_length-3.5,0]) cylinder(pin_mounts_height,d=2.7, center=true);  // mount bot-r
          translate([49+3.5,23.5,0]) cylinder(pin_mounts_height,d=2.7, center=true);     // mount top-l
          translate([49+3.5,pi_length-3.5,0]) cylinder(pin_mounts_height,d=2.7, center=true);  // mount bot-l          
    }
    translate([0,0, 0]) %cube([pi_width, pi_length, pi_board_thickness]);    
    translate([0,0, 0]) #cube([pi_width, 1, pi_board_thickness]);
}


module control_board_base() {
    mounting_hole_d = 2.1;    
    #translate([0,0,0]) { // this is to move all the pins
          translate([2,2,0]) cylinder(pin_mounts_height,d=mounting_hole_d, center=true);     // mount top-r
          translate([2,control_board_length-2,0]) cylinder(pin_mounts_height,d=mounting_hole_d, center=true);  // mount bot-r
          translate([control_board_width-2,control_board_length-2,0]) cylinder(pin_mounts_height,d=mounting_hole_d, center=true);     // mount top-l
          translate([control_board_width-2,2,0]) cylinder(pin_mounts_height,d=mounting_hole_d, center=true);  // mount bot-l          
    }
    translate([0,0, 0]) %cube([control_board_width, control_board_length, control_board_thickness]);    
}


module control_board_mounts() {
    cylinder_diameter=8;
    hole_diameter=3.4;
    insert_diameter = 5;
    difference() {
        union() { 
              translate([2,2,0]) cylinder(control_board_pins_height,d=cylinder_diameter, center=false);
              translate([2,control_board_length-2,0]) cylinder(control_board_pins_height,d=cylinder_diameter, center=false);
              translate([control_board_width-2,control_board_length-2,0]) cylinder(control_board_pins_height,d=cylinder_diameter, center=false);
              translate([control_board_width-2,2,0]) cylinder(control_board_pins_height,d=cylinder_diameter, center=false);
        }    
        union() { 
             translate([2,2,0]) cylinder(control_board_pins_height,d=insert_diameter, center=false);
              translate([2,control_board_length-2,0]) cylinder(control_board_pins_height,d=insert_diameter, center=false);
              translate([control_board_width-2,control_board_length-2,0]) cylinder(control_board_pins_height,d=insert_diameter, center=false);
              translate([control_board_width-2,2,0]) cylinder(control_board_pins_height,d=insert_diameter, center=false);
        }
    }
}



module raspberry_full() {
        raspberry_base();
        usb_width=14;
        #translate([9,-3+17.44/2, pi_board_thickness+15.6/2]) cube([usb_width, 17.44, 15.6], center=true);  // USB 2.0 
        #translate([27,-3+17.44/2, pi_board_thickness+15.6/2]) cube([usb_width, 17.44, 15.6], center=true);  // USB 2.0         
        #translate([45.75,-3+21.3/2, pi_board_thickness+13.6/2]) cube([16.8, 21.3,13.6], center=true); //ethernet port
        
        
          

        
        #translate([-wall_width, pi_length-6.7-9.4, pi_board_thickness-0.4]) cube([wall_width*2, 9.8, 4.2]); // USB type c power
        #translate([-wall_width, pi_length-6.7-9.4-14.8, pi_board_thickness-0.4]) cube([wall_width*2, 8.4, 4.2]);  // Micro HDMI0
        #translate([-wall_width, pi_length-6.7-9.4-14.8-13.5, pi_board_thickness-0.4]) cube([wall_width*2, 8.4, 4.2]);  // Micro HDMI1
        jack_hole_diameter=7;
        #translate([-wall_width, pi_length-6.7-9.4-14.8-13.5+8.4/2-14.3, pi_board_thickness+2.8]) rotate([0,90,0]) cylinder(h=wall_width*2, d=7);  // audio jack
          
        #translate([pi_width/2-6, pi_length-1, -pin_mounts_height]) {
            //cube([12, 15, pin_mounts_height+pi_board_thickness ]); // microSD
            hull() {
                translate([0,0,pin_mounts_height+pi_board_thickness-0.001]) {cube([12, 15,  0.001]);} // microSD
                diam = 18;
                translate([12/2,5,-5]) cylinder(d=diam,h=4);
            }
        }
    
}

module raspberry_mounts() {
    cylinder_diameter=8;
    hole_diameter=3.4;
    insert_diameter = 5;
    difference() {
        union() { 
              translate([3.5,27,0]) cylinder(pin_mounts_height+pi_board_thickness,d=8, center=false);
              translate([3.5,pi_length,0]) cylinder(pin_mounts_height+pi_board_thickness,d=8, center=false);
              difference() {
                translate([49+3.5,27,0]) cylinder(pin_mounts_height+pi_board_thickness,d=8, center=false);
                translate([39.6,22,0]) cube([10,10,10]);
              }
              translate([49+3.5,pi_length,0]) cylinder(pin_mounts_height+pi_board_thickness,d=8, center=false);
        }    
        union() { 
             translate([3.5,27,0]) cylinder(pin_mounts_height+pi_board_thickness,d=insert_diameter, center=false);
              translate([3.5,pi_length,0]) cylinder(pin_mounts_height+pi_board_thickness,d=insert_diameter, center=false);
              translate([49+3.5,27,0]) cylinder(pin_mounts_height+pi_board_thickness,d=insert_diameter, center=false);
              translate([49+3.5,pi_length,0]) cylinder(pin_mounts_height+pi_board_thickness,d=insert_diameter, center=false);
        }
    }
}

control_board_pins_height = 8.7;

module mounting_tip(wall_width, height,mount_hole_diameter) {
       difference() {
           hull() {
              cylinder(d=8, h=height-wall_width);
              translate([-mount_hole_diameter/2, -mount_hole_diameter/2, 0]) cube([0.001,8, height-wall_width]);
           }
           cylinder(d=3.2,h=height);
       }
}

module box_top(width, length, height, wall_width) {
           holder_height=5;
           gradual_part_height=7;
           mount_hole_diameter = 8;
  difference() {
    union() {
        difference() {
            union() {
               translate([wall_width, wall_width, 0]) hull() { 
                translate([0,0,0]) cylinder(h=height, r=wall_width);
                translate([width,0,0]) cylinder(h=height, r=wall_width);
                translate([width,length,0]) cylinder(h=height, r=wall_width);
                translate([0,length,0]) cylinder(h=height, r=wall_width);
               }
           }
           translate([wall_width, wall_width, wall_width]) cube([width, length, height]);           
           
           //translate([width+2*wall_width-control_board_width-wall_width-0.6, length+2*wall_width-control_board_length-0.5*(length+2*wall_width-control_board_length),27])
           
           translate([control_board_width+wall_width+0.6,length+2*wall_width-control_board_length-0.5*(length+2*wall_width-control_board_length),control_board_thickness+control_board_pins_height+wall_width])
           { 
                rotate([0,180,0]) control_board_full(include_power_button=false);            
           }
           
           translate([width-28,length-30,0]) fan_hole();
           

           
           // tiny, tiny cutout for the usb/ethernet ports
           translate([wall_width+8+28,0,wall_width+pi_board_thickness*2+pin_mounts_height+4]) cube([width-8-28,0.2, 17.1]);  
           
       }
       

           translate([wall_width+mount_hole_diameter/2, wall_width+mount_hole_diameter/2, wall_width]) 
               mounting_tip(wall_width, height,mount_hole_diameter);    
           translate([wall_width+mount_hole_diameter/2, length+wall_width-mount_hole_diameter/2, wall_width])
               mounting_tip(wall_width, height,mount_hole_diameter); 
           translate([width-1, 23.5-0.8, wall_width]) rotate([0,0,180]) mounting_tip(wall_width, height,mount_hole_diameter); 
           translate([width-8, length-1, wall_width]) rotate([0,0,-90]) mounting_tip(wall_width, height, mount_hole_diameter);  
       
       translate([wall_width+0.6,
                  length+2*wall_width-control_board_length-0.5*(length+2*wall_width-control_board_length),
                  wall_width])
          control_board_mounts();
       
       //front cutout
       //       #translate([wall_width,0,wall_width+pi_board_thickness*2+pin_mounts_height]) cube([width-8,wall_width, 20]);

       difference() {
       translate([wall_width+8,0,wall_width+pi_board_thickness*2+pin_mounts_height]) cube([width-8,wall_width, height+3.5]);  
       translate([wall_width+8,0,wall_width+pi_board_thickness*2+pin_mounts_height]) cube([width-8,0.2, height+3.5]);  
       }
       //#translate([wall_width+8,0,wall_width+pi_board_thickness*2+pin_mounts_height]) cube([width-8,0.2, 17.1]);  
       
       thickness=2;
       /*
            #translate([9,-3.24+17.44/2, pi_board_thickness+15.6/2]) cube([usb_width, 17.44, 15.6], center=true);  // USB 2.0 
            #translate([27,-3.24+17.44/2, pi_board_thickness+15.6/2]) cube([usb_width, 17.44, 15.6], center=true);  // USB 2.0         
            #translate([45.75,-3.24+21.3/2, pi_board_thickness+13.6/2]) #cube([16.8, 21.3,13.6], center=true); //ethernet port
       */
       
       hull() {
        translate([width+wall_width-thickness,wall_width,wall_width]) #cube([thickness,20,0.001]);
        translate([width+wall_width-thickness,wall_width,wall_width+height+control_board_pins_height+1.8]) #cube([thickness,0.001,0.001]);
       }
       
       hull() {
        translate([width+wall_width-27+8,wall_width,wall_width]) #cube([thickness,20,0.001]);
        translate([width+wall_width-27+8,wall_width,wall_width+height+control_board_pins_height+1.8]) #cube([thickness,0.001,0.001]);
       }
       
       hull() {
        translate([width+wall_width-45.75+9,wall_width,wall_width]) #cube([thickness,20,0.001]);
        translate([width+wall_width-45.75+9,wall_width,wall_width+height+control_board_pins_height+1.8]) #cube([thickness,0.001,0.001]);
       }   
    }
               
     //mounting holes
      hole_diam=3.2;
      head_diam=5.8;
      head_height=4;
      translate([wall_width+mount_hole_diameter/2, wall_width+mount_hole_diameter/2, 0]) cylinder(d=hole_diam,h=height);
      translate([wall_width+mount_hole_diameter/2, wall_width+mount_hole_diameter/2, 0]) cylinder(d=head_diam,h=head_height);
      translate([wall_width+mount_hole_diameter/2, length+wall_width-mount_hole_diameter/2, 0]) cylinder(d=hole_diam,h=height);
      translate([wall_width+mount_hole_diameter/2, length+wall_width-mount_hole_diameter/2, 0]) cylinder(d=head_diam,h=head_height);
      translate([width-1, 23.5-0.8, 0]) rotate([0,0,180]) cylinder(d=hole_diam,h=height); 
      translate([width-1, 23.5-0.8, 0]) rotate([0,0,180]) cylinder(d=head_diam,h=head_height);
      translate([width-8, length-1, 0]) rotate([0,0,-90]) cylinder(d=hole_diam,h=height); 
      translate([width-8, length-1, 0]) rotate([0,0,-90]) cylinder(d=head_diam,h=head_height);
    
    rotate([0,-180,0]) #translate([-box_width-wall_width, wall_width, wall_width+pi_board_thickness+pin_mounts_height-bottom_height-top_height])  raspberry_full();
  }
   


}

module screw_insert(height, lower_diam, upper_diam) {
    hull() {
        cylinder(h=0.001,d=upper_diam);
        translate([0,0,height]) cylinder(h=0.001,d=lower_diam);
    } 
}

//translate([100,0,0]) fan_hole();

module fan_hole() {    
    fan_hole_diameter = 39;
    fan_screw_diameter=5;
    cylinder_diam = 6;
    cylinder_height = 2;
    honey_diam=3;
    honey_line_width=0.4;
    grill_height = 1.6;    
    translate([0,0,grill_height]) cylinder(h=wall_width-grill_height,d=fan_hole_diameter);
    
    intersection() {
    cylinder(h=grill_height,d=fan_hole_diameter);
    for (i=[-5:5]) {
        for (j=[-5:5]) {
            translate([i*(honey_diam+honey_line_width),j*(honey_diam+honey_line_width),0]) cylinder(d=honey_diam, h=2,$fn=6);
            //rotate([0,0,22.5])  translate([i*2,j*2-10,0]) cube([honey_line_width, fan_hole_diameter, grill_height]);
            //rotate([0,0,-22.5]) translate([i*2,j*2--10,0]) cube([honey_line_width, fan_hole_diameter, grill_height]);
        }
    }
    }
    
    translate([16,16,0]) cylinder(h=wall_width,d=fan_screw_diameter);    
        translate([16,16,0]) screw_insert(cylinder_height, fan_screw_diameter, cylinder_diam);
    translate([-16,16,0]) cylinder(h=wall_width,d=fan_screw_diameter);
        translate([-16,16,0]) screw_insert(cylinder_height, fan_screw_diameter, cylinder_diam);
    translate([-16,-16,0]) cylinder(h=wall_width,d=fan_screw_diameter);
        translate([-16,-16,0]) screw_insert(cylinder_height, fan_screw_diameter, cylinder_diam);
    translate([16,-16,0]) cylinder(h=wall_width,d=fan_screw_diameter);
        translate([16,-16,0]) screw_insert(cylinder_height, fan_screw_diameter, cylinder_diam);
    
}

power_button_offset = 15;
power_button_d = 16.4;
control_board_bottom_offset = 27;

module control_board_full(include_power_button=true) {
   control_board_base();
   
   translate([control_board_width - 10,33.8,control_board_thickness]) { 
       cylinder(h=12,d=12.6);  // middle button
       translate([13-0.2, -3.5, 12-10]) scale(0.18) rotate([90,0,90]) linear_extrude(20)  import("svg/play_pause.svg");
   }
    
   translate([control_board_width - 10,33.8+17.78,control_board_thickness]) {       
       cylinder(h=12,d=12.6);
       translate([13-0.2, -5.6, 12-10]) scale(0.18) rotate([90,0,90]) linear_extrude(20)  import("svg/next.svg");
   }
   translate([control_board_width - 10,33.8-17.78,control_board_thickness]) { 
       cylinder(h=12,d=12.6);
       translate([13-0.2, -6, 12-10]) scale(0.18) rotate([90,0,90]) linear_extrude(20)  import("svg/previous.svg");
   }
   if (include_power_button)
     rotate([0,90,0]) translate([power_button_offset, control_board_length/2,0]) cylinder(h=36,d=power_button_d);
}

module box_bottom(width, length, height, wall_width) {
    
   difference() {
       union() {
           translate([wall_width, wall_width, 0]) hull() { 
            translate([0,0,0]) cylinder(h=height, r=wall_width);
            translate([width,0,0]) cylinder(h=height, r=wall_width);
            translate([width,length,0]) cylinder(h=height, r=wall_width);
            translate([0,length,0]) cylinder(h=height, r=wall_width);
           }                      
       }
       
       translate([wall_width, wall_width, wall_width]) cube([width, length, height]);
       translate([width+2*wall_width-control_board_width-wall_width-0.6, length+2*wall_width-control_board_length-0.5*(length+2*wall_width-control_board_length),control_board_bottom_offset]) { 
            control_board_full();
       }
       
       //front cut-out
       #translate([wall_width,0,wall_width+pi_board_thickness*2+pin_mounts_height]) cube([width-8,wall_width, 20]);
            
      translate([wall_width, 3.6, wall_width+pi_board_thickness+pin_mounts_height]) {
        raspberry_full();
          
      }
   }
   #translate([wall_width, 0, wall_width]) raspberry_mounts();
   

   //translate([0,0,wall_width]) #raspberry_mounts();
   
   holder_height=5;
   gradual_part_height=7;
   translate([wall_width, 23.5+8/2-0.8, height-12]) rotate([0,0,-90]) nut_holder(holder_height=holder_height, gradual_part_height=gradual_part_height, include_insert=true);
   translate([wall_width+8+7, length+wall_width, height-12]) rotate([0,0,180]) nut_holder(holder_height=holder_height, gradual_part_height=gradual_part_height, include_insert=true);
   translate([width+wall_width, wall_width, height-12]) rotate([0,0,90]) nut_holder(holder_height=holder_height, gradual_part_height=gradual_part_height, include_insert=true);
   translate([width+wall_width, length+wall_width-8, height-12]) rotate([0,0,90]) nut_holder(holder_height=holder_height, gradual_part_height=gradual_part_height, include_insert=true);
   
}

box_width = pi_width+control_board_width+6;
box_length = pi_length+1;
bottom_height = wall_width+pi_board_thickness+pin_mounts_height+15;
total_height = wall_width + control_board_bottom_offset - control_board_thickness + control_board_pins_height + wall_width+5;
top_height = total_height - bottom_height;
echo(top_height);

box_bottom(box_width, box_length, height=bottom_height, wall_width=wall_width);

translate([100,0,0]) box_top(box_width, box_length, height=top_height, wall_width=wall_width);

/*
difference() {
    union() {
        translate([box_width+2*wall_width,0,bottom_height+top_height]) rotate([0,180,0]) {
                box_top(box_width, box_length, height=top_height, wall_width=wall_width);
                
        }                
    }
    
       
}*/