package ui

import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.TextBox
import domain.Participante
import domain.CriterioNCalificaciones
import domain.CriterioUltimoPartido
import domain.Infraccion
import org.uqbar.arena.layout.ColumnLayout

class VentanaJugador extends Dialog<Participante> {
	
	@Property Participante jugador
	

	new(WindowOwner parent, Participante model) {
		super(parent, model)
		jugador=model

	}

	override protected createFormPanel(Panel mainPanel) {
		title = "Datos Jugador"
		val panelJugador = new Panel(mainPanel)
		panelJugador.setLayout(new ColumnLayout(2))
		new Label(panelJugador).setText("Nombre:")
		new TextBox(panelJugador).setWidth(145).bindValueToProperty("nombre")
		new Label(panelJugador).setText("Apodo:")
		new TextBox(panelJugador).setWidth(145).bindValueToProperty("apodo")
		new Label(panelJugador).setText("Handicap:")
		new TextBox(panelJugador).setWidth(145).bindValueToProperty("handicap")
		new Label(panelJugador).setText("Promedio Ultimo Partido:")
		val criterioUltimoPartido=new CriterioUltimoPartido
		criterioUltimoPartido.determinarPuntajeCriterio(jugador)
		new TextBox(panelJugador).setWidth(145).bindValueToProperty("jugador.puntajesCriterio.get(0)")
		new Label(panelJugador).setText("Promedio Todos Partidos:")
		val criterioNCalificaciones=new CriterioNCalificaciones
		criterioNCalificaciones.determinarPuntajeCriterio(jugador)
		new TextBox(panelJugador).setWidth(145).bindValueToProperty("jugador.puntajesCriterio.get(1)")
		new Label(panelJugador).setText("Fecha Nacimiento:")
		new TextBox(panelJugador).setWidth(145).bindValueToProperty("fechaNacimiento")
		//amigos reutilizar grilla de busqueda jugadores
		
		val grillaInfracciones = new Panel(panelJugador)
		new Label(grillaInfracciones).setText("Infracciones Jugador").setFontSize(15)

		var tablaInfracciones = new Table<Infraccion>(grillaInfracciones, typeof(Infraccion))
		new Column<Infraccion>(tablaInfracciones).setTitle("Fecha").bindContentsToTransformer(
			[infraccion|this.fixDateFormat(infraccion.getFecha())]).setFixedSize(100)
			
		new Column<Infraccion>(tablaInfracciones).setTitle("Hora").bindContentsToTransformer(
			[infraccion|this.fixTimeFormat(infraccion.getFecha())]).setFixedSize(100)

		
		}
	


def String fixDateFormat(int fecha) {
		((fecha / 1000000).toString) + "/" + (((fecha) / 10000) % 100).toString + "/" + (fecha % 10000).toString
	}

def String fixTimeFormat(int horario) {
		return ((horario / 100).toString) + ":" + ((horario % 100).toString)
	}
	
}
