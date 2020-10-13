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
	
	method aumentarEnergia(cantidad) {
		energia=(energia + cantidad).min(100)
	}
	
	
	method disminuirEnergia(cantidad) {
		energia=(energia - cantidad).max(0)
			if(energia==0){
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
	method consumir() {
		position.allElements().forEach({elemento=>elemento.serConsumido()})
		//position.allElements().forEach({elemento=>self.consumirPotenciador(elemento)})
	}
	method serConsumido(){
	}
}


object direccionQueMira {
	var property direccion = derecha
	
}

object fondoPerdedor{
		var property position = game.at(0,0)
		method image() = "fondoperdio1.png"
}