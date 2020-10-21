import wollok.game.*
import jugador.*
import tareas.*
import jefe.*
import pantallaJuego.*
import sonidos.*

class Consumible {
	var property position
	var energiaAportada

	method serConsumido() {
		jugador.aumentarEnergia(energiaAportada)
		game.say(jugador, "Aumento la energia en " + energiaAportada)
		game.removeVisual(self)
		sonido.reproducir("Burp.mp3")
	} 
	method teEncontro() = true

	method esAtravesable() = true
	
	method darCopia(){}
	
	method presentarTarea(tarea){}
	
	method analizar(){}
}


object cafeConLeche inherits Consumible (energiaAportada=20, position = game.at(7,7)) {
	 method image() = "Oficina/Cafe.png"
}

object chocolate inherits Consumible (energiaAportada=35, position = game.at(13,8)){
	method image() = "Oficina/Chocolate.png"
}

object hamburguesa inherits Consumible (energiaAportada=50, position = game.at(11,2)) {
	 method image() = "Oficina/Hamburguesa.png"
}



object planta {
	var property position = game.at(9,3)
	
	method image() = "Oficina/Planta.png"
	
	method teEncontro() = position == jugador.position()
	
	method serConsumido() {
		jugador.error("Eto no eh comida papi")
	}
	
	method presentarTarea(tarea){}
	
	method esAtravesable() = true
	
	method analizar(){}
}


class Impresora {
	var property position
	var tarea
	
	method esAtravesable() = true
	
	method darCopia() {
		jugador.agregarTarea(tarea)
		game.say(self, "Printer does BRRR BRRR")
		sonido.reproducir("Impresion.mp3")
	}
	
	method serConsumido(){}
	
	method presentarTarea(unaTarea){}
	
	method teEncontro() = true
	
	method analizar(){}
}

object impresoraAzul inherits Impresora (tarea = tareaAzul, position = game.at(3,5)) {
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
	
	method esAtravesable() = false
	
	method presentarTarea(tarea) {
		if(tareaRequerida == tarea) {
			game.say(self, "Me has salvado! Estoy agradecido")
			jugador.terminarTarea(tarea)
			sonido.reproducir("Carpeta.mp3")
		}
		else{
			game.say(self, "Te equivocaste de tarea, papafrita")
		}
	}
	
	method darCopia(){}
	
	method serConsumido(){}
	
	method teEncontro() = true
	
	method analizar(){}
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



object puerta {
	var property position = game.at(8,9)
	const tareasNecesarias = #{tareaAzul, tareaRojo, tareaVerde}
	
	method escapar() {
		if (tareasNecesarias == jugador.tareasRealizadas()){
			game.say(self, "GOOD ENDING")
			pantallaJuego.terminar()
			game.addVisual(fondoGanador)
			sonido.reproducir("Yodelling.mp3")
			game.schedule(5000, {game.stop()})
		}
		else {
			game.say(self, "TE FALTAN TAREAS BOLUDO")
		}
	}
	method image() = "Oficina/Puerta.png"
	
	method teEncontro() {
		if(position == jugador.position()){
			self.escapar()
		}
	}
	
	method potenciar(){}
	
	method serConsumido(){}
	
	method presentarTarea(tarea){}
	
	method darCopia(){}
	
	method esAtravesable() = true
	
	method analizar(){}
}


object cuadrito {
	var property position = game.at(10,9)
	
	method image() = "Fondos/Cuadrito.png"
	
	method teEncontro() = position == jugador.position()
	
	method analizar(){
		//game.removeTickEvent("Perseguir")
		game.removeVisual(jefe)
		game.addVisual(carpinchito)
		game.schedule(2000, {game.removeVisual(carpinchito)})
		game.schedule(2000, {game.addVisual(jefe)})
		//jefe.moverse()
		//game.addVisual(jefe)
	}
	
	method darCopia(){}
	
	method presentarTarea(tarea){}
	
	method serConsumido(){}
	
	method esAtravesable() = true
}

object carpinchito {
	var property position = game.origin()
	
	method image() = "Fondos/Carpinchito.jpg"
}