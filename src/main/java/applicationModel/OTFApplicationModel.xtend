package applicationModel

import domain.partido.Partido
import java.util.HashSet
import java.util.Set
import org.uqbar.commons.model.Entity
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable
import persistencia.HomePartidos
import persistencia.SessionManager

@Observable
class OTFApplicationModel extends Entity {

	@Property Partido partidoSeleccionado
	@Property Set<Partido> partidos = HomePartidos::getAll

	new() {
	}

	def refresh() {
		partidos = new HashSet
		partidos = HomePartidos::getAll
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

	def String fixTimeFormat(int horario) {
		return ((horario / 100).toString) + ":" + ((horario % 100).toString)
	}

	def validarConfirmacionPartido() {
		if(partidoSeleccionado.equipoA.size != 5) throw new UserException("El equipo no está organizado")
	}

	def confirmarDesconfirmarPartido() {
		validarConfirmacionPartido
		partidoSeleccionado.confirmarDesconfirmarPartido
		val session = SessionManager::getSessionFactory.openSession
		session.beginTransaction
		session.merge(partidoSeleccionado)
		session.flush
		session.transaction.commit
		session.close
	}

}
