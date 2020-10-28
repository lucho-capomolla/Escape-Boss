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
	const property companierisAyudados = #{}
	const objetosEnMochila = #{}
	var tareaEnMano = sinTarea
	var objetoEnMano = vacio
	var tieneMochila = false
	
	method image() {
		if(self.estaEscondido())
			return "Personaje/Escondido.png"
		if(tieneMochila)
			return "Personaje/Jugador" + orientacion.nombre() + "Mochila.png" 
		if(self.noTieneNingunaTarea())
			return "Personaje/Jugador" + orientacion.nombre() + objetoEnMano.nombre() + ".png"
		return "Personaje/Jugador" + orientacion.nombre() + tareaEnMano.color() + ".png"
	}
	
	
//		ACCIONES
	method moverAlInicio() {
		self.orientacion(derecha)
		position = game.at(3,1)
	}
	
	override method moverse(nuevaPosicion) {
		super(nuevaPosicion)
		self.disminuirEnergia(2)
		pantallaJuego.hacerTurno()
	}
	
		method accionar(){
		position.allElements().forEach({elemento => elemento.interactuar()})
	}
	
	method interactuar(){}
	
	
//       CONSUMIBLES
	method aumentarEnergia(cantidad) {
		energia = (energia + cantidad).min(100)
	}
	
	method disminuirEnergia(cantidad) {
		energia = (energia - cantidad).max(0)
			if(energia == 0){
				game.clear()
				game.addVisual(fondoPerdioEnergia)
				game.schedule(250, {sonido.reproducir("Lost.wav")})
				game.schedule(8000, {game.stop()})
		}
	}


//		OBJETOS PERSONALES
	method agarrarMochila() {
		tieneMochila = true
	}
	
	method objetosEnMochila() = objetosEnMochila
	
	method guardarObjeto(unObjeto) {
		if(self.puedoGuardar()){
			objetosEnMochila.add(unObjeto)
			game.say(self, "Preciooosooo")
		}
		else{
			game.say(self, "¿En donde queres que lo guarde?")
		}
	}
	
	method puedoGuardar() = tieneMochila
	
	
//		ACCIONES POR ENTORNO (ESCONDERSE)
	method estaEscondido() = position == planta1.position() or position == planta2.position()

	method puedeEsconderse() = true
	
	method esAtravesable() = not(self.estaEscondido())


//	      TAREAS
	method agregarTarea(tarea) {
		tareaEnMano = tarea
	}
	
	method tareaEnMano() = tareaEnMano
		
	method terminarTarea(tarea) {
		tareaEnMano = sinTarea
		tareasRealizadas.add(tarea)
	}
	
	method quitarTarea(tarea) {
		tareasRealizadas.remove(tarea)
		tarea.reEntregar()
	}
	
	method entregoTarea(tarea) = tareasRealizadas.contains(tarea)
	
	method noTieneNingunaTarea() = self.tareaEnMano() == sinTarea
	
	
	method agarrarObjeto(objeto) {
		objetoEnMano = objeto
	}
	
	method entregarObjeto(companieri) {
		objetoEnMano = vacio
		companierisAyudados.add(companieri)
	}
	
	method objetoEnMano() = objetoEnMano
	
	method noTieneNingunObjeto() = self.objetoEnMano() == vacio
	
}
