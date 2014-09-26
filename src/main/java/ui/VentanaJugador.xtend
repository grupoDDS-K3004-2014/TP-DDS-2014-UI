package ui

import domain.jugadores.Participante
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import java.awt.Color
import domain.infracciones.Infraccion
import domain.calificaciones.Calificacion

class VentanaJugador extends Dialog<Participante> {

	new(WindowOwner parent, Participante model) {
		super(parent, model)

	}

	override protected createFormPanel(Panel mainPanel) {
		title = "Datos del jugador"

		new Label(mainPanel).setText(modelObject.nombre + " alias: " + modelObject.apodo).setFontSize(15)
		new Label(mainPanel)
		new Label(mainPanel)
		new Label(mainPanel).setText("Handicap: " + modelObject.handicap).setFontSize(11)
		new Label(mainPanel).setText("Fecha Nacimiento: " + modelObject.fechaNacimiento).setFontSize(11)
		new Label(mainPanel).setText("Promedio del ultimo partido: " + modelObject.ultimaNota).setFontSize(11)
		new Label(mainPanel).setText("Promedio general: " + modelObject.ultimasNotas(modelObject.calificaciones.size)).
			setFontSize(12)

		new Label(mainPanel)
		new Label(mainPanel).setText("Amigos")
		var tablaAmigos = new Table<Participante>(mainPanel, typeof(Participante))
		tablaAmigos.bindItemsToProperty("amigos")
		new Column<Participante>(tablaAmigos).setTitle("Nombre").bindContentsToProperty("nombre").
			bindBackground("handicap", [Integer handicap|if(handicap > 10) Color::cyan else Color::WHITE]).
			setFixedSize(80)

		new Label(mainPanel)
		new Label(mainPanel).setText("Infracciones")
		var tablaInfracciones = new Table<Infraccion>(mainPanel, typeof(Infraccion))
		tablaInfracciones.bindItemsToProperty("infracciones")
		new Column<Infraccion>(tablaInfracciones).setTitle("Fecha").bindContentsToProperty("fecha").setFixedSize(80)
		new Column<Infraccion>(tablaInfracciones).setTitle("Motivo").bindContentsToProperty("motivo").setFixedSize(100)

		new Label(mainPanel)
		new Label(mainPanel).setText("Calificaciones")
		var tablaCalificaciones = new Table<Calificacion>(mainPanel, typeof(Calificacion))
		tablaCalificaciones.bindItemsToProperty("calificaciones")
		new Column<Calificacion>(tablaCalificaciones).setTitle("Fecha").bindContentsToProperty("fecha").setFixedSize(80)
		new Column<Calificacion>(tablaCalificaciones).setTitle("Nota").bindContentsToProperty("nota").setFixedSize(50)
		new Column<Calificacion>(tablaCalificaciones).setTitle("Descripcion").bindContentsToProperty("descripcion").
			setFixedSize(100)

	}

}
