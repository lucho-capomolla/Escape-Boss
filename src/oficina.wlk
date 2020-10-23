import wollok.game.*
import jugador.*
import tareas.*
import jefe.*
import pantallaJuego.*
import sonidos.*
import niveles.*

class Consumible {
	var property position
	var energiaAportada

	method interactuar() {
		jugador.aumentarEnergia(energiaAportada)
		game.say(jugador, "Aumento la energia en " + energiaAportada.toString())
		game.removeVisual(self)
		sonido.reproducir("Burp.mp3")
	} 
	method teEncontro() = true

	method esAtravesable() = true
	
}


object cafeConLeche inherits Consumible (energiaAportada=25, position = game.at(7,7)) {
	 method image() = "Oficina/Cafe.png"
}

object chocolate inherits Consumible (energiaAportada=45, position = game.at(13,8)){
	method image() = "Oficina/Chocolate.png"
}

object hamburguesa inherits Consumible (energiaAportada=60, position = game.at(11,2)) {
	 method image() = "Oficina/Hamburguesa.png"
}



object planta {
	var property position = game.at(4,5)
	
	method image() = "Oficina/Planta.png"
	
	method teEncontro() = position == jugador.position()
	
	method serConsumido() {
		jugador.error("Eto no eh comida papi")
	}

	method esAtravesable() = jugador.puedeEsconderse() and not(jefe1.puedeEsconderse())
	
}


class Impresora {
	var property position
	var tarea
	
	method esAtravesable() = true
	
	method interactuar() {
		jugador.agregarTarea(tarea)
		game.say(self, "Printer does BRRR BRRR")
		sonido.reproducir("Impresion.mp3")
	}
	
	method teEncontro() = true
	
}

object impresoraAzul inherits Impresora (tarea = tareaAzul, position = game.at(3,4)) {
	method image() = "Oficina/ImpresoraAAzul.png"
}

object impresoraRojo inherits Impresora (tarea = tareaRojo, position = game.at(8,2)) {
	method image() = "Oficina/ImpresoraBRojo.png"
}

object impresoraVerde inherits Impresora (tarea = tareaVerde, position = game.center()) {
	method image() = "Oficina/ImpresoraAVerde.png"
}


class Companieri {
	var property position
	var tareaRequerida
	
	method esAtravesable() = true
	
	method interactuar() {
		const tarea = jugador.tareaEnMano()
		if(tareaRequerida == tarea) {
			game.say(self, "Me has salvado! Estoy agradecido")
			jugador.terminarTarea(tarea)
			tarea.seEntrego()
			sonido.reproducir("Carpeta.mp3")
		}
		else{
			game.say(self, "Te equivocaste de tarea, papafrita")
		}
	}
	
	method teEncontro() = true
	
}

object companieriAzul inherits Companieri (tareaRequerida = tareaAzul, position = game.at(13,5)){
	method image() = "Oficina/CompanieriAzul.png"
}

object companieriRojo inherits Companieri (tareaRequerida = tareaRojo, position = game.at(6,4)){
	method image() = "Oficina/CompanieriRojo.png"
}

object companieriVerde inherits Companieri (tareaRequerida = tareaVerde, position = game.at(3,8)){
	method image() = "Oficina/CompanieriVerde.png"
}


// Seria el CheckPoint
object puerta {
	var property position = game.at(8,10)
	
	
	method avanzar() {
		//if (tareasNecesarias == jugador.tareasRealizadas()){
		pantallaJuego.nivelActual().finalizarNivel()
			//game.addVisual(fondoGanador)
			//sonido.reproducir("Yodelling.mp3")
			//game.schedule(5000, {game.stop()})
		}
		//else {
		//	game.say(self, "TE FALTAN TAREAS BOLUDO")
		//}
	//}
	method image() = "Oficina/Puerta.png"
	
	method teEncontro() {
		if(position == jugador.position()){
			self.avanzar()
		}
	}
	
	method esAtravesable() = true
	
}


object cuadrito {
	var property position = game.at(10,10)
	
	method image() = "Fondos/Cuadrito.png"
	
	method teEncontro() = position == jugador.position()
	
	method interactuar(){
		jefe1.esconderse()
		game.addVisual(carpinchito)
		game.schedule(2000, {game.removeVisual(carpinchito)})
	}
	
	method esAtravesable() = true
}

object carpinchito {
	var property position = game.origin()
	
	method image() = "Fondos/Carpinchito.jpg"
}