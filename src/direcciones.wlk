import configuraciones.*
import jugador.*
import tarjetas.*


object arriba {
	method nombre() = "Espalda"
	
	method posicion(posicion) = posicion.up(1)
	
	method opuesto() = abajo
	
	//method posicion(posicion, cantidad) = posicion.up(cantidad)
	
	method puedeIr(personaje) = personaje.position().y() < (altura - 3)
	
	method orientar(personaje, posicion){
	}
}
 
 
object abajo {
	method nombre() = "DeFrente"
	
	method posicion(posicion) = posicion.down(1)
	
	method opuesto() = arriba
	
	//method posicion(posicion, cantidad) = posicion.down(cantidad)
	
	method puedeIr(personaje) = personaje.position().y() > 1
	
	method orientar(personaje, posicion){
	}
}


object derecha {
	method nombre() = "Derecha"
	
	method posicion(posicion) = posicion.right(1)
	
	method puedeIr(personaje) = personaje.position().x() < (ancho - 5)
	
	method opuesto() = izquierda
	
	//method posicion(posicion, cantidad) = posicion.right(cantidad)
	
	method orientar(personaje, posicion) {
		personaje.orientacion(self)
	}	
} 


object izquierda {
	method nombre() = "Izquierda"
	
	//method posicion(posicion, cantidad) = posicion.left(cantidad)
	
	method opuesto() = derecha
	
	method posicion(posicion) = posicion.left(1)
	
	method puedeIr(personaje) = personaje.position().x() > 3
	
	method orientar(personaje, posicion) {
		personaje.orientacion(self)
	}
}

