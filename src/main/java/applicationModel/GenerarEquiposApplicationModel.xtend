package applicationModel

import domain.jugadores.Participante
import domain.partido.Partido
import java.util.ArrayList
import org.uqbar.commons.model.Entity
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable
import domain.criterios.CriterioCompuesto
import domain.criterios.CriterioHandicap
import domain.criterios.CriterioUltimoPartido
import domain.criterios.CriterioNCalificaciones

@Observable
class GenerarEquiposApplicationModel extends Entity {

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
	@Property String segundoJugador = "2"
	@Property String tercerJugador = "3"
	@Property String cuartoJugador = "4"
	@Property String quintoJugador = "5"
	@Property ArrayList<String> listaDePosiciones = new ArrayList<String>
	@Property CriterioCompuesto criterioCompuesto = new CriterioCompuesto

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
		validateCriterio
		criterioCompuesto.criterios.clear
		if (criterioHandicapValidator)
			criterioCompuesto.agregarCriterio(new CriterioHandicap)
		if (criterioUltimoPartidoValidator)
			criterioCompuesto.agregarCriterio(new CriterioUltimoPartido)
		if (criterioUltimosNPartidosValidator) {
			validateNPartidos
			criterioCompuesto.agregarCriterio(CriterioNCalificaciones.nuevo(cantidadPartidos))
		}

		modeloPartido.ordenarJugadores(criterioCompuesto)
		refreshJugadoresOrdenados
	}

	def refreshJugadoresOrdenados() {
		var arrayAux = modeloPartido.jugadoresOrdenados
		modeloPartido.jugadoresOrdenados = new ArrayList
		modeloPartido.jugadoresOrdenados = arrayAux

	}

	def validateCriterio() {
		if (!(criterioHandicapValidator || criterioUltimoPartidoValidator || criterioUltimosNPartidosValidator)) {
			throw new UserException("No seleccionó ningún criterio")
		}

	}

	def validateNPartidos() {
		if ((cantidadPartidos == 0) && criterioUltimosNPartidosValidator)
			throw new UserException("Ingrese un numero distinto de cero")
	}

	def generarEquipos() {
		validarSeleccion
		if (parImparValidator) {
			if (opcionSeleccionada == "Par")
				modeloPartido.separarJugadoresOrdenados(new ArrayList(#[2, 4, 6, 8, 10]))
			else
				modeloPartido.separarJugadoresOrdenados(new ArrayList(#[1, 3, 5, 7, 9]))

		} else
			modeloPartido.separarJugadoresOrdenados(parseInputArray)

		moverEquipos
		

	}

	def moverEquipos() {
		var aux = modeloPartido.equipoA
		modeloPartido.equipoA = new ArrayList
		modeloPartido.equipoA = aux

		aux = modeloPartido.equipoB
		modeloPartido.equipoB = new ArrayList
		modeloPartido.equipoB = aux
	}

	def validarSeleccion() {
		if(noHaySeleccion) throw new UserException("Seleccione un criterio de selección")
		validarUnicidadSeleccion
	}

	def boolean noHaySeleccion() {
		!(parImparValidator || posicionCustom)
	}

	def ArrayList<Integer> parseInputArray() {
		validarSelectoresRepetidos
		var arrayPosiciones = new ArrayList<Integer>
		arrayPosiciones.add(toInt(primerJugador))
		arrayPosiciones.add(toInt(segundoJugador))
		arrayPosiciones.add(toInt(tercerJugador))
		arrayPosiciones.add(toInt(cuartoJugador))
		arrayPosiciones.add(toInt(quintoJugador))
		return arrayPosiciones
	}

	def validarSelectoresRepetidos() {
		var a = new ArrayList
		a.add(primerJugador)
		a.add(segundoJugador)
		a.add(tercerJugador)
		a.add(cuartoJugador)
		a.add(quintoJugador)
		if (a.toSet.size != 5)
			throw new UserException("Hay posiciones repetidas, por favor corrígalas")
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
		if((array.toSet.size ) != 5) throw new UserException("Hay posiciones repetidas, por favor arréglelas")
	}

	def validarUnicidadSeleccion() {
		if(posicionCustom && parImparValidator) throw new UserException("Marque unicamente un criterio de selección")

	}

	def validarJugadorSeleccionado() {
		if(jugadorSeleccionado == null) throw new UserException("No se seleccionó a ningún jugador")
	}

	def validarAceptar() {
		if(modeloPartido.equipoA.size != 5) throw new UserException("No se puede aceptar un equipo no armado")
	}

}
