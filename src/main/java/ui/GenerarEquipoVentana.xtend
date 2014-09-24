package ui

import applicationModel.GenerarEquiposApplicationModel
import domain.Participante
import domain.Partido
import java.util.ArrayList
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.CheckBox
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner

class GenerarEquipoVentana extends Dialog<GenerarEquiposApplicationModel> {

	Partido partidoClon

	new(WindowOwner owner, Partido partido) {
		super(owner, new GenerarEquiposApplicationModel(partido))
		partidoClon = partido.clone as Partido
	}

	override protected createFormPanel(Panel mainPanel) {

		title = "Generar equipos"
		mainPanel.setLayout(new VerticalLayout)
		new Label(mainPanel).setText(modelObject.modeloPartido.nombreDelPartido).setFontSize(15)

		//Primer panel
		var panel1Horizontal = new Panel(mainPanel)
		var panel2Horizontal = new Panel(mainPanel)

		panel1Horizontal.setLayout(new ColumnLayout(2))

		var panelJugadores = new Panel(panel1Horizontal)
		var panelJugadoresOrdenados = new Panel(panel1Horizontal)

		panelJugadores.setLayout(new ColumnLayout(2))
		panelJugadoresOrdenados.setLayout(new ColumnLayout(2))

		armarTablaEquipos("Jugadores anotados", "modeloPartido.participantes",
			new Panel(panelJugadores).setWidth(100), 200)
		armarBotoneraOrdenamiento(new Panel(panelJugadores)).setWidth(100)

		//Segundo panel
		//panelAuxiliarHorizontal = new Panel(mainPanel)
		//panelAuxiliarHorizontal.setLayout(new ColumnLayout(2))
		armarTablaEquipos("Orden tentativo", "modeloPartido.jugadoresOrdenados",
			new Panel(panelJugadoresOrdenados).setWidth(100), 200)
		armarBotoneraSeleccion(new Panel(panelJugadoresOrdenados)).setWidth(100)

		//Tercer panel
		panel2Horizontal.setLayout(new ColumnLayout(2))

		armarTablaEquipos2("Equipo A", "modeloPartido.equipoA", new Panel(panel2Horizontal).setWidth(100), 110)
		armarTablaEquipos2("Equipo B", "modeloPartido.equipoB", new Panel(panel2Horizontal).setWidth(100), 110)

	}

	def armarBotoneraSeleccion(Panel panelArmado) {

		var panelTexto = new Panel(panelArmado)
		var panelcheckBoxes = new Panel(panelArmado)
		var panelInput = new Panel(panelArmado)
		var panelBoton = new Panel(panelArmado)
		panelcheckBoxes.setLayout(new ColumnLayout(3))
		panelInput.setLayout(new ColumnLayout((5)))

		new Label(panelTexto).setText("Criterios de seleccion")
		new Label(panelcheckBoxes).setText("Por paridad para EquipoA")
		new CheckBox(panelcheckBoxes).bindValueToProperty("parImparValidator")

		var selectorParImpar = new Selector(panelcheckBoxes)
		selectorParImpar.bindItemsToProperty("selectorOpcion")
		selectorParImpar.bindValueToProperty("opcionSeleccionada")
		selectorParImpar.bindVisibleToProperty("parImparValidator")
		new Label(panelcheckBoxes).setText("Posicion personalizada EquipoA")
		new CheckBox(panelcheckBoxes).bindValueToProperty("posicionCustom")

		var selectorInput = new Selector(panelInput)
		selectorInput.bindItemsToProperty("listaDePosiciones")
		selectorInput.bindValueToProperty("primerJugador")
		selectorInput.bindVisibleToProperty("posicionCustom")

		selectorInput = new Selector(panelInput)
		selectorInput.bindItemsToProperty("listaDePosiciones")
		selectorInput.bindValueToProperty("segundoJugador")
		selectorInput.bindVisibleToProperty("posicionCustom")

		selectorInput = new Selector(panelInput)
		selectorInput.bindItemsToProperty("listaDePosiciones")
		selectorInput.bindValueToProperty("tercerJugador")
		selectorInput.bindVisibleToProperty("posicionCustom")

		selectorInput = new Selector(panelInput)
		selectorInput.bindItemsToProperty("listaDePosiciones")
		selectorInput.bindValueToProperty("cuartoJugador")
		selectorInput.bindVisibleToProperty("posicionCustom")

		selectorInput = new Selector(panelInput)
		selectorInput.bindItemsToProperty("listaDePosiciones")
		selectorInput.bindValueToProperty("quintoJugador")
		selectorInput.bindVisibleToProperty("posicionCustom")

		new Button(panelBoton).setCaption("Generar equipos").onClick([|modelObject.generarEquipos])

	}

