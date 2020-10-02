import jugador.*
import wollok.game.*
import tarjetas.*

const ancho = 19
const altura = 12

object prueba {
	
	method iniciar() {
		game.addVisual(jugador)
		configuraciones.configurarTeclas()
		
	}
	
}

object configuraciones {
	
	method configurarTeclas() {
		keyboard.left().onPressDo({ if(jugador.position().x() > 1){
				jugador.moverA(jugador.position().left(1))
				tarjetas.hacerTurno()
				}
			})
		keyboard.right().onPressDo({ if(jugador.position().x() < (ancho - 5)){
				jugador.moverA(jugador.position().right(1))
				tarjetas.hacerTurno()
				}
			})
		keyboard.up().onPressDo({ if(jugador.position().y() < (altura - 2)){
				jugador.moverA(jugador.position().up(1))
				tarjetas.hacerTurno()
				}
			})
		keyboard.down().onPressDo({ if(jugador.position().y() > 1){
				jugador.moverA(jugador.position().down(1))
				tarjetas.hacerTurno()
				}
			})
		
		//keyboard.space().onPressDo({})

	}/*
	method configurarTeclas() {
		keyboard.up().onPressDo({ jugador.moverA(jugador.position().up(1)) })
		keyboard.down().onPressDo({ jugador.moverA(jugador.position().down(1)) })
		keyboard.left().onPressDo({ jugador.moverA(jugador.position().left(1)) })
		keyboard.right().onPressDo({ jugador.moverA(jugador.position().right(1)) })
	}*/
	
}
