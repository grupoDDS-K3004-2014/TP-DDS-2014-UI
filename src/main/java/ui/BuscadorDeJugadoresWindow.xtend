package ui

import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.TextBox
import domain.Participante
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.CheckBox
import applicationModel.BuscardorDeJugadores
import java.awt.Color

class BuscadorDeJugadoresWindow extends SimpleWindow<BuscardorDeJugadores> {
	
	new(WindowOwner parent, BuscardorDeJugadores model) {
		super(parent, model)
		// se dispara la busqueda aca, aunque esto habria que revisarlo, 
		//es una posibilidad segun el tutorial de arena que la busqueda se dispare aca
		modelObject.search()
	}
	
	
	override def createMainTemplate(Panel mainPanel) {
		title = "Buscador de Jugadores"
		taskDescription = "Ingrese la  busqueda"

		super.createMainTemplate(mainPanel)

		this.createResultsGrid(mainPanel)
	}
	
	override protected createFormPanel(Panel mainPanel) {
		
		// panel de busqueda que permite buscar por nombre y apodo por ahora 
		
		var searchFormPanel = new Panel(mainPanel)
		searchFormPanel.setLayout(new ColumnLayout(2))
		
        var labelNombre = new Label(searchFormPanel)
		labelNombre.text = "Nombre Del Jugador"

		new TextBox(searchFormPanel).bindValueToProperty("nombre")

		var labelApodo = new Label(searchFormPanel)
		labelApodo.text = "Apodo"

		new TextBox(searchFormPanel).bindValueToProperty("apodo")
		
       // var labelFecha = new Label(searchFormPanel)
		//labelFecha.text = "fecha de nacimiento anterior a : "

		//new TextBox(searchFormPanel).bindValueToProperty("fechaNacimientoAnterior")
		
        var labelHandicapInicial = new Label(searchFormPanel)
		labelHandicapInicial.text = "handicap desde : "

		new TextBox(searchFormPanel).bindValueToProperty("handicapInicial")
		
		var labelHandicapFinal = new Label(searchFormPanel)
		labelHandicapFinal.text = "handicap hasta : "

		new TextBox(searchFormPanel).bindValueToProperty("handicapFinal")
		
		 var labelPromedioInicial = new Label(searchFormPanel)
		labelPromedioInicial.text = "promedio desde : "

		new TextBox(searchFormPanel).bindValueToProperty("promedioDesde")
		
		var labelPromedioFinal = new Label(searchFormPanel)
		labelPromedioFinal.text = "promedio hasta : "

		new TextBox(searchFormPanel).bindValueToProperty("promedioHasta")
		
		new Label(searchFormPanel).setText("tiene infraccion")
		new CheckBox(searchFormPanel).bindValueToProperty("tieneInfraccion")
		
		new Label(searchFormPanel).setText("no tiene infraccion")
		new CheckBox(searchFormPanel).bindValueToProperty("noTieneInfraccion")
		
		
		
		}
	
	override protected addActions(Panel actionsPanel) {
		new Button(actionsPanel)
			.setCaption("Buscar")
			.onClick [ | modelObject.search ] 
			.setAsDefault
			.disableOnError

		new Button(actionsPanel) //
			.setCaption("Limpiar")
			.onClick [ | modelObject.clear ]
		
	}
	
	
	//creacion y contenido de la tabla
	
	def protected createResultsGrid(Panel mainPanel) {
		var table = new Table<Participante>(mainPanel, typeof(Participante))
		table.heigth = 250
		table.width = 600
		table.bindItemsToProperty("resultadoParticipantes")
		this.describeResultsGrid(table)

	}

	
	def void describeResultsGrid(Table<Participante> table) {
		new Column<Participante>(table) //
			.setTitle("Nombre")
			.setFixedSize(150)
			.bindContentsToProperty("nombre")

		var columnaHandicap = new Column<Participante>(table) //
			columnaHandicap.setTitle("handicap")
			columnaHandicap.setFixedSize(100)
			columnaHandicap.bindContentsToProperty("handicap")
			columnaHandicap.foreground = Color::BLUE

		new Column<Participante>(table)
			.setTitle("apodo")
			.setFixedSize(150)
			.bindContentsToProperty("apodo")

new Column<Participante>(table)
			.setTitle("fechaNacimiento")
			.setFixedSize(150)
			.bindContentsToProperty("fechaNacimiento")

	}
}