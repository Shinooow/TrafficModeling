/***
* Name: Bike
* Author: Bike
* Description: 
* Tags: Tag1, Tag2, TagN
***/

model Bike

import "../GenericVehicleSpecies/NonGuidableVehicle.gaml"

/* Insert your model definition here */
species Bike parent: NonGuidableVehicle {
	file car_icon <- file("../../includes/images/bicycle.png");
	float icon_size <- 50.0;
	int crash_importance <- 1;
	/** OVERRIDE FROM VEHICLE */
}
