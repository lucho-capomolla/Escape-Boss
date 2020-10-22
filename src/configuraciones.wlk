import jugador.*
import wollok.game.*
import tarjetas.*
import oficina.*
import jefe.*
import direcciones.*
import menuInicio.*
import pantallaJuego.*
import sonidos.*

const ancho = 19
const altura = 12

object configuraciones {
	var estadoActual = estadoMenuInicio
	
	method configurarTeclas() {
		
		keyboard.up().onPressDo({estadoActual.alPresionarUp()})
		keyboard.down().onPressDo({estadoActual.alPresionarDown()})
		keyboard.right().onPressDo({estadoActual.alPresionarRight()})
		keyboard.left().onPressDo({estadoActual.alPresionarLeft()})
		keyboard.e().onPressDo({estadoActual.interactuar()})
		//keyboard.s().onPressDo({estadoActual.alPresionarS()})
		//keyboard.a().onPressDo({estadoActual.alPresionarA()})
		//keyboard.d().onPressDo({estadoActual.alPresionarD()})
		//keyboard.w().onPressDo({estadoActual.alPresionarW()})
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
	//method alPresionarS(){}
	//method alPresionarA(){}
	//method alPresionarD(){}
	//method alPresionarW(){}
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
		jefe.elegirDificultad(dificultad)
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

/*
class EstadoDificultad inherits Estado{
	var property dificultad
	
	method confirmarDificultad(){
		menuInicio.mostrarInstrucciones()
		sonido.reproducir("Confirmar.wav")
		jefe.elegirDificultad(dificultad)
	}
	
	method alPresionarNum1(){}
	method alPresionarNum2(){}
	method alPresionarNum3(){}
}


object easy inherits EstadoDificultad{
	override method alPresionarNum1(){
		dificultad = facil
	}
}
object medium inherits EstadoDificultad{
	override method alPresionarNum2(){
		dificultad = normal
	}
}
object hard inherits EstadoDificultad{
	override method alPresionarNum3(){
		dificultad = dificil
	}
}
*/

/* 
object estadoDificultad inherits Estado{
	override method alPresionar1(){
		jefe.elegirDificultad(facil)
		menuInicio.mostrarInstrucciones()
		sonido.reproducir("Confirmar.wav")
	}
	override method alPresionar2(){
		jefe.elegirDificultad(normal)
		menuInicio.mostrarInstrucciones()
		sonido.reproducir("Confirmar.wav")
	}
	override method alPresionar3(){
		jefe.elegirDificultad(dificil)
		menuInicio.mostrarInstrucciones()
		sonido.reproducir("Confirmar.wav")
	}
}
*/




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
		jugador.interactuar()
	}
	//override method alPresionarS() {
	//	jugador.usarImpresora()
	//}
	//override method alPresionarA() {
	//	jugador.consumir()
	//}
	//override method alPresionarD() {
	//	jugador.entregarTarea()
	//}
	//override method alPresionarW(){
	//	jugador.interactuar()
	//}

}