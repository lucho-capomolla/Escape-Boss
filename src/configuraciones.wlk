import jugador.*
import wollok.game.*
import tarjetas.*
import oficina.*
import jefe.*
import direcciones.*
import menuInicio.*
import pantallaJuego.*

const ancho = 19
const altura = 12

object configuraciones {
	var estadoActual = estadoMenuInicio
	
	method configurarTeclas() {
		
		keyboard.up().onPressDo({estadoActual.alPresionarUp()})
		keyboard.down().onPressDo({estadoActual.alPresionarDown()})
		keyboard.right().onPressDo({estadoActual.alPresionarRight()})
		keyboard.left().onPressDo({estadoActual.alPresionarLeft()})
		keyboard.s().onPressDo({estadoActual.alPresionarS()})
		keyboard.a().onPressDo({estadoActual.alPresionarA()})
		keyboard.d().onPressDo({estadoActual.alPresionarD()})
		keyboard.w().onPressDo({estadoActual.alPresionarW()})
		keyboard.enter().onPressDo({estadoActual.alPresionarEnter()})
		
/*
		keyboard.up().onPressDo({jugador.moverse(arriba)})
		keyboard.down().onPressDo({jugador.moverse(abajo)})
		keyboard.right().onPressDo({jugador.moverse(derecha)})
		keyboard.left().onPressDo({jugador.moverse(izquierda)})
		keyboard.s().onPressDo({jugador.usarImpresora()})
		keyboard.a().onPressDo({jugador.consumir()})
		keyboard.d().onPressDo({jugador.entregarTarea()})
		keyboard.enter().onPressDo({menuInicio.continuar()})
		//keyboard.w().onPressDo({jugador.estaerEgg()})
		// Que pueda interactuar con el cuadro del carpincho?
		*/
		// Turno: Que el jugador se mueva durante su turno, y el Jefe durante el suyo -> ESTE TURNO = Tiempo, Cantidad de movimientos o Al tocar una Tecla
		// Etapa siguiente <- Pensarlo bien bien
		}
		
		method cambiarEstado(nuevoEstado) {
			estadoActual = nuevoEstado
	}
	
	method configurarColisiones() {
		game.onCollideDo(jugador, {algo => algo.teEncontro()})
	}	
}	
	//method puedeMoverse(posicion) = posicion.allElements().all({objeto => objeto.esAtravesable()})
	
class Estado{
	method alPresionarUp(){}
	method alPresionarDown(){}
	method alPresionarRight(){}
	method alPresionarLeft(){}
	method alPresionarS(){}
	method alPresionarA(){}
	method alPresionarD(){}
	method alPresionarW(){}
	method alPresionarEnter(){}
}

object estadoMenuInicio inherits Estado{
	override method alPresionarEnter() {
		menuInicio.elegirDificultad()
	}
}

object estadoJuego inherits Estado{
	override method alPresionarUp() {
		jugador.moverse(arriba)
	}
	override method alPresionarDown() {
		jugador.moverse(abajo)
	}
	override method alPresionarRight() {
		jugador.moverse(derecha)
	}
	override method alPresionarLeft() {
		jugador.moverse(izquierda)
	}
	override method alPresionarS() {
		jugador.usarImpresora()
	}
	override method alPresionarA() {
		jugador.consumir()
	}
	override method alPresionarD() {
		jugador.entregarTarea()
	}
}
