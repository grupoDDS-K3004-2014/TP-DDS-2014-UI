package ui

import applicationModel.OTFApplicationModel
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.tables.Table
import domain.Partido
import org.uqbar.arena.widgets.tables.Column

import org.uqbar.arena.widgets.Label
import domain.Dia

import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.windows.Dialog
import domain.Sistema

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
			[partido|fixDateFormat(partido.getFecha())]).setFixedSize(100)
		new Column<Partido>(tablaPartidos).setTitle("Horario").bindContentsToTransformer(
			[partido|fixTimeFormat(partido.getHorario())]).setFixedSize(70)
		new Column<Partido>(tablaPartidos).setTitle("Día").bindContentsToTransformer(
			[partido|fixDiaFormat(partido.getDia)]).setFixedSize(80)
		new Column<Partido>(tablaPartidos).setTitle("Cantidad Inscriptos").
			bindContentsToTransformer([partido|(partido.cantidadInscriptos).toString]).setFixedSize(120)
		new Column<Partido>(tablaPartidos).setTitle("Equipo ya armado").
			bindContentsToTransformer([partido|if(partido.noOrganizado) "No" else "Si"]).setFixedSize(120)
		new Column<Partido>(tablaPartidos).setTitle("Confirmado").bindContentsToProperty("confirmado").setFixedSize(80)

		var generarEquipos = new Button(panelBotonesPartidos).setCaption("Generar Equipos").onClick([|generarEquipos])
		var confirmarEquipos = new Button(panelBotonesPartidos).setCaption("Confirmar/Desconfirmar partido").
			onClick([|confirmarPartido])

		// Destilda los botones si no esta marcado un partido
		var equipoSelec = new NotNullObservable("partidoSeleccionado")
		generarEquipos.bindEnabled(equipoSelec)
		confirmarEquipos.bindEnabled(equipoSelec)

	//val panelJugadores = new Panel(mainPanel)		
	}

	def confirmarPartido() {

		modelObject.validarConfirmacionPartido()

	}

	def generarEquipos() {

		this.openDialog(new GenerarEquipoVentana(this, modelObject.partidoSeleccionado))

	}

	def openDialog(Dialog<?> dialog) {
		dialog.onAccept[|modelObject.refresh]
		dialog.open
	}

	def String fixDateFormat(int fecha) {
		((fecha / 1000000).toString) + "/" + (((fecha) / 10000) % 100).toString + "/" + (fecha % 10000).toString
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