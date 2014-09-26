package runnableApplication

import org.uqbar.arena.Application
import ui.VentanaPrincipal
import org.uqbar.commons.utils.ApplicationContext
import home.HomeJugadores
import domain.jugadores.Participante
import domain.partido.Partido
import home.HomePartidos

class ArenaApplication extends Application {

	def static void main(String[] args) {
		
		ApplicationContext.instance.configureSingleton(typeof(Partido), new HomePartidos)		
		ApplicationContext.instance.configureSingleton(typeof(Participante), new HomeJugadores)
		new ArenaApplication().start()
	}

	override protected createMainWindow() {
		return new VentanaPrincipal(this)
	}

}
