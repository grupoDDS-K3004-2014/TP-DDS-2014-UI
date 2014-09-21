package applicationModel

import org.uqbar.commons.model.Entity
import org.uqbar.commons.utils.Observable
import java.util.ArrayList
import domain.Partido
import domain.Dia

@Observable
class OTFApplicationModel extends Entity {

	@Property ArrayList<Partido> partidos = new ArrayList
	@Property Partido partidoSeleccionado

	new(){
	 this.init()
	}

	def void init() {
		
		var partidoNuevo = new Partido	
		var partidoNuevo2 = new Partido		
		var partidoNuevo3 = new Partido	
		
		partidos.add(partidoNuevo.setValores(1,Dia.Lunes,1830,10122014,"El superClasico de Martelli"))
		partidos.add(partidoNuevo2.setValores(1,Dia.Viernes,2215,11102014,"Don Torcuato Copa"))
		partidos.add(partidoNuevo3.setValores(2,Dia.Lunes,1820,14111993,"Los pibes de Accenture"))
		
		
	}
	
	def validarConfirmacionPartido() {
		partidos.findFirst[partido|partido==partidoSeleccionado].confirmarPartido
				
	}
	
	def refresh() {
		var partidosAux = partidos
		partidos = new ArrayList
		partidos = partidosAux
	}
	
}
