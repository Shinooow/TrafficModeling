/***
* Name: TestCar
* Author: Maxence
* Description: A model dedicated to run unit tests
* Tags: Tag1, Tag2, TagN
***/

model TestCar

import "Car.gaml"

global {
	
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
	/** Alternatively or in addition, you can insert here tests definitions */

}
