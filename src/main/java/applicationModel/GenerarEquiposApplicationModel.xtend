package applicationModel

import domain.CriterioCompuesto
import domain.CriterioHandicap
import domain.CriterioNCalificaciones
import domain.CriterioUltimoPartido
import domain.Participante
import domain.Partido
import domain.Sistema
import java.util.ArrayList
import java.util.Arrays
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
	@Property boolean parImparValidator = false
	@Property ArrayList<String> selectorOpcion = new ArrayList
	@Property String opcionSeleccionada = "Par"
	@Property boolean posicionCustom = false
	@Property Participante jugadorSeleccionado	
	@Property String primerJugador = "1"
	@Property String segundoJugador ="1"
	@Property String tercerJugador="1"
	@Property String cuartoJugador="1"
	@Property String quintoJugador="1"
	@Property ArrayList<String> listaDePosiciones = new ArrayList<String>

	new(Partido partido) {
		modeloPartido = partido
		this.init
	}

	def init() {
		selectorOpcion.add("Par")
		selectorOpcion.add("Impar")
		listaDePosiciones.add("1")
		listaDePosiciones.add("2")
		listaDePosiciones.add("3")
		listaDePosiciones.add("4")
		listaDePosiciones.add("5")
		listaDePosiciones.add("6")
		listaDePosiciones.add("7")
		listaDePosiciones.add("8")
		listaDePosiciones.add("9")
		listaDePosiciones.add("10")

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
		validarSeleccion
		validarOrdenPrevio
		if (posicionCustom) {
			validarInput
			sistema.generarEquiposTentativos(modeloPartido, parseInputArray)
			sistema.confirmarEquipos(modeloPartido)
		}
		if (parImparValidator) {
			if (opcionSeleccionada == "Par") {
				sistema.generarEquiposTentativos(modeloPartido, new ArrayList<Integer>(Arrays.asList(1, 3, 5, 7, 9)))
				sistema.confirmarEquipos(modeloPartido)
			} else {
				sistema.generarEquiposTentativos(modeloPartido, new ArrayList<Integer>(Arrays.asList(2, 4, 6, 8, 10)))
				sistema.confirmarEquipos(modeloPartido)
			}
		} 

	}
	
	def validarSeleccion() {
		if(noHaySeleccion) throw new UserException("Seleccione un criterio de selección")
		validarUnicidadSeleccion
	}
	
	def boolean noHaySeleccion() {
		!(parImparValidator || posicionCustom)
	}
	
	def ArrayList<Integer> parseInputArray() {
		var arrayPosiciones = new ArrayList<Integer>
		arrayPosiciones.add(toInt(primerJugador))
		arrayPosiciones.add(toInt(segundoJugador))
		arrayPosiciones.add(toInt(tercerJugador))
		arrayPosiciones.add(toInt(cuartoJugador))
		arrayPosiciones.add(toInt(quintoJugador))
		return arrayPosiciones
	}

	def validarOrdenPrevio() {
		if (modeloPartido.jugadoresOrdenados.empty) {
			throw new UserException("No estan ordenados los jugadores")
		}
	}

	def Integer toInt(String numeroString) {
		Integer.parseInt(numeroString)
	}

	def validarInput() {
		validarRepeticion
	}

	def validarRepeticion() {
		var array = parseInputArray
		if((array.toSet.size )!= 5 ) throw new UserException("Hay posiciones repetidas, por favor arréglelas")
	}

	def validarUnicidadSeleccion() {
		if(posicionCustom && parImparValidator) throw new UserException("Marque unicamente un criterio de selección")

	}

}
