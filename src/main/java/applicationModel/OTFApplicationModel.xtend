package applicationModel

import domain.Dia
import domain.Estandar
import domain.Partido
import java.util.ArrayList
import org.eclipse.xtend.lib.Property
import org.uqbar.commons.model.Entity
import org.uqbar.commons.utils.Observable
import org.uqbar.commons.model.UserException

@Observable
class OTFApplicationModel extends Entity {

	@Property ArrayList<Partido> partidos = new ArrayList
	@Property Partido partidoSeleccionado

	new() {
		this.init()
	}

	def void init() {

		var partidoNuevo = new Partido

		var participante = new Estandar
		participante.setNombre("Erwin")
		participante.setHandicap(10)
		partidoNuevo.suscribir(participante)
		participante = new Estandar
		participante.setNombre("Mariano")
		participante.setHandicap(20)
		partidoNuevo.suscribir(participante)
		participante = new Estandar
		participante.setNombre("Maggie")
		participante.setHandicap(30)
		partidoNuevo.suscribir(participante)
		participante = new Estandar
		participante.setNombre("Román")
		participante.setHandicap(5)
		partidoNuevo.suscribir(participante)
		participante = new Estandar
		participante.setNombre("Pablo")
		participante.setHandicap(1)
		partidoNuevo.suscribir(participante)

		participante = new Estandar
		participante.setNombre("Rogelio")
		participante.setHandicap(10)
		partidoNuevo.suscribir(participante)
		participante = new Estandar
		participante.setNombre("Pepeto")
		participante.setHandicap(20)
		partidoNuevo.suscribir(participante)
		participante = new Estandar
		participante.setNombre("Walflavio")
		participante.setHandicap(30)
		partidoNuevo.suscribir(participante)
		participante = new Estandar
		participante.setNombre("Esteban")
		participante.setHandicap(5)
		partidoNuevo.suscribir(participante)
		participante = new Estandar
		participante.setNombre("Sebastian")
		participante.setHandicap(1)
		partidoNuevo.suscribir(participante)

		var partidoNuevo2 = new Partido

		participante = new Estandar
		participante.setNombre("Jose")
		participante.setHandicap(10)
		partidoNuevo2.suscribir(participante)
		participante = new Estandar
		participante.setNombre("Pedro")
		participante.setHandicap(20)
		partidoNuevo2.suscribir(participante)
		participante = new Estandar
		participante.setNombre("Ramiro")
		participante.setHandicap(30)
		partidoNuevo2.suscribir(participante)
		participante = new Estandar
		participante.setNombre("Santiago")
		participante.setHandicap(1)
		partidoNuevo2.suscribir(participante)

		var partidoNuevo3 = new Partido
		participante = new Estandar
		participante.setNombre("Walberto")
		partidoNuevo3.suscribir(participante)
		participante = new Estandar
		participante.setNombre("Rogelio")
		partidoNuevo3.suscribir(participante)
		participante = new Estandar
		participante.setNombre("Pepeto")
		partidoNuevo3.suscribir(participante)
		participante = new Estandar
		participante.setNombre("Rosbeñon")
		partidoNuevo3.suscribir(participante)

		partidos.add(partidoNuevo.setValores(1, Dia.Lunes, 1830, 10122014, "El superClasico de Martelli"))
		partidos.add(partidoNuevo2.setValores(1, Dia.Miercoles, 2215, 11102014, "Don Torcuato Copa"))
		partidos.add(partidoNuevo3.setValores(2, Dia.Lunes, 1820, 14111993, "Los pibes de Accenture"))

	}

	def validarConfirmacionPartido() {
		partidos.findFirst[partido|partido == partidoSeleccionado].confirmarPartido

	}

	def refresh() {
		var partidosAux = partidos
		partidos = new ArrayList
		partidos = partidosAux
	}

	def validarEquipoListoParaOrganizar() {
		partidoSeleccionado.cantidadInscriptos != 10

	}

	def boolean getEquipoListoParaOrganizar() {
		validarEquipoListoParaOrganizar
	}

	def String fixDateFormat(int fecha) {
		((fecha / 1000000).toString) + "/" + (((fecha) / 10000) % 100).toString + "/" + (fecha % 10000).toString
	}

	def validateGenerarEquipos() {
		if(partidoSeleccionado.cantidadInscriptos != 10) throw new UserException(
			"El equipo no tiene la cantidad suficiente de jugadores como para ser ordenado")
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

}
