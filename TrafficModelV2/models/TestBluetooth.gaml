/***
* Name: TestBluetooth
* Author: Maxence
* Description: A model dedicated to run unit tests
* Tags: Tag1, Tag2, TagN
***/

model TestBluetooth

import "Car.gaml"

global {
	/** Insert the global definitions, variables and actions here */
	action destruction_agents_tests {
		Car car <- Car.population[0];
		ask car {
			do die;
		}
	}
	
	setup {
		create Car {
			self.id <- 0;
			self.is_connected <- false;
		}
	}
	
	test "CoDecoTest" {
		Car car <- Car.population[0];
		int connect <- -1;
		int disconnect <- -1;
		ask car {
			connect <- connectCar(0);
			disconnect <- disconnectCar(0);
		}
		assert (connect = 0 and disconnect = 0 and (not car.is_connected));
		do destruction_agents_tests;
	}
	
	test "MoveForwardTest" {
		Car car <- Car.population[0];
		int resultat_retourne <- -1;
		ask car {
			do connectCar(0);
			resultat_retourne <- moveForward(0);
			do disconnectCar(0);
		}
		assert (resultat_retourne = 0);
		do destruction_agents_tests;
	}
	
	test "MoveBackwardTest" {
		Car car <- Car.population[0];
		int resultat_retourne <- -1;
		ask car {
			do connectCar(0);
			resultat_retourne <- moveBackward(0);
			do disconnectCar(0);
		}
		assert (resultat_retourne = 0);
		do destruction_agents_tests;
	}
	
	test "ForwardToLeft" {
		Car car <- Car.population[0];
		int resultat_retourne <- -1;
		ask car {
			do connectCar(0);
			resultat_retourne <- forwardToLeft(0);
			do disconnectCar(0);
		}
		assert (resultat_retourne = 0);
		do destruction_agents_tests;
	}
	
	test "forwardToRight" {
		Car car <- Car.population[0];
		int resultat_retourne <- -1;
		ask car {
			do connectCar(0);
			resultat_retourne <- forwardToRight(0);
			do disconnectCar(0);
		}
		assert (resultat_retourne = 0);
		do destruction_agents_tests;
	}
	
	test "backwardToLeft" {
		Car car <- Car.population[0];
		int resultat_retourne <- -1;
		ask car {
			do connectCar(0);
			resultat_retourne <- backwardToLeft(0);
			do disconnectCar(0);
		}
		assert (resultat_retourne = 0);
		do destruction_agents_tests;
	}
	
	test "backwardToRight" {
		Car car <- Car.population[0];
		int resultat_retourne <- -1;
		ask car {
			do connectCar(0);
			resultat_retourne <- backwardToRight(0);
			do disconnectCar(0);
		}
		assert (resultat_retourne = 0);
		do destruction_agents_tests;
	}
	
	test "resetWheelsTest" {
		Car car <- Car.population[0];
		int resultat_retourne <- -1;
		ask car {
			do connectCar(0);
			resultat_retourne <- resetWheels(0);
			do disconnectCar(0);
		}
		assert (resultat_retourne = 0);
		do destruction_agents_tests;
	}
	
	test "stopBeforeForwardTest" {
		Car car <- Car.population[0];
		int resultat_retourne <- -1;
		ask car {
			do connectCar(0);
			resultat_retourne <- stopBeforeForward(0);
			do disconnectCar(0);
		}
		assert (resultat_retourne = 0);
		do destruction_agents_tests;
	}
	
	test "stopBeforeBackward" {
		Car car <- Car.population[0];
		int resultat_retourne <- -1;
		ask car {
			do connectCar(0);
			resultat_retourne <- stopBeforeBackward(0);
			do disconnectCar(0);
		}
		assert (resultat_retourne = 0);
		do destruction_agents_tests;
	}
	
	test "LeftHalfTurnTest" {
		Car car <- Car.population[0];
		int resultat_retourne <- -1;
		ask car {
			do connectCar(0);
			resultat_retourne <- leftHalfTurn(0);
			do disconnectCar(0);
		}
		assert (resultat_retourne = 0);
		do destruction_agents_tests;
	}
	
	test "RightHalfTurnTest" {
		Car car <- Car.population[0];
		int resultat_retourne <- -1;
		ask car {
			do connectCar(0);
			resultat_retourne <- rightHalfTurn(0);
			do disconnectCar(0);
		}
		assert (resultat_retourne = 0);
		do destruction_agents_tests;
	}
	
	
	test "ClockwiseCircleTest" {
		Car car <- Car.population[0];
		int resultat_retourne <- -1;
		ask car {
			do connectCar(0);
			resultat_retourne <- clockwiseCircle(0);
			do disconnectCar(0);
		}
		assert (resultat_retourne = 0);
		do destruction_agents_tests;
	}
	
	test "AntiClockwiseCircleTest" {
		Car car <- Car.population[0];
		int resultat_retourne <- -1;
		ask car {
			do connectCar(0);
			resultat_retourne <- antiClockwiseCircle(0);
			do disconnectCar(0);
		}
		assert (resultat_retourne = 0);
		do destruction_agents_tests;
	}
	
	test "SlalomTest" {
		Car car <- Car.population[0];
		int resultat_retourne <- -1;
		ask car {
			do connectCar(0);
			resultat_retourne <- slalomMove(0);
			do disconnectCar(0);
		}
		assert (resultat_retourne = 0);
		do destruction_agents_tests;
	}
	
}

experiment TestBluetooth type: test autorun: true {
	/** Alternatively or in addition, you can insert here tests definitions */

}
