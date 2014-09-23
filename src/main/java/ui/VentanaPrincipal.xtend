package ui

import applicationModel.OTFApplicationModel
import domain.Partido
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

class VentanaPrincipal extends SimpleWindow<OTFApplicationModel> {

	new(WindowOwner parent) {
		super(parent, new OTFApplicationModel)

	}

	override protected addActions(Panel actionsPanel) {
	}

	override protected createFormPanel(Panel mainPanel) {

		title = "Organizador de partidos de Futbol 5"
		val panelPartidos = new Panel(mainPanel)
		panelPartidos.setLayout(new ColumnLayout(2))
		val panelGrilla = new Panel(panelPartidos)
		val panelBotonesPartidos = new Panel(panelPartidos)
		new Label(panelGrilla).setText("Listado de Partidos").setFontSize(15)

		var tablaPartidos = new Table<Partido>(panelGrilla, typeof(Partido))
		tablaPartidos.bindItemsToProperty("partidos")
		tablaPartidos.bindValueToProperty("partidoSeleccionado")
		new Column<Partido>(tablaPartidos).setTitle("Nombre").bindContentsToProperty("nombreDelPartido").
			setFixedSize(160)

		new Column<Partido>(tablaPartidos).setTitle("Veces por mes").bindContentsToProperty("periodicidad").
			setFixedSize(90)

		new Column<Partido>(tablaPartidos).setTitle("Proxima fecha").bindContentsToTransformer(
			[partido|modelObject.fixDateFormat(partido.getFecha())]).setFixedSize(100)

		new Column<Partido>(tablaPartidos).setTitle("Horario").bindContentsToTransformer(
			[partido|modelObject.fixTimeFormat(partido.getHorario())]).setFixedSize(70)

		new Column<Partido>(tablaPartidos).setTitle("Día").bindContentsToTransformer(
			[partido|modelObject.fixDiaFormat(partido.getDia)]).setFixedSize(80)
		new Column<Partido>(tablaPartidos).setTitle("Cantidad Inscriptos").
			bindContentsToTransformer([partido|(partido.cantidadInscriptos).toString]).setFixedSize(120)

		new Column<Partido>(tablaPartidos).setTitle("Equipo ya armado").
			bindContentsToTransformer([partido|if(partido.equipoA.size != 5) "No" else "Si"]).setFixedSize(120)

		new Column<Partido>(tablaPartidos).setTitle("Confirmado").bindContentsToTransformer([partido|partido.confirmado]).
			setFixedSize(80)

		var generarEquipos = new Button(panelBotonesPartidos).setCaption("Generar Equipos").onClick([|generarEquipos])
		var confirmarEquipos = new Button(panelBotonesPartidos).setCaption("Confirmar/Desconfirmar partido").
			onClick([|confirmarPartido])

		// Destilda los botones si no esta marcado un partido
		var equipoSelec = new NotNullObservable("partidoSeleccionado")
		generarEquipos.bindEnabled(equipoSelec)
		confirmarEquipos.bindEnabled(equipoSelec)

	}

	def confirmarPartido() {

		modelObject.confirmarPartido()

	}

	def generarEquipos() {
		modelObject.validateGenerarEquipos
		var aux = modelObject.partidoSeleccionado
		this.openDialog(new GenerarEquipoVentana(this, modelObject.partidoSeleccionado))
		modelObject.partidoSeleccionado = aux
	}

	def openDialog(Dialog<?> dialog) {
		dialog.onAccept[|modelObject.refresh]
		dialog.open
	}

}
