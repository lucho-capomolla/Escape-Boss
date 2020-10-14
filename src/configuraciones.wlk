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
		game.addVisual(companieri1)
		//game.addVisual(companieri2)
		//game.addVisual(companieri3)
		game.addVisual(impresoraA)
		game.addVisual(impresoraB)
		game.addVisual(impresoraC)
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

		keyboard.c().onPressDo({jugador.consumir()})
	
		// Que pueda interactuar con el cuadro del carpincho?
		
		// Turno: Que el jugador se mueva durante su turno, y el Jefe durante el suyo -> ESTE TURNO = Tiempo, Cantidad de movimientos o Al tocar una Tecla
		// Etapa siguiente <- Pensarlo bien bien
	}
	
	method configurarColisiones() {
		game.onCollideDo(jugador, {algo => algo.teEncontro()})
	}	
}


class Direccion {
	
	method moverse(cantidad) {
		jugador.moverA(self.direccion(cantidad))
		tarjetas.hacerTurno()
		jugador.estaEnLaPuerta()	
	}	
	
	method direccion(cantidad) {
		if(self.puedeIr()){
			return self.hacia(cantidad)
		}
		jugador.error("No es por ahi man")
		return jugador.position()
	}
	
	method puedeIr()
	method hacia(cantidad)
}

object arriba inherits Direccion {
	
	override method puedeIr() = jugador.position().y() < (altura - 3)
	override method hacia(cantidad) = jugador.position().up(cantidad)
}

object abajo inherits Direccion {
	
	override method puedeIr() = jugador.position().y() > 1
	override method hacia(cantidad) = jugador.position().down(cantidad)
}

object derecha inherits Direccion {
	
	method nombre() = "Derecha"
	override method puedeIr() = jugador.position().x() < (ancho - 5)
	override method hacia(cantidad) {
		jugador.direccion(self)
		return jugador.position().right(cantidad)
	}
}

object izquierda inherits Direccion {
	
	method nombre() = "Izquierda"
	override method puedeIr() = jugador.position().x() > 3
	override method hacia(cantidad) {
		jugador.direccion(self)
		return jugador.position().left(cantidad)
	}
}
