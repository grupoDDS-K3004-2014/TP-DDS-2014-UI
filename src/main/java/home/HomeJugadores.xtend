package home

import domain.Infraccion
import domain.Participante
import java.awt.Color
import java.text.SimpleDateFormat
import java.util.Date
import java.util.List
import org.apache.commons.collections15.Predicate
import org.uqbar.commons.model.CollectionBasedHome
import java.util.ArrayList
import domain.Estandar

class HomeJugadores extends CollectionBasedHome<Participante> {

	SimpleDateFormat formatoDelTexto = new SimpleDateFormat("dd/MM/yyyy")

	new() {
		this.init
	}

	def void create(String nombre, String apodo, int handicap, String fechaNacimiento, long promedio,
		ArrayList<Participante> amigos) {
		var jugador = new Participante
		jugador.nombre = nombre
		jugador.apodo = apodo
		jugador.handicap = handicap
		jugador.fechaNacimiento = stringToDate(fechaNacimiento)
		jugador.promedio = promedio
		jugador.amigos = amigos
		this.create(jugador)

	}

	def void init() {
		var amigo = new Estandar
		amigo.setNombre("Mariano")
		var amigo2 = new Estandar
		amigo.setNombre("Maggie")
		var amigo3 = new Estandar
		amigo.setNombre("Roman")
		var amigo4 = new Estandar
		amigo.setNombre("Pablo")
		var amigo5 = new Estandar
		amigo.setNombre("Erwin")

		this.create("Erwin", "Erw", 10, "3/12/1992", 5, new ArrayList<Participante>(#[amigo2, amigo3, amigo4, amigo]))
		this.create("Mariano", "das Marian", 20, "6/12/1992", 7, new ArrayList<Participante>(#[amigo5, amigo3, amigo4, amigo2]))
		this.create("Maggie", "Maggie", 30, "7/12/1992", 27, new ArrayList<Participante>(#[amigo5, amigo3, amigo4, amigo]))
		this.create("Román", "Romi", 5, "8/12/1992", 5, new ArrayList<Participante>(#[amigo5, amigo, amigo4, amigo2]))
		this.create("Pablo", "Pablito", 3, "5/12/1992", 6, new ArrayList<Participante>(#[amigo, amigo2, amigo3, amigo5]))
		this.create("Rogelio", "Roggi", 4, "27/12/1992", 10, new ArrayList<Participante>)
		this.create("Pepeto", "Pep", 2, "28/12/1992", 7, new ArrayList<Participante>)
		this.create("Walflavio", "Wally", 1, "29/12/1992", 2, new ArrayList<Participante>)
		this.create("Esteban", "Esteban", 2, "30/12/1992", 23, new ArrayList<Participante>)
		this.create("Sebastian", "Sebas", 0, "31/12/1992", 1, new ArrayList<Participante>)
		this.create("Jose", "Pepe", 3, "27/8/1992", 0, new ArrayList<Participante>)
	}

	def Date stringToDate(String fecha) {
		formatoDelTexto = new SimpleDateFormat("dd/MM/yyyy")
		formatoDelTexto.parse(fecha)

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

	def search(String nombre, Date fechaNacimiento, int handicapInicial, int handicapFinal, String apodo,
		boolean tieneInfraccion, boolean noTieneInfraccion, long promedioDesde, long promedioHasta) {
		allInstances.filter[jugador|
			this.tieneElNombre(nombre, jugador.nombre) && this.tieneElApodo(apodo, jugador.apodo) &&
				this.cumpleCon(handicapInicial, jugador.handicap) &&
				this.suHandicapEsMenorA(handicapFinal, jugador.handicap) &&
				this.fechaAnteriorA(fechaNacimiento, jugador.fechaNacimiento) &&
				this.cumpleInfracciones(tieneInfraccion, noTieneInfraccion, jugador.infracciones) &&
				this.tienePromedioMenorA(promedioHasta, jugador.promedio) &&
				this.tienePromedioMayorA(promedioDesde, jugador.promedio)].toList
	}

	def tieneColor(Color color) {
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

	def fechaAnteriorA(Date date, Date fechaNacimiento) {
		if (fechaNacimiento != null && date != null) {
			fechaNacimiento.before(date)
		} else {
			return true
		}
	}

	def suHandicapEsMenorA(int handicapMayor, int handicap) {
		if (handicapMayor == 0) {
			return true
		} else {
			handicap <= handicapMayor
		}
	}

	def cumpleInfracciones(boolean tieneInfraccion, boolean noTieneInfraccion, List<Infraccion> infracciones) {
		if (tieneInfraccion && noTieneInfraccion == false) {
			infracciones.size != 0
		} else {
			if (tieneInfraccion == false && noTieneInfraccion) {
				infracciones.size == 0
			} else {
				true
			}
		}

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

}
