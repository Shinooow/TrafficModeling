/***
* Name: TestCar
* Author: Maxence
* Description: A model dedicated to run unit tests
* Tags: Tag1, Tag2, TagN
***/

model TestCar

import "Car.gaml"

global {
	
	/* Destruction des agents apres un test pour re-faire une initialisation
	 * chaque test doit demarrer dans les memes conditions
	 */
	action destruction_agents_tests {
		Car c1 <- Car.population[0];
		Car c2 <- Car.population[1];
		ask c1 {
			do die;
		}
		ask c2 {
			do die;
		}
	}

	setup {
		/** Creation des agents pour un test */
		create Car {
			self.id <- 0;
			self.is_connected <- false;
			self.crashed <- false;
		}
		
		create Car {
			self.id <- 1;
			self.is_connected <- false;
			self.crashed <- false;
		}
	}
	
	/* Objectif: montrer la collision lorsque deux voitures se rencontrent
	 * sur une ligne droite
	 * Etat initial: deux agents voitures ayant deux directions qui se croisent
	 * en ligne droite
	 * Etat final: Agents voiture en collision (ou non en fonction du resultat du test)
	 * Resultat attendu: les deux agents en collision
	 */
	test "LigneDroiteCollisionTest" {
		Car c1 <- Car.population[0];
		Car c2 <- Car.population[1];
		c1.last_location <- {50.0, 50.0, 0.0};
		c1.location <- {100.0, 100.0, 0.0};
		c2.last_location <- {110.0, 110.0, 0.0};
		c2.location <- {80.0, 80.0, 0.0};
		ask c1 {
			do verification_collision;
		}
		ask c2 {
			do verification_collision;
		}
		assert(c1.crashed and c2.crashed);
		
		/* Destruction des agents pour passer a un autre test */
		do destruction_agents_tests;
	}
	
	/* Objectif: montrer la collision lorsque deux voitures se rencontrent
	 * sur un seul et même point
	 * Etat initial: deux agents voiture ayant comme point de position les meme
	 * Etat final: Agents voiture en collision (ou non en fonction du resultat 
	 * du test)
	 * Resultat attendu: les deux agents en collision
	 */
	test "PointCollisionTest" {
		Car c1 <- Car.population[0];
		Car c2 <- Car.population[1];
		c1.last_location <- {123.0, 321.0, 0.0};
		c1.location <- {100.0, 100.0, 0.0};
		c2.last_location <- {248.0, 200.0, 0.0};
		c2.location <- {100.0, 100.0, 0.0};
		ask c1 {
			do verification_collision;
		}
		ask c2 {
			do verification_collision;
		}
		assert (c1.crashed and c2.crashed);
		
		/* Destruction des agents pour passer a un autre test */
		do destruction_agents_tests;
	}
	
	/* Objectif: montrer la collision lorsque deux voitures se rencontrent
	 * pendant un virage
	 * Etat initial: deux agents voitures ayant des directions se rencontrant
	 * Etat final: Agents voiture en collision (ou non en fonction du resultat 
	 * du test)
	 * Resultat attendu: les deux agents en collision
	 */
	test "VirageCollisionTest" {
		Car c1 <- Car.population[0];
		Car c2 <- Car.population[1];
		c1.last_location <- {100.0, 100.0, 0.0};
		c1.location <- {112.0, 92.0, 0.0};
		c2.last_location <- {120.0, 100.0, 0.0};
		c2.location <- {108.0, 108.0, 0.0};
		ask c1 {
			do verification_collision;
		}
		ask c2 {
			do verification_collision;
		}
		assert(c1.crashed and c2.crashed);
		/* Destruction des agents pour passer a un autre test */
		do destruction_agents_tests;
	}
	
	/* Objectif: montrer que si les directions ne se croisent pas il
	 * n'y a pas de collision
	 * Etat initial: deux agent voiture ayant des directions ne se rencontrant pas
	 * Etat final: Agents voiture pas en collision (ou en collision en fonction du 
	 * resultat du test)
	 * Resultat attendu: les deux agents ne sont pas en collision
	 */
	test "SansCollisionTest" {
		Car c1 <- Car.population[0];
		Car c2 <- Car.population[1];
		c1.last_location <- {140.0, 140.0,0.0};
		c1.location <- {175.0, 175.0, 0.0};
		c2.last_location <- {409.5, 840.0, 0.0};
		c2.location <- {434.0, 840.0, 0.0};
		ask c1 {
			do verification_collision;
		}
		ask c2 {
			do verification_collision;
		}
		
		assert((not c1.crashed) and not (c2.crashed));
		/* Destruction des agents pour passer a un autre test */
		do destruction_agents_tests;
	}
	
}

experiment TestCar type: test autorun: true {

}
