/***
* Name: Main
* Author: Maxence
* Description: 
* Tags: Tag1, Tag2, TagN
***/
model Main

import "Road.gaml"
import "Car.gaml"
import "Checkpoint.gaml"

global {
	date starting_date <- date("2020-04-10-00-00-00");
	float step <- 1 #mn;
	
	file roads_shapefile <- file("../includes/circuitv2.shp");
	file checkpoints_shapefile <- file("../includes/checkpointsv2.shp");
	geometry shape <- envelope(roads_shapefile);
	graph road_graph;
	
	int nb_cars <- 20;
	int cycle_time_checkpoint <- 2;
	float car_speed <- 2 #km / #h;
	float min_car_speed <- 0.5 #km/#h;
	float max_car_speed <- 5.0 #km/#m;
	
	/* DEBUT: TEST LECTURE FICHIER CSV */
	//csv_file fcsv <- csv_file("../includes/file.csv");
  	//matrix ma <- matrix(fcsv);
 	//list<int> lpremierligne <- list<int>(row_at(ma, 0));
 	//int nb <- lpremierligne[0];
 	/* FIN: TEST LECTURE FICHIER CSV */
	
	init {
		create Road from: roads_shapefile;
		create Checkpoint from: checkpoints_shapefile;
		road_graph <- as_edge_graph(Road.population);
		create Car number: nb_cars {
			self.location <- any_location_in(one_of(Road));
		}
		
	}
	
	/* DEBUT: TEST ECRITURE FICHIER CSV */
	//reflex save_and_write {
		//save Car.population to: "output.csv" type: csv rewrite: false;
	//}
	/* FIN: TEST ECRITURE FICHIER CSV */
		
}
