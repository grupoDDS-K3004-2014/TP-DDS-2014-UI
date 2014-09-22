package ui

import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.TextBox
import java.awt.Color
import domain.Participante
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.Button
import applicationModel.BuscardorDeJugadoresApplicationModel

class BuscadorDeJugadoresWindow extends SimpleWindow<BuscardorDeJugadoresApplicationModel> {
	
	new(WindowOwner parent, BuscardorDeJugadoresApplicationModel model) {
		super(parent, model)
		// se dispara la busqueda aca, aunque esto habria que revisarlo, 
		//es una posibilidad segun el tutorial de arena que la busqueda se dispare aca
		modelObject.search()
	}
	
	
	override def createMainTemplate(Panel mainPanel) {
		title = "Buscador de Jugadores"
		taskDescription = "Ingrese la  búsqueda"

		super.createMainTemplate(mainPanel)

		this.createResultsGrid(mainPanel)
	}
	
	override protected createFormPanel(Panel mainPanel) {
		
		// panel de busqueda que permite buscar por nombre y apodo por ahora 
		
		var searchFormPanel = new Panel(mainPanel)
		searchFormPanel.setLayout(new ColumnLayout(2))
		
        var labelNumero = new Label(searchFormPanel)
		labelNumero.text = "Nombre Del Jugador"
		labelNumero.foreground = Color::BLUE

		new TextBox(searchFormPanel).bindValueToProperty("nombre")

		var labelNombre = new Label(searchFormPanel)
		labelNombre.text = "Apodo"
		labelNombre.foreground = Color::BLUE

		new TextBox(searchFormPanel).bindValueToProperty("apodo")

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

		new Column<Participante>(table) //
			.setTitle("apodo")
			.setFixedSize(100)
			.bindContentsToProperty("apodo")

		new Column<Participante>(table)
			.setTitle("handicap")
			.setFixedSize(150)
			.bindContentsToProperty("handicap")

new Column<Participante>(table)
			.setTitle("fechaNacimiento")
			.setFixedSize(150)
			.bindContentsToProperty("fechaNacimiento")

	}
}