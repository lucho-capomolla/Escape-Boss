import wollok.game.*

object jugador {
	var property position = game.center()
	//var proteinas = 100
	//const ganasDeViciar = true

	method image() {
		return "Jugador2.png"
	}
	
	method moverA(nuevaPosicion) {
		position = nuevaPosicion
	}
}
