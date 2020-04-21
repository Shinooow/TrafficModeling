package bluetooth_connection;

import java.util.Properties;

import org.python.util.PythonInterpreter;
import msi.gama.precompiler.GamlAnnotations.arg;
import msi.gama.precompiler.GamlAnnotations.doc;
import msi.gama.precompiler.GamlAnnotations.action;
import msi.gama.precompiler.GamlAnnotations.skill;
import msi.gama.runtime.IScope;
import msi.gama.runtime.exceptions.GamaRuntimeException;
import msi.gaml.skills.Skill;
import msi.gaml.types.IType;

@skill(name = "Bluetooth")
@doc(value = "The Bluetooth skill makes Gama able to connect itself to the vehicules via Bluetooth, "
		+ "this skill gives all the actions to move a car (move forward, move backward"
		+ "turn to the left ...)") 
public class BluetoothConnection extends Skill{
	private PythonInterpreter pInter;
	private Properties properties;
	
	public BluetoothConnection() {
		properties = new Properties();
		properties.setProperty("python.path", "jython-standalone-2.7.2.jar");
		properties.setProperty("python.home", "jython-standalone-2.7.2.jar");
		properties.setProperty("python.prefix", "jython-standalone-2.7.2.jar");
		PythonInterpreter.initialize(System.getProperties(), properties, new String[] {});
		pInter = new PythonInterpreter();
		pInter.exec("from v2_OK import *");
	}

	@action(name = "connectCar", args= {
		@arg(name = "numeroCar", type = IType.INT, optional = false)
	})
	@doc(value = "Action to connect a virtual car to a real vehicule, argument: id of the car(Gama object)",
		returns = "Returns 0 if everything went well"
	)
	public Integer connectCar(final IScope scope) throws GamaRuntimeException {
		int numeroCar = (int)scope.getArg("numeroCar", IType.INT);
		pInter.exec("connectNewDevice(None," + numeroCar + ")");
		return 0;
	}
	
	@action(name = "disconnectCar", args= {
		@arg(name = "numeroCar", type = IType.INT, optional = false)
	})
	@doc(value = "Action to disconnect a virtual car to a real vehicule, argument: id of the car(Gama object)",
		returns = "Returns 0 if everything went well"
	)
	public Integer disconnectCar(final IScope scope) throws GamaRuntimeException {
		int numeroCar = (int)scope.getArg("numeroCar", IType.INT);
		pInter.exec("disconnectDevice(" + numeroCar + ")");
		return 0;
	}
	
	@action(name = "moveForward", args= {
		@arg(name = "numeroCar", type = IType.INT, optional = false)
	})
	@doc(value = "Action to move forward a car, argument: id of the car(Gama object)",
		returns = "Returns 0 if everything went well"
	)
	public Integer moveForward(final IScope scope) throws GamaRuntimeException {
		int numeroCar = (int)scope.getArg("numeroCar",  IType.INT);
		pInter.exec("move_forward(" + numeroCar + ")");
		return 0;
	}
	
	@action(name = "moveBackward", args= {
		@arg(name = "numeroCar", type = IType.INT, optional = false)
	})
	@doc(value = "Action to move backward a car, argument: id of the car (Gama object)",
		returns = "Returns 0 if everything went well"
	)
	public Integer moveBackward(final IScope scope) throws GamaRuntimeException {
		int numeroCar = (int)scope.getArg("numeroCar", IType.INT);
		pInter.exec("move_backward(" + numeroCar + ")");
		return 0;
	}
	
	@action(name = "forwardToLeft", args= {
		@arg(name = "numeroCar", type = IType.INT, optional = false)
	})
	@doc(value = "Action to move forward left a car, argument: id of the car (Gama object)",
		returns = "Returns 0 if everything went well"
	)
	public Integer forwardToLeft(final IScope scope) throws GamaRuntimeException {
		int numeroCar = (int)scope.getArg("numeroCar", IType.INT);
		pInter.exec("forward_to_left(" + numeroCar + ")");
		return 0;
	}
	
	@action(name = "forwardToRight", args= {
		@arg(name = "numeroCar", type = IType.INT, optional = false)
	})
	@doc(value = "Action to move forward right a car, argument: id of the car (Gama object)",
		returns = "Returns 0 if everything went well"
	)
	public Integer forwardToRight(final IScope scope) throws GamaRuntimeException {
		int numeroCar = (int)scope.getArg("numeroCar", IType.INT);
		pInter.exec("forward_to_right(" + numeroCar + ")");
		return 0;
	}
	
	@action(name = "backwardToLeft", args= {
		@arg(name = "numeroCar", type = IType.INT, optional = false)
	})
	@doc(value = "Action to move backward left a car, argument: id of the car (Gama object)",
		returns = "Returns 0 if everything went well"
	)
	public Integer backwardToLeft(final IScope scope) throws GamaRuntimeException {
		int numeroCar = (int)scope.getArg("numeroCar", IType.INT);
		pInter.exec("backward_to_left(" + numeroCar + ")");
		return 0;
	}
	
