package runnableApplication

import org.uqbar.arena.Application
import ui.VentanaPrincipal
import persistencia.SessionManager

class ArenaApplication extends Application {

	def static void main(String[] args) {
		
		SessionManager::startApplication
		new ArenaApplication().start()
	}

	override protected createMainWindow() {
		return new VentanaPrincipal(this)
	}

}
