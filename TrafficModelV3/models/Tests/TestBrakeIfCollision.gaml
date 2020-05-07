/***
* Name: TestBrakeIfCollision
* Author: Maxence
* Description: A model dedicated to run unit tests
* Tags: Tag1, Tag2, TagN
***/

model TestBrakeIfCollision

import "../GenericVehicleSpecies/NonGuidableVehicle.gaml"

global {
	action destroy_agents_after_test{
		NonGuidableVehicle vehicleA <- NonGuidableVehicle.population[0];
		NonGuidableVehicle vehicleB <- NonGuidableVehicle.population[1];
		ask vehicleA {
			remove self from: vehicules;
			do die;
		}
		ask vehicleB {
			remove self from: vehicules;
			do die;
		}
	}
	
	setup {
		create NonGuidableVehicle number: 2{
			add self to: vehicules;
		}
	}
	
	test "xDecroissantTest" {
		NonGuidableVehicle vehicleA <- NonGuidableVehicle.population[0];
		NonGuidableVehicle vehicleB <- NonGuidableVehicle.population[1];
		vehicleA.speed <- 50.0;
		vehicleB.speed <- 20.0;
		vehicleA.last_location <- {100.0, 100.0, 0.0};
		vehicleA.location <- {150.0, 150.0, 0.0};
		vehicleB.last_location <- {180.0, 180.0, 0.0};
		vehicleB.location <- {200.0, 200.0, 0.0};
		float last_speedA <- vehicleA.speed;
		float last_speedB <- vehicleB.speed;
		
		/* calculs des equations de droite */
		ask [vehicleA,vehicleB] {
			do calcul_eq_route;
		}
		
		ask vehicleA {
			do brake_if_collision_coming;
		}
		ask vehicleB {
			do brake_if_collision_coming;
		}

		assert(last_speedA>vehicleA.speed);
		assert(last_speedB=vehicleB.speed);
		
		do destroy_agents_after_test;
	}
	
	test "OppositeDecroissantBooleansTest" {
		NonGuidableVehicle vehicleA <- NonGuidableVehicle.population[0];
		NonGuidableVehicle vehicleB <- NonGuidableVehicle.population[1];
		vehicleA.speed <- 50.0;
		vehicleB.speed <- 20.0;
		vehicleA.last_location <- {100.0, 100.0, 0.0};
		vehicleA.location <- {150.0, 150.0, 0.0};
		vehicleB.last_location <- {220.0, 220.0, 0.0};
		vehicleB.location <- {180.0, 180.0, 0.0};
		float lastSpeedA <- vehicleA.speed;
		float lastSpeedB <- vehicleB.speed;
		
		/* calculs des equations de droite */
		ask [vehicleA, vehicleB]{
			do calcul_eq_route;
		}
		
		ask vehicleA {
			do brake_if_collision_coming;
		}
		ask vehicleB {
			do brake_if_collision_coming;
		}
		
		assert(lastSpeedA>vehicleA.speed);
		assert(lastSpeedB>vehicleB.speed);
		
		do destroy_agents_after_test;
	}
	
	test "TwoRoadsTest" {
		NonGuidableVehicle vehicleA <- NonGuidableVehicle.population[0];
		NonGuidableVehicle vehicleB <- NonGuidableVehicle.population[1];
		vehicleA.speed <- 50.0;
		vehicleB.speed <- 20.0;
		vehicleA.last_location <- {100.0, 100.0, 0.0};
		vehicleA.location <- {150.0, 150.0, 0.0};
		vehicleB.last_location <- {200.0, 150.0, 0.0};
		vehicleB.last_location <- {180.0, 150.0, 0.0};
		float lastSpeedA <- vehicleA.speed;
		float lastSpeedB <- vehicleB.speed;
		
		/* calculs des equations de droite */
		ask [vehicleA, vehicleB] {
			do calcul_eq_route;
		}
		
		ask vehicleA{
			do brake_if_collision_coming;
		}
		ask vehicleB{
			do brake_if_collision_coming;
		}
		
		assert(lastSpeedA=vehicleA.speed);
		assert(lastSpeedB=vehicleB.speed);
		
		do destroy_agents_after_test;
	}
	
	test "SameRoadAndSpeedTest" {
		NonGuidableVehicle vehicleA <- NonGuidableVehicle.population[0];
		NonGuidableVehicle vehicleB <- NonGuidableVehicle.population[1];
		vehicleA.speed <- 50.0;
		vehicleB.speed <- 50.0;
		vehicleA.last_location <- {100.0, 100.0, 0.0};
		vehicleA.location <- {150.0, 150.0, 0.0};
		vehicleB.last_location <- {180.0, 180.0, 0.0};
		vehicleB.location <- {230.0, 230.0, 0.0};
		float lastSpeedA <- vehicleA.speed;
		float lastSpeedB <- vehicleB.speed;
		
		/* calculs des equations de droite */
		ask [vehicleA, vehicleB] {
			do calcul_eq_route;
		}
		
		ask vehicleA {
			do brake_if_collision_coming;
		}
		ask vehicleB {
			do brake_if_collision_coming;
		}
		
		assert(lastSpeedA=vehicleA.speed);
		assert(lastSpeedB=vehicleB.speed);
		
		do destroy_agents_after_test;
	}
}

experiment TestBrakeIfCollision type: test autorun: true {
	
}