	@action(name = "backwardToRight", args= {
		@arg(name = "numeroCar", type = IType.INT, optional = false)
	})
	@doc(value = "Action to move backward right a car, argument: id of the car (Gama object)",
		returns = "Returns 0 if everything went well"
	)
	public Integer backwardToRight(final IScope scope) throws GamaRuntimeException {
		int numeroCar = (int)scope.getArg("numeroCar", IType.INT);
		pInter.exec("backward_to_right(" + numeroCar + ")");
		return 0;
	}
	
	@action(name = "resetWheels", args= {
		@arg(name = "numeroCar", type = IType.INT, optional = false)
	})
	@doc(value = "Action to put the wheels in the axis of a car, argument: id of the car (Gama object)",
		returns = "Returns 0 if everything went well"
	)
	public Integer resetWheels(final IScope scope) throws GamaRuntimeException {
		int numeroCar = (int)scope.getArg("numeroCar", IType.INT);
		pInter.exec("reset_wheels(" + numeroCar + ")");
		return 0;
	}
	
	@action(name = "stopBeforeBackward", args= {
		@arg(name = "numeroCar", type = IType.INT, optional = false)
	})
	@doc(value = "Action to stop a car before moving backward, argument: id of the car (Gama object)",
		returns = "Returns 0 if everything went well"
	)
	public Integer stopBeforeBackward(final IScope scope) throws GamaRuntimeException {
		int numeroCar = (int)scope.getArg("numeroCar", IType.INT);
		pInter.exec("stop_before_backward(" + numeroCar + ")");
		return 0;
	}
	
	@action(name = "stopBeforeForward", args= {
		@arg(name = "numeroCar", type = IType.INT, optional = false)
	})
	@doc(value = "Action to stop a car before moving forward, argument: id of the car (Gama object)",
		returns = "Returns 0 if everything went well"
	)
	public Integer stopBeforeForward(final IScope scope) throws GamaRuntimeException {
		int numeroCar = (int)scope.getArg("numeroCar", IType.INT);
		pInter.exec("stop_before_forward(" + numeroCar + ")");
		return 0;
	}
	
	@action(name = "rightHalfTurn", args= {
		@arg(name = "numeroCar", type = IType.INT, optional = false)
	})
	@doc(value = "Action to do a right half turn of a car, argument: id of the car (Gama object)",
		returns = "Returns 0 if everything went well"
	)
	public Integer rightHalfTurn(IScope scope) throws GamaRuntimeException {
		int numeroCar = (int)scope.getArg("numeroCar", IType.INT);
		pInter.exec("m1(" + numeroCar + ")");
		return 0;
	}
	
	@action(name = "leftHalfTurn", args= {
		@arg(name = "numeroCar", type = IType.INT, optional = false)
	})
	@doc(value = "Action to do a left half turn of a car, argument: id of the car (Gama object)",
		returns = "Returns 0 if everything went well"
	)
	public Integer leftHalfTurn(IScope scope) throws GamaRuntimeException {
		int numeroCar = (int)scope.getArg("numeroCar", IType.INT);
		pInter.exec("m2("+ numeroCar + ")");
		return 0;
	}
	
	@action(name = "clockwiseCircle", args= {
		@arg(name = "numeroCar", type = IType.INT, optional = false)
	})
	@doc(value = "Action to do a clockwise circle of a car, argument: id of the car (Gama object)",
		returns = "Returns 0 if everything went well"
	)
	public Integer clockwiseCircle(IScope scope) throws GamaRuntimeException{
		int numeroCar = (int)scope.getArg("numeroCar", IType.INT);
		pInter.exec("m3(" + numeroCar + ")");
		return 0;
	}
	
	@action(name = "antiClockwiseCircle", args= {
		@arg(name = "numeroCar", type = IType.INT, optional = false)
	})
	@doc(value = "Action to do an anti-clockwise circle of a car, argument: id of the car (Gama object)",
		returns = "Returns 0 if everything went well"
	)
	public Integer antiClockwiseCircle(IScope scope) throws GamaRuntimeException{
		int numeroCar = (int)scope.getArg("numeroCar", IType.INT);
		pInter.exec("m4(" + numeroCar + ")");
		return 0;
	}
	
	@action(name = "slalomMove", args= {
		@arg(name = "numeroCar", type = IType.INT, optional = false)
	})
	@doc(value = "Action to do a slalom move of a car, argument: id of the car(Gama object)",
		returns = "Returns 0 if everything went well"
	)
	public Integer slalomMove(IScope scope) throws GamaRuntimeException{
		int numeroCar = (int)scope.getArg("numeroCar", IType.INT);
		pInter.exec("m8(" + numeroCar + ")");
		return 0;
	}
}
