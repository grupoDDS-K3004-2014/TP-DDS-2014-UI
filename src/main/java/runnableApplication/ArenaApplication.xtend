package runnableApplication

import org.uqbar.arena.Application
import ui.VentanaPrincipal

class ArenaApplication extends Application{
	
	def static void main(String[] args) {
		new ArenaApplication().start()
	}
	
	
	override protected createMainWindow() {
		return new VentanaPrincipal(this)
	}
	
}
