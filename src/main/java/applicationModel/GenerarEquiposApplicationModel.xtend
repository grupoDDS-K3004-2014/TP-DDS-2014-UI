package applicationModel

import domain.CriterioCompuesto
import domain.CriterioHandicap
import domain.CriterioNCalificaciones
import domain.CriterioUltimoPartido
import domain.Partido
import domain.Sistema
import java.util.ArrayList
import org.uqbar.commons.model.Entity
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable
import java.util.Arrays
import domain.Participante

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
	@Property String arrayCustom = ""
	@Property Participante jugadorSeleccionado

	new(Partido partido) {
		modeloPartido = partido
		this.init
	}

	def init() {
		selectorOpcion.add("Par")
		selectorOpcion.add("Impar")

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
		validarUnicidadSeleccion
		validarOrdenPrevio
		if (posicionCustom) {
			validarTextbox
			sistema.generarEquiposTentativos( modeloPartido, parseArrayPosicionesCustom)
			sistema.confirmarEquipos(modeloPartido)
		}
		if (parImparValidator) {
			if (opcionSeleccionada == "Par") {
				sistema.generarEquiposTentativos( modeloPartido, new ArrayList<Integer>(Arrays.asList(1,3,5,7,9)))
				sistema.confirmarEquipos(modeloPartido)
			} else {
				sistema.generarEquiposTentativos( modeloPartido, new ArrayList<Integer>(Arrays.asList(0,2,4,6,8)))
				sistema.confirmarEquipos(modeloPartido)
			}
		} else {
			throw new UserException("No hay ningun criterio de selección marcado")
		}

	}
	
	def validarOrdenPrevio() {
		if(modeloPartido.jugadoresOrdenados.empty){
			throw new UserException("No estan ordenados los jugadores")
		}
	}

	def ArrayList<Integer> parseArrayPosicionesCustom() {
		var arrayPosiciones = new ArrayList<Integer>
		arrayPosiciones.add(toInt(arrayCustom.substring(0, 0)))
		arrayPosiciones.add(toInt(arrayCustom.substring(2, 2)))
		arrayPosiciones.add(toInt(arrayCustom.substring(4, 4)))
		arrayPosiciones.add(toInt(arrayCustom.substring(6, 6)))
		arrayPosiciones.add(toInt(arrayCustom.substring(8, 8)))
		return arrayPosiciones
	}

	def Integer toInt(String numeroString) {
		Integer.parseInt(numeroString) -1
	}

	def validarUnicidadParImpar() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	def validarTextbox() {
		validarLonguitudArray
		validarFormato
	}

	def validarFormato() {
		if ((arrayCustom.substring(1, 2) + arrayCustom.substring(3, 4) + arrayCustom.substring(5, 6) +
			arrayCustom.substring(7, 8) ) == "----")
			throw new UserException(
				"Error en el formato. Por favor ingrese las posiciones como Pos1-...-Pos5. Recuerde que las posiciones van del 0 al 9")
	}

	def validarLonguitudArray() {
		if (arrayCustom.length != 9) {
			throw new UserException(
				"Error en el formato. Por favor ingrese las posiciones como Pos1-...-Pos5. Recuerde que las posiciones van del 0 al 9")
		}
	}

	def validarUnicidadSeleccion() {
		if(posicionCustom && parImparValidator) throw new UserException("Marque unicamente un criterio de selección")

	}

}
