package ui

import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.CheckBox
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import applicationModel.BuscardorDeJugadoresApplicationModel
import java.awt.Color
import domain.jugadores.Participante

class BuscadorDeJugadoresWindow extends Dialog<BuscardorDeJugadoresApplicationModel> {

	new(WindowOwner parent, BuscardorDeJugadoresApplicationModel model) {
		super(parent, model)
		modelObject.searchAll()
	}

	override protected createFormPanel(Panel mainPanel) {
		title = "Organizador de partidos de Futbol 5"

		new Label(mainPanel).setText("Buscador de jugadores").setFontSize(15)

		var panelDeTablaYOpciones = new Panel(mainPanel).setLayout(new ColumnLayout(2))
		var panelTabla = new Panel(panelDeTablaYOpciones)
		var panelOpcionesDeBusqueda = new Panel(panelDeTablaYOpciones).setLayout(new ColumnLayout(4))

		lineaOpcionesDeBusquedaTextBox(panelOpcionesDeBusqueda, "Nombre del jugador", "nombre")
		lineaOpcionesDeBusquedaTextBox(panelOpcionesDeBusqueda, "Apodo", "apodo")
		lineaOpcionesDeBusquedaTextBox(panelOpcionesDeBusqueda, "Fecha de nacimiento anterior al año",
			"fechaNacimientoAnterior")
		inputHandicap(panelOpcionesDeBusqueda)
		inputNotaUltimoPartido(panelOpcionesDeBusqueda)
		lineaOpcionesDeBusquedaCheckBox(panelOpcionesDeBusqueda, "Tiene infraccion", "tieneInfraccion")
		armarTabla(panelTabla)

	}

	override protected addActions(Panel actionsPanel) {
		new Button(actionsPanel).setCaption("Buscar").onClick[|modelObject.search]

		new Button(actionsPanel).setCaption("Limpiar").onClick[|modelObject.clear]

		new Button(actionsPanel).setCaption("Inspeccionar jugador").onClick[|mostrarJugador]
	}

	def armarTabla(Panel mainPanel) {
		var table = new Table<Participante>(mainPanel, typeof(Participante))
		table.heigth = 250
		table.width = 600
		table.bindItemsToProperty("resultadoParticipantes")
		this.describeResultsGrid(table)

	}

	def lineaOpcionesDeBusquedaTextBox(Panel panel4, String nombreDelLabel, String bindeableProperty) {

		new Label(panel4).text = nombreDelLabel
		new TextBox(panel4).setWidth(40).bindValueToProperty(bindeableProperty)
		new Panel(panel4)
		new Panel(panel4)

	}

	def lineaOpcionesDeBusquedaCheckBox(Panel panel4, String nombreDelLabel, String bindeableProperty) {

		new Label(panel4).text = nombreDelLabel
		new CheckBox(panel4).bindValueToProperty(bindeableProperty)
		new Panel(panel4)
		new Panel(panel4)
	}

	def void describeResultsGrid(Table<Participante> table) {

		new Column<Participante>(table).setTitle("Nombre").setFixedSize(80).bindContentsToProperty("nombre").
			bindBackground("handicap", [Integer handicap|if(handicap > 10) Color::cyan else Color::WHITE])
		new Column<Participante>(table).setTitle("Apodo").setFixedSize(80).bindContentsToProperty("apodo")
		table.bindValueToProperty("jugadorSeleccionado")
		new Column<Participante>(table).setTitle("Handicap").setFixedSize(80).bindContentsToProperty("handicap")
		new Column<Participante>(table).setTitle("Promedio General ").setFixedSize(110).
			bindContentsToTransformer([participante|participante.ultimasNotas(participante.calificaciones.size)])
		new Column<Participante>(table).setTitle("Infracciones").setFixedSize(85).
			bindContentsToTransformer([participante|participante.infracciones.size])
		new Column<Participante>(table).setTitle("Calificaciones").setFixedSize(100).
			bindContentsToTransformer([participante|participante.calificaciones.size])
		new Column<Participante>(table).setTitle("Amigos").setFixedSize(70).
			bindContentsToTransformer([participante|participante.amigos.size])

	}

	def inputHandicap(Panel panel4) {

		new Label(panel4).setText("Handicap desde:")
		new TextBox(panel4).setWidth(15).bindValueToProperty("handicapInicial")
		new Label(panel4).setText("hasta")
		new TextBox(panel4).setWidth(15).bindValueToProperty("handicapFinal")
	}

	def inputNotaUltimoPartido(Panel panel4) {

		new Label(panel4).setText("Nota del ultimo partido desde")
		new TextBox(panel4).setWidth(15).bindValueToProperty("notaUltimoPartidoDesde")
		new Label(panel4).setText("hasta")
		new TextBox(panel4).setWidth(15).bindValueToProperty("notaUltimoPartidoHasta")
	}

	def void mostrarJugador() {
		modelObject.validarJugadorSeleccionado
		this.openDialog(new VentanaJugador(this, modelObject.jugadorSeleccionado))
	}

	def openDialog(Dialog<?> dialog) {
		dialog.open
	}

}
