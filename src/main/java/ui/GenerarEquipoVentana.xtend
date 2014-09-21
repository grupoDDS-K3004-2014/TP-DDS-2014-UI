package ui

import org.uqbar.arena.windows.Dialog
import domain.Partido
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Button
import domain.Sistema
import domain.CriterioCompuesto

class GenerarEquipoVentana extends Dialog<Partido> {

	Partido partidoClon
	Sistema sistema
	CriterioCompuesto criterioCompuesto	

	new(WindowOwner owner, Partido partido) {
		super(owner, partido)
		partidoClon = partido.clone as Partido
	}

	override protected createFormPanel(Panel mainPanel) {
		
		new Label(mainPanel).setText(partidoClon.nombreDelPartido).setFontSize(15)

	}

	override protected void addActions(Panel actions) {
		new Button(actions).setCaption("Aceptar").onClick[|this.accept].setAsDefault.disableOnError

		new Button(actions).setCaption("Cancelar").onClick[|
			modelObject.copiarValoresDe(partidoClon)
			this.cancel
		]
	}

}
