package applicationModel

import domain.jugadores.Participante
import java.io.Serializable
import java.util.HashSet
import java.util.Set
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable
import persistencia.HomeParticipantes

@Observable
class BuscardorDeJugadoresApplicationModel implements Serializable {
	@Property String nombre = ""
	@Property String fechaNacimientoAnterior = ""
	@Property int handicapInicial = 0
	@Property String apodo = ""
	@Property Set<Participante> resultadoParticipantes
	@Property int handicapFinal = 0
	@Property int notaUltimoPartidoDesde = 0
	@Property int notaUltimoPartidoHasta = 0
	@Property boolean tieneInfraccion = false
	@Property Participante jugadorSeleccionado

	def void search() {
		validarFechaDeNacimiento
		resultadoParticipantes = new HashSet<Participante>
		resultadoParticipantes = HomeParticipantes::search(nombre, fechaNacimientoAnterior, handicapInicial,
			handicapFinal, apodo, tieneInfraccion, notaUltimoPartidoDesde, notaUltimoPartidoHasta)

	}

	def validarFechaDeNacimiento() {
		if (fechaNacimientoAnterior != "")
			if(fechaNacimientoAnterior.length != 4) throw new UserException("Ingrese el año como AAAA")

	}

	def void clear() {

		nombre = ""
		fechaNacimientoAnterior = ""
		handicapInicial = 0
		handicapFinal = 0
		apodo = ""
		notaUltimoPartidoDesde = 0
		notaUltimoPartidoHasta = 0
		tieneInfraccion = false
		resultadoParticipantes = HomeParticipantes::getAll()
	}

	def validarJugadorSeleccionado() {
		if (jugadorSeleccionado == null)
			throw new UserException("No se seleccionó jugador")
	}

	def searchAll() {
		resultadoParticipantes = HomeParticipantes::getAll()
	}

}
