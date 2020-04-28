/***
* Name: Building
* Author: shino
* Description: 
* Tags: Tag1, Tag2, TagN
***/

model Building

import "../GenericConstructionSpecies/Construction.gaml"
/* Insert your model definition here */

species Building parent: Construction {
	rgb color;
	int nbMaxAgentsLinked;
}
