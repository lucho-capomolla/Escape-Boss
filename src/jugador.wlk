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
		return "Jugador" + direccion.nombre() + ".png"
	}
		
		//else if(direccionQueMira) 
			//return "JugadorDerecha.png"
		//return "JugadorIzquierda.png"
	
	
	method moverA(nuevaPosicion) {
		if(self.puedeMoverse(nuevaPosicion))
			position = nuevaPosicion
		self.disminuirEnergia(1)
	}
	
	method puedeMoverse(posicion) = posicion.allElements().all({objeto => objeto.esAtravesable()})
	
	method consumir() {
		position.allElements().forEach({objeto => objeto.potenciar()})
	}
	
	method serConsumido(){
	}
	
	method aumentarEnergia(cantidad) {
		energia = 100.min(energia + cantidad)
	}
	
	
	method disminuirEnergia(cantidad) {
		energia = 0.max(energia - cantidad)
		if(energia == 0){
			game.say(self, "Sin energía")
			game.schedule(3000, {game.stop()})
		}
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


object fondoPerdedor{
	var property position = game.at(0,0)
	method image() = "fondoperdio1.png"
}