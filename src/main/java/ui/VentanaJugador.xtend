package ui

import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.TextBox
import domain.Participante
import org.uqbar.arena.layout.ColumnLayout

class VentanaJugador extends Dialog<Participante> {

	new(WindowOwner parent, Participante model) {
		super(parent, model)

	}

	override protected createFormPanel(Panel mainPanel) {
		title = "Datos Jugador"
		val panelJugador = new Panel(mainPanel)
		panelJugador.setLayout(new ColumnLayout(2))
		new Label(panelJugador).setText("Nombre:")
		new TextBox(panelJugador).setWidth(145).bindValueToProperty("nombre")
		new Label(panelJugador).setText("Handicap:")
		new TextBox(panelJugador).setWidth(145).bindValueToProperty("handicap")
		new Label(panelJugador).setText("Apodo:")
		new TextBox(panelJugador).setWidth(145).bindValueToProperty("apodo")
	}

}
