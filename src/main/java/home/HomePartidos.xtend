package home

import domain.Dia
import domain.partido.Partido
import org.apache.commons.collections15.Predicate
import org.uqbar.commons.model.CollectionBasedHome

class HomePartidos extends CollectionBasedHome<Partido> {

	new() {
		this.init
	}

	def void init() {

		var partido1 = new Partido => [
			nombreDelPartido = "El superClasico de Martelli"
			dia = Dia.Sabado
			horario = 2230
			periodicidad = 2
			fecha = "25/09/2014"
		]
		var partido2 = new Partido => [
			nombreDelPartido = "Los pibes de Accenture"
			dia = Dia.Viernes
			horario = 1715
			periodicidad = 3
			fecha = "17/09/2014"
		]

		var partido3 = new Partido => [
			nombreDelPartido = "Don Torcuato copa"
			dia = Dia.Lunes
			horario = 1045
			periodicidad = 1
			fecha = "30/11/2014"
		]

		create(partido1)
		create(partido2)
		create(partido3)

	}

	override protected Predicate<Partido> getCriterio(Partido example) {
		null
	}

	override createExample() {
		new Partido
	}

	override getEntityType() {
		typeof(Partido)
	}

	def search(String nombre) {
		allInstances.filter[Partido partido|partido.nombreDelPartido == nombre]
	}

	def getPartidos() {
		allInstances
	}

}
