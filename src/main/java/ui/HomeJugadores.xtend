package ui

import org.uqbar.commons.model.CollectionBasedHome
import domain.Participante
import java.text.SimpleDateFormat
import java.util.Date
import org.apache.commons.collections15.Predicate

class HomeJugadores extends CollectionBasedHome<Participante>{
	
	SimpleDateFormat formatoDelTexto 
	
	new() {
		this.init
	}
	
	def void create(String nombre,String apodo, int handicap, Date fechaNacimiento){
		var jugador= new Participante
		jugador.nombre=nombre
		jugador.apodo=apodo
		jugador.handicap=handicap
		jugador.fechaNacimiento=fechaNacimiento
		this.create(jugador)
	}
	
	def void init() {
		this.create("Juan","pela",60,stringToDate("12/12/1990"))
		this.create("Marcos","mar",50,stringToDate("12/10/1997"))
		this.create("Martin","tinchito",90,stringToDate("27/12/1992"))
	}
	
	def Date stringToDate(String fecha){
	formatoDelTexto = new SimpleDateFormat("dd/MM/yyyy")
	return formatoDelTexto.parse(fecha)
	
}
	
	
	override protected Predicate<Participante>getCriterio(Participante example) {
		null
	}
	
	override createExample() {
		new Participante
	}
	
	override getEntityType() {
		typeof(Participante)
	}
	
	def search(String nombre, Date fechaNacimiento, int handicap, String apodo) {
		allInstances.filter[jugador|this.macheaCon(nombre, jugador.nombre) && this.macheaCon(fechaNacimiento, jugador.fechaNacimiento) && this.macheaCon(handicap, jugador.handicap) && this.macheaCon(apodo, jugador.apodo)].toList
	}
	
	
	def macheaCon(Object expectedValue, Object realValue) {
		if (expectedValue == null) {
			return true
		}
		if (realValue == null) {
			return false
		}
			realValue.toString().toLowerCase().contains(expectedValue.toString().toLowerCase())
	}
	

	// de todos los jugadores, se fija que de los de la home coincidan con lo que puse en la busqueda
	//si por ejemplo pongo Laura con handicap 100, como ya no existe el nombre Laura en la home, entonces me devuelve false
	// al devolver false se corta la busqueda, porque ya no cumple con una de las propiedades
	//en cambio si uno de mis campos de busqueda es vacio, por ejemplo, no pongo nada en el nombre y si pongo en el handicap, me devuelve true
	//al devolver true continua la busqueda mirando otro atributo
	
}
