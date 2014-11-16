package runnableApplication

import org.uqbar.arena.Application
import persistencia.SessionManager
import ui.VentanaPrincipal

class ArenaApplication extends Application {

	def static void main(String[] args) {

		SessionManager::startApplication
		new ArenaApplication().start()
	}

	override protected createMainWindow() {
		return new VentanaPrincipal(this)
	}

}
