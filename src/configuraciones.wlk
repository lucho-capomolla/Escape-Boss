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
		keyboard.num1().onPressDo({estadoActual.alPresionar1()})
		keyboard.num2().onPressDo({estadoActual.alPresionar2()})
		keyboard.num3().onPressDo({estadoActual.alPresionar3()})
		
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
	method alPresionar1(){}
	method alPresionar2(){}
	method alPresionar3(){}
}

object estadoMenuInicio inherits Estado{
	override method alPresionarEnter() {
		menuInicio.elegirDificultad()
	}
}

object estadoDificultad inherits Estado{
	override method alPresionar1(){
		jefe.elegirDificultad(facil)
		menuInicio.mostrarInstrucciones()
	}
	override method alPresionar2(){
		jefe.elegirDificultad(normal)
		menuInicio.mostrarInstrucciones()
	}
	override method alPresionar3(){
		jefe.elegirDificultad(dificil)
		menuInicio.mostrarInstrucciones()
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
	override method alPresionarW(){
		
	}
}