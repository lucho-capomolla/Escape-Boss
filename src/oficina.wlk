import wollok.game.*
import jugador.*
import tareas.*
import jefe.*
import pantallaJuego.*
import sonidos.*

class Consumible {
	var property position
	var energiaAportada

	method interactuar() {
		jugador.aumentarEnergia(energiaAportada)
		game.say(jugador, "Aumento la energia en " + energiaAportada.toString())
		game.removeVisual(self)
		game.schedule(1, {sonido.reproducir("Burp.mp3")})
	} 
	method teEncontro() = true

	method esAtravesable() = true
	
}


object cafeConLeche inherits Consumible (energiaAportada=25, position = game.at(3,5)) {
	 method image() = "Oficina/Cafe.png"
}

object chocolate inherits Consumible (energiaAportada=45, position = game.at(13,7)){
	method image() = "Oficina/Chocolate.png"
}

object hamburguesa inherits Consumible (energiaAportada=60, position = game.at(11,2)) {
	 method image() = "Oficina/Hamburguesa.png"
}

object pizza inherits Consumible (energiaAportada = 30, position = game.at(8,8)){
	method image() = "Oficina/Pizza.png"
}

object bebida inherits Consumible (energiaAportada = 20, position = game.at(9,4)){
	method image() = "Oficina/Bebida.png"
}

object rosquilla inherits Consumible (energiaAportada = 50, position = game.at(8,2)){
	method image() = "Oficina/Rosquilla.png"
}


object mochila {
	var property position
	
	method image() = "Oficina/Mochila.png"
	
	method interactuar() {
		jugador.agarrarMochila()
	}
}


class Planta {
	var property position
	
	method image() = "Oficina/Planta.png"
	
	method teEncontro() = position == jugador.position()
	
	method interactuar() {
		jugador.error("Eto no eh comida papi")
	}
	
	method esAtravesable() = jugador.puedeEsconderse() and not(jefe1.puedeEsconderse())
}


object planta1 inherits Planta(position = game.at(3,6)){}

object planta2 inherits Planta(position = game.at(13,4)){}



class Impresora {
	var property position
	var tarea
	
	method esAtravesable() = true
	
	method interactuar() {
		jugador.agregarTarea(tarea)
		game.say(self, "Printer does BRRR BRRR")
		game.schedule(1, {sonido.reproducir("Impresion.mp3")})
	}
	
	method teEncontro() = true
	
}

object impresoraAzul inherits Impresora (tarea = tareaAzul, position = game.at(3,3)) {
	method image() = "Oficina/ImpresoraAAzul.png"
}

object impresoraRojo inherits Impresora (tarea = tareaRojo, position = game.center()) {
	method image() = "Oficina/ImpresoraBRojo.png"
}

object impresoraVerde inherits Impresora (tarea = tareaVerde, position = game.at(14,3)) {
	method image() = "Oficina/ImpresoraAVerde.png"
}


class Companieri {
	var property position
	var tareaRequerida
	
	method esAtravesable() = true
	
	method interactuar() {
		if(self.noTieneNingunaTarea()) {
			game.say(self, "No me hagas perder el tiempo.")
			return false
		}
		else{
			return self.entregarTarea()
			//return true
		}
	}
	
	method noTieneNingunaTarea() = jugador.tareaEnMano() == sinTarea
	
	method entregarTarea() {
		const tarea = jugador.tareaEnMano()
		if(tareaRequerida == tarea) {
			game.say(self, "Me has salvado! Estoy agradecido")
			jugador.terminarTarea(tarea)
			tarea.seEntrego()
			game.schedule(1, {sonido.reproducir("Carpeta.mp3")})
			return true
		}
		else{
			game.say(self, "Te equivocaste de tarea, papafrita")
			return false
		}
	}
	
	method teEncontro() = true
	
}

object companieriAzul inherits Companieri (tareaRequerida = tareaAzul, position = game.at(13,8)){
	method image() = "Oficina/CompanieriAzul.png"
}

object companieriRojo inherits Companieri (tareaRequerida = tareaRojo, position = game.at(6,5)){
	method image() = "Oficina/CompanieriRojo.png"
}

object companieriVerde inherits Companieri (tareaRequerida = tareaVerde, position = game.at(3,8)){
	method image() = "Oficina/CompanieriVerde.png"
}



object puerta {
	var property position = game.at(8,10)
	const tareasNecesarias = #{tareaAzul, tareaVerde, tareaRojo}
	
	method avanzar() {
		if (tareasNecesarias == jugador.tareasRealizadas()){
		//pantallaJuego.nivelActual().finalizarNivel()
			pantallaJuego.terminarJuego()
			return true
		}
		else {
			game.say(self, "Te faltan más tareas, apurate!")
			return false
		}
	}
	
	method image() = "Oficina/puerta.png"
	
	method teEncontro() = self.avanzar()
	
	method esAtravesable() = true
	
}


object cuadrito {
	var property position = game.at(10,10)
	
	method image() = "Oficina/cuadro.png"
	
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


class Muro {
	var property position
	method esAtravesable() = false
	
	method image() = "Oficina/Vacio.png"
}

object muroHorizontal inherits Muro(position = game.at(6,7)){
	override method image() = "Oficina/MuroHorizontal.png"
	
	method agregarMurosHorizontales() {
		game.addVisual(self)
		game.addVisual(muroHorizontal2)
		game.addVisual(muroHorizontal3)
		game.addVisual(muroHorizontal4)
		game.addVisual(muroHorizontal5)
	}
}

object muroHorizontal2 inherits Muro(position = game.at(7,7)){}
object muroHorizontal3 inherits Muro(position = game.at(8,7)){}
object muroHorizontal4 inherits Muro(position = game.at(9,7)){}
object muroHorizontal5 inherits Muro(position = game.at(10,7)){}


object muroVertical inherits Muro(position = game.at(8,3)){
	override method image() = "Oficina/MuroVertical.png"
	
	method agregarMurosVerticales() {
		game.addVisual(self)
		game.addVisual(muroVertical2)
		game.addVisual(muroVertical3)
		game.addVisual(muroVertical4)
	}
}

object muroVertical2 inherits Muro(position = game.at(8,4)){}
object muroVertical3 inherits Muro(position = game.at(8,5)){}
object muroVertical4 inherits Muro(position = game.at(8,6)){}