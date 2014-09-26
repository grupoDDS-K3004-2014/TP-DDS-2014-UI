package applicationModel

import domain.Dia
import domain.partido.Partido
import java.util.ArrayList
import org.uqbar.commons.model.Entity
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable
import home.HomePartidos
import org.uqbar.commons.utils.ApplicationContext

@Observable
class OTFApplicationModel extends Entity {

	@Property Partido partidoSeleccionado
	ArrayList<Partido> partidos = getHomePartidos().getPartidos

	def ArrayList<Partido> getPartidos() {
		partidos = getHomePartidos().getPartidos
	}

	def ArrayList<Partido> setPartidos(ArrayList<Partido> partido) {
		partidos = getHomePartidos().getPartidos()
	}

	def HomePartidos getHomePartidos() {
		ApplicationContext.instance.getSingleton(typeof(Partido))
	}

	def refresh() {
		partidos = new ArrayList
		partidos = getHomePartidos().getPartidos
	}

	def validarEquipoListoParaOrganizar() {
		partidoSeleccionado.cantidadParticipantes != 10

	}

	def boolean getEquipoListoParaOrganizar() {
		validarEquipoListoParaOrganizar

	}

	def validateGenerarEquipos() {
		if (validarEquipoListoParaOrganizar)
			throw new UserException("El equipo no tiene la cantidad suficiente de jugadores como para ser ordenado")
	}

	def String fixDiaFormat(Dia dia) {
		switch (dia) {
			case Dia.Lunes: "Lunes"
			case Dia.Martes: "Martes"
			case Dia.Miercoles: "Miercoles"
			case Dia.Jueves: "Jueves"
			case Dia.Viernes: "Viernes"
			case Dia.Sabado: "Sabado"
			case Dia.Domingo: "Domingo"
		}

	}

	def String fixTimeFormat(int horario) {
		return ((horario / 100).toString) + ":" + ((horario % 100).toString)
	}

	def confirmarPartido() {
		validarConfirmacionPartido
		if (partidoSeleccionado.confirmado == "No")
			partidoSeleccionado.confirmado = "Si"
		if (partidoSeleccionado.confirmado == "Si")
			partidoSeleccionado.confirmado = "No"
		refresh

	}

	def validarConfirmacionPartido() {
		if(partidoSeleccionado.equipoA.size != 5) throw new UserException("El equipo no está organizado")
	}

}
