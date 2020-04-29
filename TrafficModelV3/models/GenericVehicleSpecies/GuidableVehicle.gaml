/***
* Name: GuidableVehicle
* Author: Maxence
* Description: 
* Tags: Tag1, Tag2, TagN
***/

model GuidableVehicle

import "Vehicle.gaml"

/* Insert your model definition here */
species GuidableVehicle parent: Vehicle skills: [Bluetooth]{
	bool is_connected <- false;
	
	/** OVERRIDE FROM VEHICLE */
	reflex mise_a_jour when: target != nil and not crashed{
		last_location <- location;
		if(must_brake){
			do freinage;
		} else if(can_speed_up){
			do acceleration;
		}
		
		point new_location <- {list_ligne[3*id]*mise_a_echelle, list_ligne[3*id+1]*mise_a_echelle, 0.0};
		location <- new_location;
		angle_rotation <- float(list_ligne[3*id+2]);
		
		do verification_collision;
	}
}
