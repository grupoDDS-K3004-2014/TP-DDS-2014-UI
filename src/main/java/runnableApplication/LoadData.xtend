package runnableApplication

import persistencia.HomeParticipantes

class LoadData {
	def static void main(String[] args) {
		new HomeParticipantes
		System.out.print("Data cargada")
	}

}
