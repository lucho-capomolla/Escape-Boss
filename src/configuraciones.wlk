import jugador.*
import wollok.game.*

const ancho = 20
const altura = 15

object prueba {
	
	method iniciar() {
		game.addVisual(jugador)
		configuraciones.configurarTeclas()
		
	}
	
}

object configuraciones {
	
	method configurarTeclas() {
		keyboard.left().onPressDo({ if(jugador.position().x() > 0)jugador.moverA(jugador.position().left(1))})
		keyboard.right().onPressDo({ if(jugador.position().x() < (ancho - 1))jugador.moverA(jugador.position().right(1))})
		keyboard.up().onPressDo({ if(jugador.position().y() < (altura - 1))jugador.moverA(jugador.position().up(1))})
		keyboard.down().onPressDo({ if(jugador.position().y() > 0)jugador.moverA(jugador.position().down(1))})

	}/*
	method configurarTeclas() {
		keyboard.up().onPressDo({ jugador.moverA(jugador.position().up(1)) })
		keyboard.down().onPressDo({ jugador.moverA(jugador.position().down(1)) })
		keyboard.left().onPressDo({ jugador.moverA(jugador.position().left(1)) })
		keyboard.right().onPressDo({ jugador.moverA(jugador.position().right(1)) })
	}*/
	
}
