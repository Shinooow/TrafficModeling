/***
* Name: Road
* Author: Maxence
* Description: 
* Tags: Tag1, Tag2, TagN
***/

model Road

import "Construction.gaml"
import "../OtherSpecies/Rule.gaml"

species Road parent: Construction {
	rgb color <- #black;
	int nombreVoies;
	float vitesseMax;
	list<Rule> rules;
		
	
	aspect base {
		draw shape color: color;
	}
}

