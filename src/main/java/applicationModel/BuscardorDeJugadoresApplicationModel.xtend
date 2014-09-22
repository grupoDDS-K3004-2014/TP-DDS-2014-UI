package applicationModel

import domain.Participante
import java.io.Serializable
import java.util.ArrayList
import java.util.Date
import java.util.List
import org.uqbar.commons.utils.ApplicationContext
import org.uqbar.commons.utils.Observable
import home.HomeJugadores

@Observable
class BuscardorDeJugadoresApplicationModel implements Serializable {
	@Property String nombre
	@Property Date fechaNacimientoAnterior
	@Property int handicapInicial
	@Property String apodo
	@Property List<Participante> resultadoParticipantes
	@Property int handicapFinal
	@Property long promedioDesde
	@Property long promedioHasta
	@Property boolean tieneInfraccion = true
	@Property boolean noTieneInfraccion = true

	def void search() {

		resultadoParticipantes = new ArrayList<Participante>
		resultadoParticipantes = getHomeParticipantes().search(nombre, fechaNacimientoAnterior, handicapInicial,
			handicapFinal, apodo, tieneInfraccion, noTieneInfraccion, promedioDesde, promedioHasta)

	}

	def HomeJugadores getHomeParticipantes() {

		ApplicationContext.instance.getSingleton(typeof(Participante))
	}

	def void clear() {

		nombre = null
		fechaNacimientoAnterior = null
		handicapInicial = 0
		handicapFinal = 0
		apodo = null
		promedioDesde = 0
		promedioHasta = 0
		tieneInfraccion = false
		noTieneInfraccion = false
	}

}
