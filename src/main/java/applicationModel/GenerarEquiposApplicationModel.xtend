package applicationModel

import domain.CriterioCompuesto
import domain.CriterioHandicap
import domain.CriterioNCalificaciones
import domain.CriterioUltimoPartido
import domain.Partido
import domain.Sistema
import java.util.ArrayList
import org.eclipse.xtend.lib.Property
import org.uqbar.commons.model.Entity
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable

@Observable
class GenerarEquiposApplicationModel extends Entity {

	@Property Sistema sistema = new Sistema
	@Property boolean criterioHandicapValidator = false
	@Property boolean criterioUltimoPartidoValidator = false
	@Property boolean criterioUltimosNPartidosValidator = false
	@Property boolean paridadValidator = false
	@Property int cantidadPartidos
	@Property Partido modeloPartido

	new(Partido partido) {
		modeloPartido = partido
	}

	def copiarValoresDe(Partido partido) {
		modeloPartido.copiarValoresDe(partido)
	}

	def ordenarJugadores() {
		validateNPartidos
		var criterioCompuesto = new CriterioCompuesto
		if(criterioHandicapValidator) criterioCompuesto.criterios.add(new CriterioHandicap)
		if(criterioUltimoPartidoValidator) criterioCompuesto.criterios.add(new CriterioUltimoPartido)
		if (criterioUltimosNPartidosValidator) {
			var criterioNPartidos = new CriterioNCalificaciones
			criterioNPartidos.setCantidadCalificaciones(cantidadPartidos)
			criterioCompuesto.criterios.add(criterioNPartidos)
		}
		validateCriterio(criterioCompuesto)
		refreshJugadoresOrdenados
	}
	
	def refreshJugadoresOrdenados() {
		var arrayAux = modeloPartido.jugadoresOrdenados
		 modeloPartido.jugadoresOrdenados = new ArrayList
		  modeloPartido.jugadoresOrdenados = arrayAux
		
	}

	def validateCriterio(CriterioCompuesto criterioCompuesto) {
		if (!(criterioCompuesto.criterios.isEmpty))
			sistema.organizarJugadoresPorCriterio(criterioCompuesto, modeloPartido)
		else {
			throw new UserException("No seleccionó ningún criterio")
		}
	}

	def validateNPartidos() {
		if ((cantidadPartidos == 0) && criterioUltimosNPartidosValidator)
			throw new UserException("Ingrese un numero distinto de cero")
	}
	
	def generarEquipos() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}
