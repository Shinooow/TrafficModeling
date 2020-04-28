/***
* Name: Construction
* Author: Maxence
* Description: 
* Tags: Tag1, Tag2, TagN
***/

model Construction

/* Insert your model definition here */
species Construction {
	/* shape et location sont deja crees par Gama dans la classe agent */
	geometry shape;
	float dimension_longueur;
	float dimenseion_largeur;
	bool traversable;
	point location;
	int id;
}
