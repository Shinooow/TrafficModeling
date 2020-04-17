package bluetooth_connection;

import java.util.Properties;

import org.python.util.PythonInterpreter;
import msi.gama.precompiler.GamlAnnotations.arg;
import msi.gama.precompiler.GamlAnnotations.action;
import msi.gama.precompiler.GamlAnnotations.skill;
import msi.gama.runtime.IScope;
import msi.gama.runtime.exceptions.GamaRuntimeException;
import msi.gaml.skills.Skill;
import msi.gaml.types.IType;

@skill(name = "Bluetooth")
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
	public Integer connectCar(final IScope scope) throws GamaRuntimeException {
		int numeroCar = (int)scope.getArg("numeroCar", IType.INT);
		pInter.exec("connectNewDevice(None," + numeroCar + ")");
		return 0;
	}
	
	@action(name = "disconnectCar", args= {
		@arg(name = "numeroCar", type = IType.INT, optional = false)
	})
	public Integer disconnectCar(final IScope scope) throws GamaRuntimeException {
		int numeroCar = (int)scope.getArg("numeroCar", IType.INT);
		pInter.exec("disconnectDevice(" + numeroCar + ")");
		return 0;
	}
	
	@action(name = "moveForward", args= {
		@arg(name = "numeroCar", type = IType.INT, optional = false)
	})
	public Integer moveForward(final IScope scope) throws GamaRuntimeException {
		int numeroCar = (int)scope.getArg("numeroCar",  IType.INT);
		pInter.exec("move_forward(" + numeroCar + ")");
		return 0;
	}
	
	@action(name = "moveBackward", args= {
		@arg(name = "numeroCar", type = IType.INT, optional = false)
	})
	public Integer moveBackward(final IScope scope) throws GamaRuntimeException {
		int numeroCar = (int)scope.getArg("numeroCar", IType.INT);
		pInter.exec("move_backward(" + numeroCar + ")");
		return 0;
	}
	
	@action(name = "forwardToLeft", args= {
		@arg(name = "numeroCar", type = IType.INT, optional = false)
	})
	public Integer forwardToLeft(final IScope scope) throws GamaRuntimeException {
		int numeroCar = (int)scope.getArg("numeroCar", IType.INT);
		pInter.exec("forward_to_left(" + numeroCar + ")");
		return 0;
	}
	
	@action(name = "forwardToRight", args= {
		@arg(name = "numeroCar", type = IType.INT, optional = false)
	})
	public Integer forwardToRight(final IScope scope) throws GamaRuntimeException {
		int numeroCar = (int)scope.getArg("numeroCar", IType.INT);
		pInter.exec("forward_to_right(" + numeroCar + ")");
		return 0;
	}
	
	@action(name = "backwardToLeft", args= {
		@arg(name = "numeroCar", type = IType.INT, optional = false)
	})
	public Integer backwardToLeft(final IScope scope) throws GamaRuntimeException {
		int numeroCar = (int)scope.getArg("numeroCar", IType.INT);
		pInter.exec("backward_to_left(" + numeroCar + ")");
		return 0;
	}
	
	@action(name = "backwardToRight", args= {
		@arg(name = "numeroCar", type = IType.INT, optional = false)
	})
	public Integer backwardToRight(final IScope scope) throws GamaRuntimeException {
		int numeroCar = (int)scope.getArg("numeroCar", IType.INT);
		pInter.exec("backward_to_right(" + numeroCar + ")");
		return 0;
	}
}