	def armarBotoneraOrdenamiento(Panel panelArmado) {

		var panelTexto = new Panel(panelArmado)
		var panelcheckBoxes = new Panel(panelArmado)
		var panelBoton = new Panel(panelArmado)
		panelcheckBoxes.setLayout(new ColumnLayout(3))

		new Label(panelTexto).setText("Criterios de ordenamiento")
		new Label(panelcheckBoxes).setText("Handicap")
		new Label(panelcheckBoxes)
		new CheckBox(panelcheckBoxes).bindValueToProperty("criterioHandicapValidator")
		new Label(panelcheckBoxes).setText("Ultimo partido")
		new Label(panelcheckBoxes)
		new CheckBox(panelcheckBoxes).bindValueToProperty("criterioUltimoPartidoValidator")
		new Label(panelcheckBoxes).setText("Ultimos N partido")
		new TextBox(panelcheckBoxes).bindValueToProperty("cantidadPartidos")
		new CheckBox(panelcheckBoxes).bindValueToProperty("criterioUltimosNPartidosValidator")
		new Button(panelBoton).setCaption("Ordenar jugadores").onClick([|modelObject.ordenarJugadores])

	}

	def armarTablaEquipos(String tituloTabla, String bindeableProperty, Panel panelArmado, int height) {

		//Creo la tabla
		new Label(panelArmado).setText(tituloTabla)
		var tablaParticipantes = new Table<Participante>(panelArmado, typeof(Participante))
		tablaParticipantes.bindItemsToProperty(bindeableProperty)
		tablaParticipantes.setHeigth(height)
		new Column<Participante>(tablaParticipantes).setTitle("Nombre").bindContentsToProperty("nombre")

	}

	def tieneHandicapAlto(Participante participante) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	def armarTablaEquipos2(String tituloTabla, String bindeableProperty, Panel panelArmado, int height) {
		new Label(panelArmado).setText(tituloTabla)
		var tablaParticipantes = new Table<Participante>(panelArmado, typeof(Participante))
		tablaParticipantes.bindItemsToProperty(bindeableProperty)
		tablaParticipantes.bindValueToProperty("jugadorSeleccionado")
		tablaParticipantes.setHeigth(height)
		new Column<Participante>(tablaParticipantes).setTitle("Nombre").bindContentsToProperty("nombre")

	}

	override protected void addActions(Panel actions) {
		new Button(actions).setCaption("Aceptar").onClick[|this.accept].setAsDefault.disableOnError

		new Button(actions).setCaption("Cancelar").onClick [ |
			modelObject.copiarValoresDe(partidoClon)
			modelObject.modeloPartido.jugadoresOrdenados = new ArrayList<Participante>
			this.cancel
		]
		new Button(actions).setCaption("Inspeccionar jugador").onClick[|this.mostrarJugador].setAsDefault.disableOnError
	}

	def void mostrarJugador() {

		modelObject.validarJugadorSeleccionado
		this.openDialog(new VentanaJugador(this, modelObject.jugadorSeleccionado))
	}

	def openDialog(Dialog<?> dialog) {
		dialog.open
	}

}
