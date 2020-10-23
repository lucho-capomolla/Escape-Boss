import wollok.game.*
import oficina.*
import configuraciones.*
import direcciones.*
import tareas.*
import jefe.*
import pantallaJuego.*
import sonidos.*

class Personaje {
	var property position
	
	method moverse(direccion) {
		self.moverHaciaSiSePuede(self, direccion)
	}
	
	method moverHaciaSiSePuede(personaje, direccion) {
		if(direccion.puedeIr(personaje)){
			self.moverHacia(personaje, direccion)
		}
		else {
			personaje.error("No es por ahi man")
		}
	}
	
	method puedeMoverse(posicion) = posicion.allElements().all({objeto => objeto.esAtravesable()})
	
	method moverHacia(personaje, direccion) {
		const nuevaPosicion = direccion.posicion(personaje.position())
		if(self.puedeMoverse(nuevaPosicion)){
			personaje.orientacion(direccion)
			personaje.position(nuevaPosicion)
		}
		
	}
}


object jugador inherits Personaje (position = game.at(3,1)) {
	
	var property energia = 100
	var property orientacion = derecha
	const property tareasRealizadas = #{}
	const objetosEnMochila = []
	var tareaEnMano = sinTarea
	
	method image() {
		if(self.estaEscondido())
			return "Personaje/Escondido.png"
		return "Personaje/Jugador" + orientacion.nombre() + tareaEnMano.color() + ".png"
	}
	
	method moverAlInicio() {
		self.orientacion(derecha)
		position = game.at(3,1)
	}
	
	override method moverse(nuevaPosicion) {
		super(nuevaPosicion)
		self.disminuirEnergia(3)
	}
	
//       CONSUMIBLES
	method aumentarEnergia(cantidad) {
		energia = (energia + cantidad).min(100)
	}
	
	method disminuirEnergia(cantidad) {
		energia = (energia - cantidad).max(0)
			if(energia == 0){
				game.clear()
				game.addVisual(fondoPerdioEnergia)
				game.schedule(500, {sonido.reproducir("Lost.wav")})
				game.schedule(5000, {game.stop()})
		}
	}

	method objetosEnMochila() = objetosEnMochila

//		ACCIONES POR ENTORNO (ESCONDERSE)
	method estaEscondido() = position == planta.position()

	method puedeEsconderse() = true
	
	method esAtravesable() = not(self.estaEscondido())

//	      TAREAS
	method agregarTarea(tarea) {
		tareaEnMano = tarea
	}
	
	method tareaEnMano() = tareaEnMano
	
	method accionar(){
		position.allElements().forEach({elemento => elemento.interactuar()})
	}
	
	method interactuar(){}
	
	method terminarTarea(tarea) {
		tareaEnMano = sinTarea
		tareasRealizadas.add(tarea)
	}
	
}
