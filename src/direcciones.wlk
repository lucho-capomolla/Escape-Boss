import configuraciones.*
import jugador.*
import tarjetas.*

/*
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
}*/



object arriba {
	method nombre() = "Espalda"
	
	method posicion(posicion) = posicion.up(1)
	
	method posicion(posicion, cantidad) = posicion.up(cantidad)
	
	method puedeIr(personaje) = personaje.position().y() < (altura - 3)
	
	method orientar(personaje, posicion){
	}
}
 
object abajo {
	method nombre() = "DeFrente"
	
	method posicion(posicion) = posicion.down(1)
	
	method posicion(posicion, cantidad) = posicion.down(cantidad)
	
	method puedeIr(personaje) = personaje.position().y() > 1
	
	method orientar(personaje, posicion){
	}
}

object derecha {
	method nombre() = "Derecha"
	
	method posicion(posicion) = posicion.right(1)
	
	method puedeIr(personaje) = personaje.position().x() < (ancho - 5)
	
	method posicion(posicion, cantidad) = posicion.right(cantidad)
	
	method orientar(personaje, posicion) {
		personaje.orientacion(self)
	}
		
	
} 

object izquierda {
	method nombre() = "Izquierda"
	
	method posicion(posicion, cantidad) = posicion.left(cantidad)
	
	method posicion(posicion) = posicion.left(1)
	
	method puedeIr(personaje) = personaje.position().x() > 3
	
	method orientar(personaje, posicion) {
		personaje.orientacion(self)
	}
}

