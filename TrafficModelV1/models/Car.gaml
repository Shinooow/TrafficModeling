/***
* Name: Car
* Author: Maxence
* Description: 
* Tags: Tag1, Tag2, TagN
***/

model Car

import "Main.gaml"
import "Road.gaml"

species Car skills: [advanced_driving] {
	rgb color <- #red;
	file car_icon <- file("../includes/red-car.png");
	
	float speed <- rnd(min_car_speed, max_car_speed);
	point target;
	bool is_arrived <- true;
	
	reflex setup_target when: is_arrived{
		target <- (one_of(Checkpoint.population)).location;
		is_arrived <- false;
	}
	
	reflex it_is_arrived when: location = target.location{
		is_arrived <- true;
	}
	
	reflex move when: target != nil {
		do goto target: target on: world.road_graph;
		loop tmp_car over: Car.population {
			if(tmp_car != self){
				if(tmp_car.location = self.location){
					write "Car crash";
					ask tmp_car {
						do die;
					}
					do die;
				}
			}
		}
	}
	
	
	aspect base {
		draw circle(10.0 #m) color: color border: #black;
	}
	
	aspect with_icon {
		draw car_icon size: 70;
	}
	
}