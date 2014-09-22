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

class HomeJugadores extends CollectionBasedHome<Participante>{
	
	// tal vez haya que unificarla con la de los chicos
	
	SimpleDateFormat formatoDelTexto 
	List<Participante> resultados=new ArrayList<Participante>
	Infraccion infraccion1=new InfraccionBajaSinRemplazo
	
	new() {
		this.init
	}
	
	def void create(String nombre,String apodo, int handicap, Date fechaNacimiento,long promedio,List<Infraccion> infracciones){
		var jugador= new Participante
		jugador.nombre=nombre
		jugador.apodo=apodo
		jugador.handicap=handicap
		jugador.fechaNacimiento=fechaNacimiento
		jugador.promedio=promedio
		jugador.infracciones=infracciones
		this.create(jugador)
		resultados.add(jugador)
	}
	
	def void init() {
		this.create("Juan","pela",60,stringToDate("12/12/1990"),130,#[infraccion1])
		this.create("Marcos","mar",50,stringToDate("12/10/1997"),10,#[])
		this.create("Martin","tinchito",90,stringToDate("27/12/1992"),47,#[])
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
	
	def search(String nombre, Date fechaNacimiento, int handicapInicial,int handicapFinal, String apodo,boolean tieneInfraccion,boolean noTieneInfraccion,long promedioDesde,long promedioHasta) {
		allInstances.filter[jugador|jugador.tieneElNombre(nombre)&&jugador.tieneElApodo(apodo)&&jugador.cumpleCon(handicapInicial)&&jugador.suHandicapEsMenorA(handicapFinal)&&jugador.fechaAnteriorA(fechaNacimiento)&&jugador.cumpleInfracciones(tieneInfraccion,noTieneInfraccion)&&jugador.tienePromedioMenorA(promedioHasta)&&jugador.tienePromedioMayorA(promedioDesde)].toList
	}
	
	
	// de todos los jugadores, se fija que de los de la home coincidan con lo que puse en la busqueda
	//si por ejemplo pongo Laura con handicap 100, como ya no existe el nombre Laura en la home, entonces me devuelve false
	// al devolver false se corta la busqueda, porque ya no cumple con una de las propiedades
	//en cambio si uno de mis campos de busqueda es vacio, por ejemplo, no pongo nada en el nombre y si pongo en el handicap, me devuelve true
	//al devolver true continua la busqueda mirando otro atributo
	//todo esto se deberÃ­a observar en los metodos desarrollados en la clase Participante del proyecto dominio
	
}

