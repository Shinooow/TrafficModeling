/***
* Name: Road
* Author: Maxence
* Description: 
* Tags: Tag1, Tag2, TagN
***/

model Road

import "Construction.gaml"
/* Insert your model definition here */

species Road parent: Construction {
	rgb color <- #black;
	int nombreVoies;
	float vitesseMax;
	
	aspect base {
		draw shape color: color width: 4;
	}
}

