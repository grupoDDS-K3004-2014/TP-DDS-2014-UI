package applicationModel

import domain.jugadores.Participante
import home.HomeJugadores
import java.io.Serializable
import java.util.ArrayList
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.ApplicationContext
import org.uqbar.commons.utils.Observable

@Observable
class BuscardorDeJugadoresApplicationModel implements Serializable {
	@Property String nombre = ""
	@Property String fechaNacimientoAnterior = ""
	@Property int handicapInicial
	@Property String apodo
	@Property ArrayList<Participante> resultadoParticipantes
	@Property int handicapFinal
	@Property int notaUltimoPartidoDesde
	@Property int notaUltimoPartidoHasta
	@Property boolean tieneInfraccion = false
	@Property Participante jugadorSeleccionado

	def void search() {
		validarFechaDeNacimiento
		resultadoParticipantes = new ArrayList<Participante>
		resultadoParticipantes = getHomeParticipantes().search(nombre, fechaNacimientoAnterior, handicapInicial,
			handicapFinal, apodo, tieneInfraccion, notaUltimoPartidoDesde, notaUltimoPartidoHasta)

	}

	def validarFechaDeNacimiento() {
		if (fechaNacimientoAnterior != "")
			if(fechaNacimientoAnterior.length != 4) throw new UserException("Ingrese el año como AAAA")

	}

	def HomeJugadores getHomeParticipantes() {

		ApplicationContext.instance.getSingleton(typeof(Participante))

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
		resultadoParticipantes = homeParticipantes.searchAll
	}

	def validarJugadorSeleccionado() {
		if (jugadorSeleccionado == null)
			throw new UserException("No se seleccionó jugador")
	}

	def searchAll() {
		resultadoParticipantes = getHomeParticipantes().searchAll()
	}

}
