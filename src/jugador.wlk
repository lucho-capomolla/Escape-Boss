import wollok.game.*
import oficina.*
import configuraciones.*

object jugador {
	var property position = game.at(3,1)
	var property energia = 100
	var property direccion = derecha
	//Delegar las direcciones
	//Cada direccion tiene que ser un objeto
	
	//var property image = "JugadorDerecha.png"
	
	method image() {
		if(self.estaEscondido())
			return "JugadorEscondido.png"
		if(self.direccion() == derecha)
			return "JugadorDerecha.png"
		return "JugadorIzquierda.png"
		
		//else if(direccionQueMira) 
			//return "JugadorDerecha.png"
		//return "JugadorIzquierda.png"
	}
	
	method moverA(nuevaPosicion) {
		if(self.puedeMoverse(nuevaPosicion))
			position = nuevaPosicion
		self.disminuirEnergia(1)
	}
	
	method puedeMoverse(posicion) = posicion.allElements().all({objeto => objeto.esAtravesable()})
	
	method consumirPotenciador(objeto) {
		objeto.potenciar(self)
		game.removeVisual(objeto)
	}
	
	method aumentarEnergia(cantidad) {
		energia += cantidad
	}
	
	method disminuirEnergia(cantidad) {
		energia -= cantidad
	}
	
	method estaEscondido() {
		//self.image("JugadorEscondido.png")
		return position == planta.position()
	}
	
	method estaEnLaPuerta() {
		if(position == puerta.position())
			game.say(self, "Estamos en la puerta")
	}
	
	method usarImpresora() {
		// para conseguir la tarea de una impresora particular
	}
	
	method presentarTarea() {
		
		// hacer una coleccion,donde tenga las 3 tareas asignadas por defecto, y otra coleccion, donde estan las tareas listas
		// una vez que ésta está lista, entregarla a su respectivo compañery.
	}
}

object direccionQueMira {
	var property direccion = derecha
	
}