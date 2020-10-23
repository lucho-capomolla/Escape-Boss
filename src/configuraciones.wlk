import wollok.game.*
import jugador.*
import tarjetas.*
import oficina.*
import jefe.*
import direcciones.*
import menuInicio.*
import pantallaJuego.*
import sonidos.*

const ancho = 19
const altura = 13

object configuraciones {
	var estadoActual = estadoMenuInicio
	
	method configurarTeclas() {
		
		keyboard.up().onPressDo({estadoActual.alPresionarUp()})
		keyboard.down().onPressDo({estadoActual.alPresionarDown()})
		keyboard.right().onPressDo({estadoActual.alPresionarRight()})
		keyboard.left().onPressDo({estadoActual.alPresionarLeft()})
		keyboard.e().onPressDo({estadoActual.alPresionarE()})
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
	
class Estado{
	method alPresionarUp(){}
	method alPresionarDown(){}
	method alPresionarRight(){}
	method alPresionarLeft(){}
	method alPresionarE(){}
	method alPresionarEnter(){}
	method alPresionar1(){}
	method alPresionar2(){}
	method alPresionar3(){}
}

object estadoMenuInicio inherits Estado{
	override method alPresionarEnter() {
		menuInicio.elegirDificultad()
		sonido.reproducir("Confirmar.wav")
	}
}

object estadoDificultad inherits Estado{
	var dificultad
	
	method confirmarDificultad(){
		jefe1.elegirDificultad(dificultad)
		menuInicio.mostrarInstrucciones()
		sonido.reproducir("Confirmar.wav")
	}
	override method alPresionar1(){
		dificultad = facil
		self.confirmarDificultad()
	} 
	override method alPresionar2(){
		dificultad = normal
		self.confirmarDificultad()
	}
	override method alPresionar3(){
		dificultad = dificil
		self.confirmarDificultad()
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
	override method alPresionarE() {
		jugador.accionar()
	}
}