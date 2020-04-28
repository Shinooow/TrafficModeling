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
}
