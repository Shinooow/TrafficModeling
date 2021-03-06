/***
* Name: Checkpoint
* Author: Maxence
* Description: 
* Tags: Tag1, Tag2, TagN
***/

model Checkpoint

import "Main.gaml"

species Checkpoint {
	rgb color <- #green;
	int next_date_change_location <- world.current_date.hour + cycle_time_checkpoint;
	
	reflex move_every_2hr when: world.current_date.hour = next_date_change_location {
		location <- any_location_in(one_of(Road));
		next_date_change_location <- (world.current_date.hour +2) mod 24;
	}
	
	aspect base {
		draw circle(7.0 #m) color: color border: #black;
	}
}

