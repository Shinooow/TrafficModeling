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
	/* World paramaters */
	date starting_date <- date("2020-04-10-00-00-00");
	float step <- 1 #mn;
	
	/* Graphic parameters - shapesfiles */
	file roads_shapefile <- file("../includes/shapefiles/circuitv2.shp");
	file checkpoints_shapefile <- file("../includes/shapefiles/checkpointsv2.shp");
	geometry shape <- envelope(roads_shapefile);
	graph road_graph;
	
	/* TESTS CSV LECTURE/ECRITURE 1 SEULE LIGNE */
	csv_file csv_test <- csv_file("../includes/file.csv");
	matrix csv_matrice <- matrix(csv_test);
	list<int> list_ligne <- list<int>(row_at(csv_matrice, 0)); 
	
	int nb_cars <- 20;
	int cycle_time_checkpoint <- 2;
	float car_speed <- 2 #km / #h;
	float min_car_speed <- 0.5 #km/#h;
	float max_car_speed <- 5.0 #km/#m;
	float seuil_vitesse_min <- 0.1;
	
	/* Permet le calcul du vecteur direction et de l'angle de l'orientation de l'icone voiture */
	point vecteur_base <- {0,-1,0};
	
	/* Permet l'affichage du graphique sur le nombre de voitures accidentees */
	int nb_crashed_cars <- 0;
	
	int nb_step <- 0;
	float mise_a_echelle <- 7.0;
	
	/* Lecture des donnees de la camera depuis un fichier csv */
 	csv_file camera_data <- csv_file("../includes/data_camera.csv");
 	matrix camera_data_matrice <- matrix(camera_data);
 	list<list<float>> rows_list <- list<list<float>>(rows_list(camera_data_matrice));
 	int data_size_init <- length(rows_list);
	
	init {
		int id_created <- 0;
		create Road from: roads_shapefile;
		create Checkpoint from: checkpoints_shapefile;
		road_graph <- as_edge_graph(Road.population);
		create Car number: nb_cars {
			self.location <- any_location_in(one_of(Road));
			self.id <- id_created;
			do connectCar(self.id);
			self.is_connected <- true;
			id_created <- id_created +1;
		}
	}
	
	/** REFLEX ONE_STEP
	 * Incremente la propriete nb_step permettant de savoir à un moment t a quelle etape
	 * nous nous trouvons
	 */
	reflex one_step {
		nb_step <- nb_step +1;
		/* Si on depasse les donnees presentes (TESTS SEULEMENT) alors 
		 * on charge la nouvelle ligne disponible
		 */
//		write list_ligne;
//		csv_test <- csv_file("../includes/file.csv");
//		csv_matrice <- matrix(csv_test);
//		list_ligne <- list<int>(row_at(csv_matrice, 0)); 
//		if(nb_step >= data_size_init){
//			write "nouveau chargement";
//			camera_data <- csv_file("../includes/data_camera.csv");
//			camera_data_matrice <- matrix(camera_data);
//			add list<float>(row_at(camera_data_matrice, nb_step)) to: rows_list;
//		}
	}
	
	/** REFLEX STOP_SIMULATION
	 * Condition: quand plus de donnees sont presentes sur la position des voitures depuis la camera
	 * Deconnecte toute les voitures connectees en Bluetooth puis met en pause l'experimentation
	 */
	reflex stop_simulation when: nb_step = data_size_init-1{
		
		loop car over: Car.population{
			ask car{
				if(not is_connected){
					do disconnectCar(car.id);
				}
			}
		}
		do pause;
	}
	
		
}
