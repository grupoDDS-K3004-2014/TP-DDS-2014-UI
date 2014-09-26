package home

import domain.calificaciones.Calificacion
import domain.infracciones.InfraccionMalaConducta
import domain.jugadores.Estandar
import domain.jugadores.Participante
import java.util.ArrayList
import org.apache.commons.collections15.Predicate
import org.uqbar.commons.model.CollectionBasedHome
import org.uqbar.commons.utils.ApplicationContext
import domain.partido.Partido

class HomeJugadores extends CollectionBasedHome<Participante> {

	new() {
		this.init
	}

	def void init() {

		var partido1 = getHomePartidos().search("El superClasico de Martelli").head
		var partido2 = getHomePartidos().search("Los pibes de Accenture").head
		var partido3 = getHomePartidos().search("Don Torcuato copa").head

		var erwin = new Estandar => [
			nombre = "Erwin"
			apodo = "Erw"
			fechaNacimiento = "14/02/1993"
			handicap = 5
			calificaciones = new ArrayList<Calificacion>(
				#[Calificacion.nueva(2, "Baboso!", "26/09/2014"), Calificacion.nueva(5, "Baboso!", "27/09/2014")])
		]

		var maggie = new Estandar => [
			nombre = "Maggie"
			apodo = "Purri"
			fechaNacimiento = "28/05/1992"
			handicap = 20
			calificaciones = new ArrayList<Calificacion>(#[Calificacion.nueva(10, "Trompitástico!", "26/09/2014")])
		]

		var mariano = new Estandar => [
			nombre = "Mariano"
			apodo = "das Marian"
			fechaNacimiento = "05/02/1993"
			handicap = 12
			calificaciones = new ArrayList<Calificacion>(#[Calificacion.nueva(3, "Lagoso", "26/09/2014")])
		]
		var roman = new Estandar => [
			nombre = "Roman"
			apodo = "Romi"
			fechaNacimiento = "23/06/1994"
			handicap = 5
		]
		var pablo = new Estandar => [
			nombre = "Pablo"
			apodo = "Pablito"
			fechaNacimiento = "12/06/1993"
			handicap = 1
			infracciones = new ArrayList(
				#[InfraccionMalaConducta.nueva("28/09/2014", "Cagarme con el regalo para Maggie")])
			calificaciones = new ArrayList<Calificacion>(#[Calificacion.nueva(5, "Jugo bien", "26/09/2014")])
		]

		var pepeto = new Estandar => [
			nombre = "Pepeto"
			apodo = "el Pepi"
			fechaNacimiento = "12/06/1983"
			handicap = 5
			calificaciones = new ArrayList<Calificacion>(
				#[Calificacion.nueva(5, "Meh", "10/10/2010"), Calificacion.nueva(3, "Meh", "11/10/2010"),
					Calificacion.nueva(6, "Meh", "12/10/2010")])
		]

		var rogelio = new Estandar => [
			nombre = "Rogelio"
			apodo = "Rogi"
			fechaNacimiento = "27/04/1990"
			handicap = 5
			infracciones = new ArrayList(#[InfraccionMalaConducta.nueva("28/09/2014", "Pegarle al referi")])
			calificaciones = new ArrayList<Calificacion>(#[Calificacion.nueva(5, "Meh", "10/10/2010")])
		]

		var walflavio = new Estandar => [
			nombre = "Walflavio"
			apodo = "Wally"
			fechaNacimiento = "10/02/1980"
			handicap = 5
		]

		var jesus = new Estandar => [
			nombre = "Jesus"
			apodo = "el mesias"
			fechaNacimiento = "00/00/0000"
			handicap = 33
			calificaciones = new ArrayList<Calificacion>(#[Calificacion.nueva(10, "Resucito el partido", "11/10/2010")])
		]

		var sebastian = new Estandar => [
			nombre = "Sebastian"
			apodo = "Sebas"
			fechaNacimiento = "05/02/1990"
			handicap = 8
			infracciones = new ArrayList(#[InfraccionMalaConducta.nueva("28/09/2014", "Llego muy tarde")])
			calificaciones = new ArrayList<Calificacion>(#[Calificacion.nueva(5, "Meh", "10/10/2010")])
		]
		partido1.suscribir(erwin)
		partido1.suscribir(maggie)
		partido1.suscribir(mariano)
		partido1.suscribir(pablo)
		partido1.suscribir(roman)
		partido1.suscribir(jesus)
		partido1.suscribir(sebastian)
		partido1.suscribir(walflavio)
		partido1.suscribir(pepeto)
		partido1.suscribir(rogelio)

		partido2.suscribir(rogelio)
		partido2.suscribir(pablo)
		partido2.suscribir(walflavio)
		partido2.suscribir(jesus)
		partido2.suscribir(sebastian)
		partido2.suscribir(pepeto)

		partido3.suscribir(erwin)

		create(erwin, new ArrayList<Participante>(#[maggie, mariano, pablo]))
		create(maggie, new ArrayList<Participante>(#[erwin, mariano, roman, pablo]))
		create(mariano, new ArrayList<Participante>(#[erwin, maggie, roman, pablo]))
		create(pablo, new ArrayList<Participante>(#[erwin, maggie, mariano]))
		create(roman, new ArrayList<Participante>(#[erwin, maggie, mariano]))
		create(pepeto, new ArrayList<Participante>())
		create(rogelio, new ArrayList<Participante>(#[jesus, walflavio]))
		create(walflavio, new ArrayList<Participante>(#[erwin, mariano]))
		create(jesus,
			new ArrayList<Participante>(#[erwin, maggie, mariano, pablo, roman, pepeto, rogelio, walflavio, sebastian]))
		create(sebastian, new ArrayList<Participante>(#[erwin, maggie]))
	}

	def HomePartidos getHomePartidos() {
		ApplicationContext.instance.getSingleton(typeof(Partido))
	}

	def create(Participante participante, ArrayList<Participante> listaDeAmigos) {
		participante.amigos = listaDeAmigos
		create(participante)
	}

	override protected Predicate<Participante> getCriterio(Participante example) {
		null
	}

	override createExample() {
		new Participante
	}

	override getEntityType() {
		typeof(Participante)
	}

	def search(String nombre, String fechaNacimiento, int handicapInicial, int handicapFinal, String apodo,
		boolean tieneInfraccion, int promedioDesde, int promedioHasta) {
		new ArrayList(
			allInstances.filter[jugador|
				this.tieneElNombre(nombre, jugador.nombre) && this.tieneElApodo(apodo, jugador.apodo) &&
					this.cumpleCon(handicapInicial, jugador.handicap) &&
					this.suHandicapEsMenorA(handicapFinal, jugador.handicap) &&
					cumpleInfracciones(tieneInfraccion, jugador) &&
					this.fechaAnteriorA(fechaNacimiento, jugador.fechaNacimiento) &&
					this.tienePromedioMenorA(promedioHasta, jugador.ultimaNota) &&
					this.tienePromedioMayorA(promedioDesde, jugador.ultimaNota)].toList)
	}

	def cumpleCon(int handicapInicial, int handicap) {
		if (handicapInicial == 0) {
			return true
		} else {
			handicap >= handicapInicial
		}
	}

	def tieneElNombre(String string, String nombre) {
		if (string == null) {
			return true
		} else {
			nombre.toString().toLowerCase().contains(string.toString().toLowerCase())
		}
	}

	def tieneElApodo(String apo, String apodo) {
		if (apo == null) {
			return true
		} else {
			apodo.toString().toLowerCase().contains(apo.toString().toLowerCase())
		}
	}

	def fechaAnteriorA(String fechaNacimientoBusqueda, String fechaNacimientoJugador) {
		if (fechaNacimientoBusqueda != "" && fechaNacimientoJugador != null)
			verificarAño(fechaNacimientoBusqueda, fechaNacimientoJugador.substring(6))
		else
			true

	}

	def verificarAño(String fechaBusqueda, String fechaJugador) {
		Integer.parseInt(fechaJugador) < Integer.parseInt(fechaBusqueda)
	}

	def suHandicapEsMenorA(int handicapMayor, int handicap) {
		if (handicapMayor == 0) {
			return true
		} else {
			handicap <= handicapMayor
		}
	}

	def cumpleInfracciones(boolean tieneInfraccion, Participante jugador) {

		if (tieneInfraccion)
			jugador.infracciones.size != 0
		else
			jugador.infracciones.size == 0

	}

	def tienePromedioMenorA(long promedioMayor, long promedio) {
		if (promedioMayor == 0) {
			return true
		} else {
			promedio < promedioMayor
		}
	}

	def tienePromedioMayorA(long promedioMenor, long promedio) {
		if (promedioMenor == 0) {
			return true
		} else {
			promedio > promedioMenor
		}
	}

	def searchAll() {
		new ArrayList(allInstances)
	}

}
