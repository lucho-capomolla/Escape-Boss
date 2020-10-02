import wollok.game.*

object jugador {
	var property position = game.center()
	//var proteinas = 100
	//const ganasDeViciar = true

	method image() {
		return "prueba.gif"
	}
	
	method moverA(nuevaPosicion) {
		position = nuevaPosicion
	}

}

