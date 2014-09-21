package runnableApplication

import java.io.Serializable
import org.uqbar.commons.utils.Observable



import java.util.Date
import domain.Participante
import java.util.List
import java.util.ArrayList
import org.uqbar.commons.utils.ApplicationContext

@Observable

class BuscardorDeJugadores implements Serializable {
	@Property String nombre
	@Property Date fechaNacimiento
	@Property int handicap
	@Property String apodo
	@Property List<Participante> resultadoParticipantes

	// Application model que representa la bÃºsqueda de Jugadores
  ///Contiene:
 //El estado de los atributos por los cuales buscar: nombre,apodo,fecha de nacimiento,
 //rango handicap
 //El comportamiento para realizar la bÃºsqueda:en realidas es un intermediario que le delega  a la home
 
	def void search() {

		//para que refresque la grilla en las actualizaciones limpio lista
		// es como crearla o derjarla vacia y despuyÃ©s cargarla
		resultadoParticipantes = new ArrayList<Participante>

		// asigno a todos ahora
		resultadoParticipantes = getHomeParticipantes().search(nombre, fechaNacimiento, handicap, apodo)
	}

	def HomeJugadores getHomeParticipantes() {

		//obtener todas las instancias de participantes
		ApplicationContext.instance.getSingleton(typeof(Participante))
	}

	def void clear() {

		//limpiar campos de la busqueda
		nombre = null
		fechaNacimiento = null
		handicap = 0
		apodo = null
	}

}
