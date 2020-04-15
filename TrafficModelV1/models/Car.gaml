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
	float max_speed <- speed;
	point target;
	bool is_arrived <- true;
	float angle_rotation <- 0.0;
	
	point last_location;
	point vecteur_direction;
	
	bool must_stay_on_road <- true;
	
	bool can_speed_up <- false;
	bool must_brake <- false;
	float coeff_deceleration <- 0.75;
	float coeff_acceleration <- 0.20;
	
	/* COLLISIONS DES VOITURES */
	/* Equations de la droite de la route sous forme: a * x + b */
	float a;
	float b;
	
	action calcul_eq_route {
		float n <- location.x-last_location.x;
		if(n != 0){
			a <- (location.y-last_location.y)/n;
			b <- last_location.y - a*last_location.x;
			a <- a with_precision 3;
			b <- b with_precision 3;
		}
	}
	
	action freinage {
		speed <- speed * coeff_deceleration;
		coeff_deceleration <- coeff_deceleration - 0.1;
	}
	
	action acceleration {
		float nouvelle_vitesse <- speed + speed * coeff_acceleration;
		if(nouvelle_vitesse > max_speed){
			speed <- max_speed;
			can_speed_up <- false;
		} else {
			speed <- nouvelle_vitesse;
		}
	}
	
	action calcul_angle_rotation {
		vecteur_direction <- {location.x-last_location.x, location.y-last_location.y, 0};
		float n <- sqrt((vecteur_direction.x*vecteur_direction.x + vecteur_direction.y*vecteur_direction.y));
		if(n != 0){
			angle_rotation <- (vecteur_base.x*vecteur_direction.x + vecteur_base.y*vecteur_direction.y);
			angle_rotation <- acos(angle_rotation/n);
			if(location.x < last_location.x){
				angle_rotation <- 360.0- angle_rotation;
			}
		}
	}
	
	reflex setup_target when: is_arrived{
		target <- (one_of(Checkpoint.population)).location;
		is_arrived <- false;
	}
	
	reflex it_is_arrived when: location = target.location{
		is_arrived <- true;
	}
	
	reflex move when: target != nil {
		last_location <- location;
		
		/* Variations de vitesse */
		if(must_brake){
			do freinage;
		} else if(can_speed_up){
			do acceleration;
		}
		
		/* Deplacements sur la route (ou non) */
		if(must_stay_on_road){
			do goto target: target on: world.road_graph;
		} else {
			do goto target: target;
		}
		
		/* Vérification de collision */
		do calcul_eq_route;
		loop other_car over: Car.population{
			if(self != other_car){
				/* Si présents sur la même route */
				if(self.a = other_car.a and self.b = other_car.b){
				 	/* on regarde si other_car est passé sur la route de self */
				 	float tmin <- min(self.last_location.x, self.location.x);
				 	float tmax <- max(self.last_location.x, self.location.x);
				 	if((other_car.location.x >= tmin and other_car.location.x <= tmax) 
				 		or (other_car.last_location.x >= tmin and other_car.last_location.x <= tmax))
				 	{
				 		write "car crash";
				 		ask other_car {
				 			do die;
				 		}
				 		do die;
				 	}
				}
			}
		}
		
		/* Calcul de l'angle de la rotation de l'icone voiture */
		do calcul_angle_rotation;
		
	}
	
	
	aspect base {
		draw circle(10.0 #m) color: color border: #black;
	}
	
	aspect with_icon {
		draw car_icon size: 50 rotate: angle_rotation;
		draw string(speed with_precision 3) size: 20 color: #black lighted: true width: 5;
	}
	
}