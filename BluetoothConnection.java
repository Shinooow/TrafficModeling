package bluetooth_connection;

import java.util.Properties;

import org.python.util.PythonInterpreter;

import msi.gama.precompiler.GamlAnnotations.action;
import msi.gama.precompiler.GamlAnnotations.skill;
import msi.gama.runtime.IScope;
import msi.gama.runtime.exceptions.GamaRuntimeException;
import msi.gaml.skills.Skill;

@skill(name = "Bluetooth")
public class BluetoothConnection extends Skill{

	@action(name = "connectCar")
	public Integer connectCar(final IScope scope) throws GamaRuntimeException {
		Properties properties = new Properties();
		properties.setProperty("python.path", "jython-standalone-2.7.2.jar");
		properties.setProperty("python.home", "jython-standalone-2.7.2.jar");
		properties.setProperty("python.prefix", "jython-standalone-2.7.2.jar");
		PythonInterpreter.initialize(System.getProperties(), properties, new String[] {});
		try(PythonInterpreter pInter = new PythonInterpreter()){
			pInter.exec("print('aaaa')");
			System.out.println("Done");
		};
		return 0;
	}
}
