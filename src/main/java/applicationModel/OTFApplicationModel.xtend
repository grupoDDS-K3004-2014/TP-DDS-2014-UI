package applicationModel

import domain.Dia
import domain.partido.Partido
import java.util.ArrayList
import org.uqbar.commons.model.Entity
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable
import home.HomePartidos
import org.uqbar.commons.utils.ApplicationContext
import java.util.List

@Observable
class OTFApplicationModel extends Entity {

	@Property Partido partidoSeleccionado
	@Property List<Partido> partidos

	new() {
		init
	}

	def init() {
		partidos = homePartidos.partidos
	}

	def HomePartidos getHomePartidos() {
		ApplicationContext.instance.getSingleton(typeof(Partido))
	}

	def refresh() {
		partidos = new ArrayList
		partidos = getHomePartidos().partidos
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

	def validarConfirmacionPartido() {
		if(partidoSeleccionado.equipoA.size != 5) throw new UserException("El equipo no está organizado")
	}

	def confirmarDesconfirmarPartido() {
		validarConfirmacionPartido
		partidoSeleccionado.confirmarDesconfirmarPartido
	}

}
