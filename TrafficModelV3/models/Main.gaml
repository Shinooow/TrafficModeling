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
import "./VehicleSpecies/Bus.gaml"
import "./ConstructionSpecies/Administration.gaml"
import "./OtherSpecies/Agent.gaml"
import "./OtherSpecies/Signalisation.gaml"
import "./VehicleSpecies/Train.gaml"


global {
	/* World paramaters */
	date starting_date <- date("2020-04-10-00-00-00");
	float step <- 5 #mn;
	
	/* Graphic parameters - shapesfiles */
	file roads_shapefile <- file("../includes/shapefiles/circuitv2.shp");
	file checkpoints_shapefile <- file("../includes/shapefiles/checkpointsv2.shp");
	geometry shape <- envelope(roads_shapefile);
	graph roadGraph;
	
	/* LECTURE DES INFORMATIONS DE LA CAMERA */
	csv_file csv_camera <- csv_file("../includes/data_camera.csv");
	matrix csv_matrice <- matrix(csv_camera);
	list<int> list_ligne <- list<int>(row_at(csv_matrice, 0)); 
	
	int nb_cars <- 1;
	int cycle_time_checkpoint <- 2;
	float car_speed <- 2 #km / #h;
	float min_car_speed <- 0.5 #km/#h;
	float max_car_speed <- 2.0 #km/#m;
	float seuil_vitesse_min <- 0.1;
	
	/* Permet le calcul du vecteur direction et de l'angle de l'orientation de l'icone voiture */
	point vecteur_base <- {0,-1,0};
	
	/* Permet l'affichage du graphique sur le nombre de voitures accidentees */
	int nb_crashed_cars <- 0;
	
	int nb_step <- 0;
	float mise_a_echelle <- 7.0;
	
	list<Vehicle> vehicules;
	list<Construction> constructions;
	
	int idGuidableVehicleCreated <- 0;
	int idNonGuidableVehicleCreated <- 0;
	int idConstructionCreated <- 0;
	int idAgentCreated <- 0;
	int idRuleCreated <- 0;
	int idSignalisationCreated <- 0;
	
	action consBluetoothCar {
		create BluetoothCar {
			self.id <- idGuidableVehicleCreated;
			self.location <- {list_ligne[3*self.id], list_ligne[3*self.id+1], 0.0};
			self.angle_rotation <- float(list_ligne[3*self.id+2]);
			idGuidableVehicleCreated <- idGuidableVehicleCreated+1;
			do connectCar(self.id);
			add self to: vehicules;
		}
	}
	
	action consBike (float vitesse){
		create Bike {
			self.id <- idNonGuidableVehicleCreated;
			self.location <- any_location_in(one_of(Road.population));
			self.speed <- vitesse;
			idNonGuidableVehicleCreated <- idNonGuidableVehicleCreated+1;
			add self to: vehicules;
		}
	}
	
	action consRoads (string shapefilePath){
		file roadsShapefile <- file(shapefilePath);
		create Road from: roadsShapefile;
		roadGraph <- as_edge_graph(Road.population);
	}
	
	action consRule (string content){
		create Rule {
			self.id <- idRuleCreated;
			self.contenu <- content;
			idRuleCreated <- idRuleCreated+1; 
		}
	}
	
	action consHome (point position, float dimensionLongueur, float dimensionLargeur){
		create Home {
			self.location <- position;
			self.dimension_longueur <- dimensionLongueur;
			self.dimension_largeur  <- dimensionLargeur;
			self.id <- idConstructionCreated;
			idConstructionCreated <- idConstructionCreated+1; 
			add self to: constructions;
		}
	}
	
	action consAdministration (point position, float dimensionLongueur, float dimensionLargeur){
		create Administration {
			self.location <- position;
			self.dimension_longueur <- dimensionLongueur;
			self.dimension_largeur <- dimensionLargeur;
			self.id <- idConstructionCreated;
			idConstructionCreated <- idConstructionCreated+1;
			add self to: constructions;
		}
	}
	
	action consBus (float vitesse){
		create Bus {
			self.id <- idNonGuidableVehicleCreated;
			self.location <- any_location_in(one_of(Road.population));
			self.speed <- vitesse;
			idNonGuidableVehicleCreated <- idNonGuidableVehicleCreated+1;
			add self to: vehicules;
		}
	}
	
	action consCheckpoints (string shapefilePath){
		file checkpointsShapefile <- file(shapefilePath);
		create Checkpoint from: checkpointsShapefile;
	}
	
	action consCheckpoint (point position, Construction construction){
		create Checkpoint {
			self.location <- position;
			self.construction <- construction;
		}
	}
	
	action consAgent (point position, Administration administration, Home home){
		create Agent {
			self.location <- position;
			self.administration <- administration;
			self.home <- home;
			self.id <- idAgentCreated;
			idAgentCreated <- idAgentCreated+1;
		}
	}
	
	action consSignalisation (point position){
		create Signalisation {
			self.id <- idSignalisationCreated;
			self.location <- position;
			idSignalisationCreated <- idSignalisationCreated+1;
		}
	}
	
	action consTrain (point position, Railway railway){
		create Train {
			self.id <- idNonGuidableVehicleCreated;
			self.location <- position;
			self.voie <- railway;
			idNonGuidableVehicleCreated <- idNonGuidableVehicleCreated+1;
		}
	}
	
	action consRailway (point position, float dimensionLongueur, float dimensionLargeur) {
		create Railway {
			self.id <- idConstructionCreated;
			self.location <- position;
			self.dimension_longueur <- dimensionLongueur;
			self.dimension_largeur <- dimensionLargeur;
		}
	}
	
	init {
		
		create Road from: roads_shapefile;
		create Checkpoint from: checkpoints_shapefile;
		roadGraph <- as_edge_graph(Road.population);
		
		create Rule {
			 self.contenu <- "Je suis la regle 1";
		}
		
		loop road over: Road.population {
			ask road {
				add Rule.population[0] to: rules;
			}
		}
		
		loop times: 20 {
			do consBus(0.5);
		}
		
		loop times: 10 {
			do consBike(0.2);
		}
		
	}
	
	/** REFLEX ONE_STEP
	 * Incremente la propriete nb_step permettant de savoir à un moment t a quelle etape
	 * nous nous trouvons
	 */
	reflex one_step {
		
		nb_step <- nb_step +1;
		csv_camera <- csv_file("../includes/data_camera.csv");
		csv_matrice <- matrix(csv_camera);
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
