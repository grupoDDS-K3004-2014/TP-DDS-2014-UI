package ui

import applicationModel.GenerarEquiposApplicationModel
import domain.Participante
import domain.Partido
import org.uqbar.arena.layout.ColumnLayout
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
import org.uqbar.arena.layout.VerticalLayout

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

		var panelArriba = new Panel(mainPanel)
		var panelAbajo = new Panel(mainPanel)

		panelArriba.setLayout(new ColumnLayout(2))
		panelAbajo.setLayout(new ColumnLayout(2))

		var panelTabla = new Panel(panelArriba)
		var panelBotones = new Panel(panelArriba)

		//Creo tabla de participantes anotados
		new Label(panelTabla).setText("Jugadores Anotados")
		var tablaParticipantes = new Table<Participante>(panelTabla, typeof(Participante))

		tablaParticipantes.bindItemsToProperty("modeloPartido.participantes")
		new Column<Participante>(tablaParticipantes).setTitle("Nombre").bindContentsToProperty("nombre")

		panelTabla = new Panel(panelArriba)

		//Tabla de participantes ya ordenados
		new Label(panelTabla).setText("Ordenamiento Tentativo")
		var tablaParticipantesOrdenTentativo = new Table<Participante>(panelTabla, typeof(Participante))
		tablaParticipantesOrdenTentativo.setHeigth(200)
		tablaParticipantesOrdenTentativo.bindItemsToProperty("modeloPartido.jugadoresOrdenados")

		new Column<Participante>(tablaParticipantesOrdenTentativo).setTitle("Nombre").bindContentsToProperty("nombre")


		new Label(panelAbajo).setText("EquipoA")
		new Label(panelAbajo).setText("EquipoB")
		var tablaEquipoA = new Table<Participante>(panelAbajo, typeof(Participante))
		tablaEquipoA.bindItemsToProperty("modeloPartido.equipoA")
		new Column<Participante>(tablaEquipoA).setTitle("Nombre").bindContentsToProperty("nombre")

		var tablaEquipoB = new Table<Participante>(panelAbajo, typeof(Participante))
		tablaEquipoB.bindItemsToProperty("modeloPartido.equipoA")
		new Column<Participante>(tablaEquipoB).setTitle("Nombre").bindContentsToProperty("nombre")

		// Creo criterios de ordenamiento
		var panelTexto = new Panel(panelBotones)
		new Panel(panelBotones)
		var panelInput = new Panel(panelBotones)
		var panelBoton = new Panel(panelBotones)
		panelInput.setLayout(new ColumnLayout(3))


		new Label(panelTexto).setText("Criterios de ordenamiento")

		new Label(panelInput).setText("Handicap")
		new Label(panelInput)
		new CheckBox(panelInput).bindValueToProperty("criterioHandicapValidator")

		new Label(panelInput).setText("Ultimo partido")
		new Label(panelInput)
		new CheckBox(panelInput).bindValueToProperty("criterioUltimoPartidoValidator")

		new Label(panelInput).setText("Ultimos N partido")
		new TextBox(panelInput).bindValueToProperty("cantidadPartidos")
		new CheckBox(panelInput).bindValueToProperty("criterioUltimosNPartidosValidator")

		new Button(panelBoton).setCaption("Ordenar jugadores").onClick([|modelObject.ordenarJugadores])

		new Panel(panelBotones)
		new Panel(panelBotones)
		new Panel(panelBotones)
		new Panel(panelBotones)
		new Panel(panelBotones)
		new Panel(panelBotones)
		new Panel(panelBotones)
		new Panel(panelBotones)
		new Panel(panelBotones)
		new Panel(panelBotones)
		new Panel(panelBotones)
		new Panel(panelBotones)
		new Panel(panelBotones)
		new Panel(panelBotones)
		new Panel(panelBotones)
		new Panel(panelBotones)
		new Panel(panelBotones)
		new Panel(panelBotones)

		
		panelTexto = new Panel(panelBotones)
		new Panel(panelBotones)
		panelInput = new Panel(panelBotones)
		panelBoton = new Panel(panelBotones)
		panelInput.setLayout(new ColumnLayout(3))

		new Label(panelTexto).setText("Criterios de seleccion")

	
		new Label(panelInput).setText("Por paridad para EquipoA")
		new CheckBox(panelInput).bindValueToProperty("parImparValidator")
		var selectorParImpar = new Selector(panelInput)
		selectorParImpar.bindItemsToProperty("selectorOpcion")
		selectorParImpar.bindValueToProperty("opcionSeleccionada")
		selectorParImpar.bindVisibleToProperty("parImparValidator")

		new Label(panelInput).setText("Posicion personalizada EquipoA")
		new CheckBox(panelInput).bindValueToProperty("posicionCustom")
		var arrayCustom = new TextBox(panelInput)
		arrayCustom.bindEnabledToProperty("posicionCustom")
		arrayCustom.bindValueToProperty("arrayCustom")

		new Button(panelBoton).setCaption("Generar equipos").onClick(
			[|modelObject.generarEquipos])

	}

	override protected void addActions(Panel actions) {
		new Button(actions).setCaption("Aceptar").onClick[|this.accept].setAsDefault.disableOnError

		new Button(actions).setCaption("Cancelar").onClick [ |
			modelObject.copiarValoresDe(partidoClon)
			this.cancel
		]
	}
	
	def void mostrarJugador() {

		this.openDialog(new ventanaJugador(this, modelObject.jugadorSeleccionado))
	}

	def openDialog(Dialog<?> dialog) {
		dialog.open
	}
	
	}


