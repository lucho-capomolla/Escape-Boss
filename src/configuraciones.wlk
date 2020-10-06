import jugador.*
import wollok.game.*
import tarjetas.*
import oficina.*
import jefe.*

const ancho = 19
const altura = 12

object prueba {
	
	method iniciar() {
		game.addVisual(cafeConLeche)
		game.addVisual(jefe)
		game.addVisual(companieri)
		game.addVisual(jugador)
		game.addVisual(planta)
		configuraciones.configurarTeclas()
	}
}

object configuraciones {
	
	method configurarTeclas() {
		keyboard.left().onPressDo({ if(jugador.position().x() > 3){
				jugador.moverA(jugador.position().left(1))
				tarjetas.hacerTurno()
				jugador.direccion("Izquierda")
				}
			})
		keyboard.right().onPressDo({ if(jugador.position().x() < (ancho - 5)){
				jugador.moverA(jugador.position().right(1))
				tarjetas.hacerTurno()
				jugador.direccion("Derecha")
				}
			})
		keyboard.up().onPressDo({ if(jugador.position().y() < (altura - 3)){
				jugador.moverA(jugador.position().up(1))
				tarjetas.hacerTurno()
				}
			})
		keyboard.down().onPressDo({ if(jugador.position().y() > 1){
				jugador.moverA(jugador.position().down(1))
				tarjetas.hacerTurno()
				}
			})
		
		keyboard.c().onPressDo({jugador.consumirPotenciador(game.uniqueCollider(jugador))})
		//keyboard.c().onPressDo({}) 		Interactuar con objeto (Impresora, consumible, compañery)
		
		//keyboard.e().onPressDo({jugador.esconderse(game.uniqueCollider(jugador))})	
		

	}/*
	method configurarTeclas() {
		keyboard.up().onPressDo({ jugador.moverA(jugador.position().up(1)) })
		keyboard.down().onPressDo({ jugador.moverA(jugador.position().down(1)) })
		keyboard.left().onPressDo({ jugador.moverA(jugador.position().left(1)) })
		keyboard.right().onPressDo({ jugador.moverA(jugador.position().right(1)) })
	}*/
	
}
