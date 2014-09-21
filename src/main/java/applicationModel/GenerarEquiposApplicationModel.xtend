package applicationModel

import domain.CriterioCompuesto
import domain.CriterioHandicap
import domain.CriterioNCalificaciones
import domain.CriterioUltimoPartido
import domain.Partido
import domain.Sistema
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
	@Property int cantidadPartidos
	@Property Partido modeloPartido
	

	new(Partido partido) {
		modeloPartido = partido
	}

	def copiarValoresDe(Partido partido) {
		modeloPartido.copiarValoresDe(partido)
	}

	def ordenarJugadores() {

		var criterioCompuesto = new CriterioCompuesto
		if(criterioHandicapValidator) criterioCompuesto.criterios.add(new CriterioHandicap)
		if(criterioUltimoPartidoValidator) criterioCompuesto.criterios.add(new CriterioUltimoPartido)
		if (criterioUltimosNPartidosValidator) {
			var criterioNPartidos = new CriterioNCalificaciones
			criterioNPartidos.setCantidadCalificaciones(cantidadPartidos)
			criterioCompuesto.criterios.add(new CriterioNCalificaciones)
		}
		if (!(criterioCompuesto.criterios.isEmpty))
			sistema.organizarJugadoresPorCriterio(criterioCompuesto, modeloPartido)
		else {
			throw new UserException("No seleccionó ningún criterio")
		}		
	}

}
