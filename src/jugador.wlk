import wollok.game.*
import oficina.*

object jugador {
	var property position = game.at(3,2)
	var property energia = 100
	var property direccion = "Derecha"
	//Delegar las direcciones
	
	method image() {
		if(self.estaEscondido())
			return "JugadorEscondido.png"
		else if(self.direccion() == "Derecha") 
			return "JugadorDerecha.png"
		return "JugadorIzquierda.png"
	}
	
	method moverA(nuevaPosicion) {
		position = nuevaPosicion
		self.disminuirEnergia(1)
	}
	
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
