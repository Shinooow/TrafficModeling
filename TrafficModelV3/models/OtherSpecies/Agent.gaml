/***
* Name: Agent
* Author: Maxence
* Description: 
* Tags: Tag1, Tag2, TagN
***/

model Agent

import "../ConstructionSpecies/Home.gaml"
import "../ConstructionSpecies/Administration.gaml"

species Agent skills: [moving]{
	Home home;
	Administration administration;
}

/* Insert your model definition here */

