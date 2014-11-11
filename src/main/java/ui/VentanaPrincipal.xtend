package ui

import applicationModel.BuscardorDeJugadoresApplicationModel
import applicationModel.OTFApplicationModel
import domain.partido.Partido
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
		new Label(mainPanel).setText("Listado de Partidos").setFontSize(15)

		val panelPrincipal = new Panel(mainPanel)
		panelPrincipal.setLayout(new ColumnLayout(2))
		val panelGrilla = new Panel(panelPrincipal)
		val panelBotonesPartidos = new Panel(panelPrincipal)

		crearTabla(panelGrilla)

		var generarEquipos = new Button(panelBotonesPartidos).setCaption("Generar Equipos").onClick([|generarEquipos])
		var confirmarEquipos = new Button(panelBotonesPartidos).setCaption("Confirmar/Desconfirmar partido").
			onClick([|modelObject.confirmarDesconfirmarPartido])

		new Button(panelBotonesPartidos).setCaption("Buscar Jugador").onClick([|buscarJugador])

		// Destilda los botones si no esta marcado un partido
		var equipoSelec = new NotNullObservable("partidoSeleccionado")
		generarEquipos.bindEnabled(equipoSelec)
		confirmarEquipos.bindEnabled(equipoSelec)

	}

	def crearTabla(Panel panelGrilla) {

		var tablaPartidos = new Table<Partido>(panelGrilla, typeof(Partido))
		tablaPartidos.bindItemsToProperty("partidos")
		tablaPartidos.bindValueToProperty("partidoSeleccionado")

		new Column<Partido>(tablaPartidos).setTitle("Nombre").bindContentsToProperty("nombreDelPartido").
			setFixedSize(160)

		new Column<Partido>(tablaPartidos).setTitle("Veces por mes").bindContentsToProperty("periodicidad").
			setFixedSize(90)

		new Column<Partido>(tablaPartidos).setTitle("Proxima fecha").bindContentsToTransformer(
			[partido|partido.fecha]).setFixedSize(100)

		new Column<Partido>(tablaPartidos).setTitle("Horario").bindContentsToTransformer(
			[partido|modelObject.fixTimeFormat(partido.getHorario())]).setFixedSize(70)

		new Column<Partido>(tablaPartidos).setTitle("Día").bindContentsToTransformer(
			[partido|partido.getDia]).setFixedSize(70)

		new Column<Partido>(tablaPartidos).setTitle("Cantidad de jugadores").
			bindContentsToTransformer([partido|partido.cantidadParticipantes]).setFixedSize(140)

		new Column<Partido>(tablaPartidos).setTitle("Equipo ya armado").
			bindContentsToTransformer([partido|if(partido.equipoB.size != 5) "No" else "Si"]).setFixedSize(120)

		new Column<Partido>(tablaPartidos).setTitle("Confirmado").bindContentsToProperty("confirmado").setFixedSize(80)

	}

	def buscarJugador() {

		this.openDialog(new BuscadorDeJugadoresWindow(this, new BuscardorDeJugadoresApplicationModel))
	}

	def generarEquipos() {
		modelObject.validateGenerarEquipos
		this.openDialog(new GenerarEquipoVentana(this, modelObject.partidoSeleccionado))
		modelObject.refresh
	}

	def openDialog(Dialog<?> dialog) {
		dialog.onAccept[|modelObject.refresh]
		dialog.open

	}

}
