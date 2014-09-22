package runnableApplication

import org.uqbar.arena.Application
import org.uqbar.arena.windows.Window
import org.uqbar.commons.utils.ApplicationContext
import domain.Participante
import applicationModel.BuscardorDeJugadoresApplicationModel
import ui.BuscadorDeJugadoresWindow
import home.HomeJugadores

class FutbolCinco extends Application {
	
	static def void main(String[] args) {
		new FutbolCinco().start()
	}
	
	
	override protected Window<?> createMainWindow() {
		ApplicationContext.instance.configureSingleton(typeof(Participante),new HomeJugadores)
		return new BuscadorDeJugadoresWindow(this,new BuscardorDeJugadoresApplicationModel)
	}
	
}