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

class GenerarEquipoVentana extends Dialog<GenerarEquiposApplicationModel> {

	Partido partidoClon

	new(WindowOwner owner, Partido partido) {
		super(owner, new GenerarEquiposApplicationModel(partido))
		partidoClon = partido.clone as Partido
	}

	override protected createFormPanel(Panel mainPanel) {
		
		title = "Generar equipos"

		new Label(mainPanel).setText(modelObject.modeloPartido.nombreDelPartido).setFontSize(15)

		var panelDos = new Panel(mainPanel)
		panelDos.setLayout(new ColumnLayout(2))
		var panelTablas = new Panel(panelDos)
		var panelCriterios = new Panel(panelDos)

		new Label(panelTablas).setText("Jugadores Anotados")
		var tablaParticipantes = new Table<Participante>(panelTablas, typeof(Participante))
		tablaParticipantes.bindItemsToProperty("modeloPartido.participantes")
		new Column<Participante>(tablaParticipantes).setTitle("Nombre").bindContentsToProperty("nombre").
			setFixedSize(120)
		
		new Label(panelTablas).setText("Ordenamiento Tentativo")
		var tablaParticipantesOrdenTentativo = new Table<Participante>(panelTablas, typeof(Participante))
		tablaParticipantesOrdenTentativo.setHeigth(120)
		tablaParticipantesOrdenTentativo.bindItemsToProperty("modeloPartido.jugadoresOrdenados")
		new Column<Participante>(tablaParticipantesOrdenTentativo).setTitle("Nombre").bindContentsToProperty("nombre").
			setFixedSize(120)
		tablaParticipantesOrdenTentativo.bindValueToProperty("jugadorSeleccionado")

		new Label(panelCriterios).setText("Criterios de Ordenamiento")

		var panelCriteriosCheckbox = new Panel(panelCriterios)
		panelCriteriosCheckbox.setLayout(new ColumnLayout(3))
		new Label(panelCriteriosCheckbox).setText("Handicap")
		new Label(panelCriteriosCheckbox)
		new CheckBox(panelCriteriosCheckbox).bindValueToProperty("criterioHandicapValidator")
		new Label(panelCriteriosCheckbox).setText("Ultimo partido")
		new Label(panelCriteriosCheckbox)
		new CheckBox(panelCriteriosCheckbox).bindValueToProperty("criterioUltimoPartidoValidator")
		new Label(panelCriteriosCheckbox).setText("Ultimos N partido")
		new TextBox(panelCriteriosCheckbox).bindValueToProperty("cantidadPartidos")
		new CheckBox(panelCriteriosCheckbox).bindValueToProperty("criterioUltimosNPartidosValidator")


		new Button(panelCriterios).setCaption("Ordenar jugadores").onClick([|modelObject.ordenarJugadores])
		new Button(panelCriterios).setCaption("Ver Jugador").onClick[|this.mostrarJugador]
		new Label(panelCriterios)
		new Label(panelCriterios)
		
		
		panelCriteriosCheckbox = new Panel(panelCriterios)
		panelCriteriosCheckbox.setLayout(new ColumnLayout(3))
		new Label(panelCriteriosCheckbox).setText("Por paridad para EquipoA")
		new CheckBox(panelCriteriosCheckbox).bindValueToProperty("parImparValidator")
		var selectorParImpar = new Selector(panelCriteriosCheckbox)
		selectorParImpar.bindItemsToProperty("selectorOpcion")	
		selectorParImpar.bindValueToProperty("opcionSeleccionada")	
		selectorParImpar.bindVisibleToProperty("parImparValidator")
		
		panelCriteriosCheckbox = new Panel(panelCriterios)
		panelCriteriosCheckbox.setLayout(new ColumnLayout(3))
		new Label(panelCriteriosCheckbox).setText("Posicion personalizada EquipoA")
		new CheckBox(panelCriteriosCheckbox).bindValueToProperty("posicionCustom")
		var arrayCustom = new TextBox(panelCriteriosCheckbox)
		arrayCustom.bindEnabledToProperty("posicionCustom")
		arrayCustom.bindValueToProperty("arrayCustom")
		
		new Button(panelCriterios).setCaption("Generar equipos").onClick([|modelObject.generarEquipos])
		
		
		
		
		
		

		var panelEquiposParaConfirmar = new Panel(mainPanel)
		panelEquiposParaConfirmar.setLayout(new ColumnLayout(2))

		var panelTabla = new Panel(panelEquiposParaConfirmar)
		new Label(panelTabla).setText("EquipoA")
		var tablaEquipoA = new Table<Participante>(panelTabla, typeof(Participante))
		tablaEquipoA.bindItemsToProperty("modeloPartido.equipoA")
		new Column<Participante>(tablaEquipoA).setTitle("Nombre").bindContentsToProperty("nombre").setFixedSize(120)

		panelTabla = new Panel(panelEquiposParaConfirmar)

		new Label(panelTabla).setText("EquipoB")
		var tablaEquipoB = new Table<Participante>(panelTabla, typeof(Participante))
		tablaEquipoB.bindItemsToProperty("modeloPartido.equipoA")
		new Column<Participante>(tablaEquipoB).setTitle("Nombre").bindContentsToProperty("nombre").setFixedSize(120)

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


