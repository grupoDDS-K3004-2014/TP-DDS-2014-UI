package applicationModel

import domain.Participante
import java.io.Serializable
import java.util.ArrayList
import java.util.Date
import java.util.List
import org.uqbar.commons.utils.ApplicationContext
import org.uqbar.commons.utils.Observable
import ui.HomeJugadores

@Observable

class BuscardorDeJugadores implements Serializable {
	@Property String nombre
	@Property Date fechaNacimientoAnterior
	@Property int handicapInicial
	@Property String apodo 
	@Property List<Participante> resultadoParticipantes
	@Property int handicapFinal
	@Property long promedioDesde
	@Property long promedioHasta
	@Property boolean tieneInfraccion=true
	@Property boolean noTieneInfraccion=true
	

	// Application model que representa la busqueda de Jugadores
  ///Contiene:
 //El estado de los atributos por los cuales buscar: nombre,apodo,fecha de nacimiento,
 //rango handicap,etc
 //El comportamiento para realizar la busqueda que la delegarÃ¡ en la home
 
	def void search() {

		//para que refresque la grilla en las actualizaciones limpio lista
		// es como crearla o derjarla vacia y cargarla
		resultadoParticipantes = new ArrayList<Participante>

		// asigno a todos ahora
		resultadoParticipantes = getHomeParticipantes().search(nombre, fechaNacimientoAnterior, handicapInicial,handicapFinal ,apodo,tieneInfraccion,noTieneInfraccion,promedioDesde,promedioHasta)
		  //ObservableUtils.firePropertyChanged(this,"resultadosParticipantes", resultadoParticipantes)
	}

	def HomeJugadores getHomeParticipantes() {

		//obtener todas las instancias de participantes
		ApplicationContext.instance.getSingleton(typeof(Participante))
	}

	def void clear() {

		//limpiar campos de la busqueda
		nombre = null
		fechaNacimientoAnterior = null
		handicapInicial = 0
		handicapFinal=0
		apodo = null
	}

}
