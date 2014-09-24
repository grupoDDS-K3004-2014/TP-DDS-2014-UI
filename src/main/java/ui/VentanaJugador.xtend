package ui

import domain.Participante
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import java.awt.Color

class VentanaJugador extends Dialog<Participante> {

	@Property Participante jugador

	new(WindowOwner parent, Participante model) {
		super(parent, model)

	}

	override protected createFormPanel(Panel mainPanel) {
		title = "Datos Jugador"
		val panelJugador = new Panel(mainPanel)
		panelJugador.setLayout(new ColumnLayout(2))
		new Label(panelJugador).setText("Nombre:")
		var a = new TextBox(panelJugador)
		a.setWidth(145).bindValueToProperty("nombre")
		new Label(panelJugador).setText("Apodo:")
		var b = new TextBox(panelJugador)
		b.setWidth(145).bindValueToProperty("apodo")
		new Label(panelJugador).setText("Handicap:")
		var c = new TextBox(panelJugador)
		c.setWidth(145).bindValueToProperty("handicap")
		
		new Label(panelJugador).setText("Promedio Ultimo Partido:")
		val criterioUltimoPartido = new CriterioUltimoPartido
		criterioUltimoPartido.determinarPuntajeCriterio(jugador)
		jugador.ultimaNota
		new TextBox(panelJugador).setWidth(145).bindValueToProperty("ultimoPuntaje")

		new Label(panelJugador).setText("Promedio Todos Partidos:")
		val criterioNCalificaciones = new CriterioNCalificaciones
		criterioNCalificaciones.determinarPuntajeCriterio(jugador)
		jugador.calcularPromedio
		new TextBox(panelJugador).setWidth(145).bindValueToProperty("promedio")

		new Label(panelJugador).setText("Fecha Nacimiento:")
		new TextBox(panelJugador).setWidth(145).bindValueToProperty("fechaNacimiento")

		new Label(panelJugador).setText("Amigos:")
		var tablaAmigos = new Table<Participante>(panelJugador, typeof(Participante))
		tablaAmigos.bindItemsToProperty("amigos")
		new Column<Participante>(tablaAmigos).setTitle("Nombre").bindContentsToProperty("nombre")

	}

	def String fixDateFormat(int fecha) {
		((fecha / 1000000).toString) + "/" + (((fecha) / 10000) % 100).toString + "/" + (fecha % 10000).toString
	}

	def String fixTimeFormat(int horario) {
		return ((horario / 100).toString) + ":" + ((horario % 100).toString)
	}

	def armarTablaEquipos2(String tituloTabla, String bindeableProperty, Panel panelArmado, int height) {
		new Label(panelArmado).setText(tituloTabla)
		var tablaParticipantes = new Table<Participante>(panelArmado, typeof(Participante))
		tablaParticipantes.bindItemsToProperty(bindeableProperty)		
		tablaParticipantes.setHeigth(height)
		new Column<Participante>(tablaParticipantes).setTitle("Nombre").bindContentsToProperty("nombre").
			bindBackground("handicap", [Integer handicap|if(handicap > 10) Color::BLUE else Color::WHITE])

	}

}
