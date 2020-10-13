import jugador.*
import wollok.game.*
import tarjetas.*
import oficina.*
import jefe.*

const ancho = 19
const altura = 12

object prueba {	
	
	method iniciar() {
		game.addVisual(puerta)
		game.addVisual(cafeConLeche)
		game.addVisual(jefe)
		game.addVisual(companieri)
		game.addVisual(impresora)
		game.addVisual(jugador)
		game.addVisual(planta)
		configuraciones.configurarTeclas()
		configuraciones.configurarColisiones()
	}
}

object configuraciones {
	
	method configurarTeclas() {
	
		keyboard.up().onPressDo({arriba.moverse(1)})
		keyboard.down().onPressDo({abajo.moverse(1)})
		keyboard.right().onPressDo({derecha.moverse(1)})
		keyboard.left().onPressDo({izquierda.moverse(1)})
	/*
		keyboard.left().onPressDo({ if(jugador.position().x() > 3){
				jugador.moverA(jugador.position().left(1))
				tarjetas.hacerTurno()
				jugador.direccion("Izquierda")
				jugador.estaEnLaPuerta()
				}
			})
		keyboard.right().onPressDo({ if(jugador.position().x() < (ancho - 5)){
				jugador.moverA(jugador.position().right(1))
				tarjetas.hacerTurno()
				jugador.direccion("Derecha")
				jugador.estaEnLaPuerta()
				}
			})
		keyboard.up().onPressDo({ if(jugador.position().y() < (altura - 3)){
				jugador.moverA(jugador.position().up(1))
				tarjetas.hacerTurno()
				jugador.estaEnLaPuerta()
				}
			})
		keyboard.down().onPressDo({ if(jugador.position().y() > 1){
				jugador.moverA(jugador.position().down(1))
				tarjetas.hacerTurno()
				jugador.estaEnLaPuerta()
				}
			})
		*/
		//keyboard.c().onPressDo({game.onCollideDo(jugador, {consumible => jugador.consumirPotenciador(consumible)})})
		//game.whenKeyPressedDo(keyboard.c().onPressDo({}), {game.onCollideDo(jugador, {consumible => jugador.consumirPotenciador(consumible)})})
		keyboard.c().onPressDo({jugador.consumir()})
		//keyboard.c().onPressDo({}) 		Interactuar con objeto (Impresora, consumible, compañery)
	
		// Que los limites sean un objeto, y no pueda atraversarlo, como paredes invisibles (?
		// REPETICION DE LOGICA EN LAS TECLA, delegar bastante
		// Verificar que el jugador PUEDA MOVERSE a Tal direccion
		// Que pueda interactuar con el cuadro del carpincho?
		
		// Turno: Que el jugador se mueva durante su turno, y el Jefe durante el suyo -> ESTE TURNO = Tiempo, Cantidad de movimientos o Al tocar una Tecla
		// Etapa siguiente <- Pensarlo bien bien
	}
	
	method configurarColisiones() {
		game.onCollideDo(jugador, {algo => algo.teEncontro()})
		//game.onCollideDo(jugador, {algo => algo.teEncontro()})
		//game.whenCollideDo(jugador, {consumible => jugador.consumirPotenciador(consumible)})
	}
	
}

class Direccion {
	
	method moverse(cantidad) {
		tarjetas.hacerTurno()
		jugador.estaEnLaPuerta()
	}

}

object arriba inherits Direccion {

	method nombre() {
	}

	override method moverse(cantidad) {
		jugador.moverA(jugador.position().up(cantidad))
		super(cantidad)
	}
}

object abajo inherits Direccion {
	
	method nombre() {
	}
	
	override method moverse(cantidad) {
		jugador.moverA(jugador.position().down(cantidad))
		super(cantidad)
	}
}

object derecha inherits Direccion {
	
	method nombre() = "Derecha"
	
	override method moverse(cantidad) {
		jugador.moverA(jugador.position().right(cantidad))
		jugador.direccion(self)
		super(cantidad)
	}
}

object izquierda inherits Direccion {
	
	method nombre() = "Izquierda"
	
	override method moverse(cantidad) {
		jugador.moverA(jugador.position().left(cantidad))
		jugador.direccion(self)
		super(cantidad)
	}
}
