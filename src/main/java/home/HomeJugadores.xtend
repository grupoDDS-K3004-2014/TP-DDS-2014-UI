package home

import domain.Infraccion
import domain.InfraccionBajaSinRemplazo
import domain.Participante
import java.text.SimpleDateFormat
import java.util.ArrayList
import java.util.Date
import java.util.List
import org.apache.commons.collections15.Predicate
import org.uqbar.commons.model.CollectionBasedHome

class HomeJugadores extends CollectionBasedHome<Participante> {

	SimpleDateFormat formatoDelTexto
	List<Participante> resultados = new ArrayList<Participante>
	Infraccion infraccion1 = new InfraccionBajaSinRemplazo

	new() {
		this.init
	}

	def void create(String nombre, String apodo, int handicap, Date fechaNacimiento, long promedio,
		List<Infraccion> infracciones) {
		var jugador = new Participante
		jugador.nombre = nombre
		jugador.apodo = apodo
		jugador.handicap = handicap
		jugador.fechaNacimiento = fechaNacimiento
		jugador.promedio = promedio
		jugador.infracciones = infracciones
		this.create(jugador)
		resultados.add(jugador)
	}

	def void init() {
		this.create("Juan", "pela", 60, stringToDate("12/12/1990"), 130, #[infraccion1])
		this.create("Marcos", "mar", 50, stringToDate("12/10/1997"), 10, #[])
		this.create("Martin", "tinchito", 90, stringToDate("27/12/1992"), 47, #[])
	}

	def Date stringToDate(String fecha) {
		formatoDelTexto = new SimpleDateFormat("dd/MM/yyyy")
		return formatoDelTexto.parse(fecha)

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

		//if(fechaNacimiento!=null&&date!=null){fechaNacimiento.before(date)}
		//else{throw new UserException("Debe Ingresar fecha")}
		//PROBLEMAS ACA
		true
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
