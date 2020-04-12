/***
* Name: Road
* Author: Maxence
* Description: 
* Tags: Tag1, Tag2, TagN
***/

model Road

/* Insert your model definition here */

species Road {
	rgb color <- #black;
	
	aspect base {
		draw shape color: color width: 4;
	}
}