/***
* Name: Main
* Author: Maxence
* Description: 
* Tags: Tag1, Tag2, TagN
***/
model Main

import "./GenericConstructionSpecies/Road.gaml"
import "./GenericVehicleSpecies/Vehicle.gaml"
import "./VehicleSpecies/BluetoothCar.gaml"
import "./OtherSpecies/Checkpoint.gaml"
import "./VehicleSpecies/Bike.gaml"
import "./ConstructionSpecies/Home.gaml"

global {
	/* World paramaters */
	date starting_date <- date("2020-04-10-00-00-00");
	float step <- 5 #mn;
	
	/* Graphic parameters - shapesfiles */
	file roads_shapefile <- file("../includes/shapefiles/circuitv2.shp");
	file checkpoints_shapefile <- file("../includes/shapefiles/checkpointsv2.shp");
	geometry shape <- envelope(roads_shapefile);
	graph road_graph;
	
	/* LECTURE DES INFORMATIONS DE LA CAMERA */
	csv_file csv_test <- csv_file("../includes/file.csv");
	matrix csv_matrice <- matrix(csv_test);
	list<int> list_ligne <- list<int>(row_at(csv_matrice, 0)); 
	
	int nb_cars <- 1;
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
	
	list<Vehicle> vehicules;
	list<Construction> constructions;
	
	init {
		int id_vehicle_created <- 0;
		int id_construction_created <- 0;
		create Road from: roads_shapefile;
		create Checkpoint from: checkpoints_shapefile;
		road_graph <- as_edge_graph(Road.population);
		
		create Rule {
			 self.contenu <- "Je suis la regle 1";
		}
		
		loop road over: Road.population {
			ask road {
				add Rule.population[0] to: rules;
			}
		}
		
		create BluetoothCar number: nb_cars {
			self.location <- any_location_in(one_of(Road));
			self.id <- id_vehicle_created;
			do connectCar(self.id);
			self.is_connected <- true;
			id_vehicle_created <- id_vehicle_created +1;
			add self to: vehicules;
		}
		
		create Bike number: nb_cars {
			self.location <- any_location_in(one_of(Road));
			self.id <- id_vehicle_created;
			id_vehicle_created <- id_vehicle_created +1;
			add self to: vehicules;
		}
		
		create Home {
			self.location <- {200.0 , 200.0, 0.0};
			self.dimension_longueur <- 50.0;
			self.dimension_largeur <- 50.0;
			self.id <- id_construction_created;
			id_construction_created <- id_construction_created +1;
			add self to: constructions;
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
		csv_test <- csv_file("../includes/file.csv");
		csv_matrice <- matrix(csv_test);
		list_ligne <- list<int>(row_at(csv_matrice, 0)); 
		write list_ligne;
	}
	
	/** REFLEX STOP_SIMULATION
	 * Condition: quand plus de donnees sont presentes sur la position des voitures depuis la camera
	 * Deconnecte toute les voitures connectees en Bluetooth puis met en pause l'experimentation
	 */
	reflex stop_simulation when: nb_step = 100 {
		
		loop car over: vehicules{
			if(car is GuidableVehicle){
				GuidableVehicle guidableCar <- GuidableVehicle(car);
				ask guidableCar{
					if(is_connected){
						do disconnectCar(car.id);
					}
				}
			}
		}
		do pause;
	}
	
		
}
