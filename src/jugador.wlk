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
	
	method moverHacia(personaje, direccion) {
		const nuevaPosicion = direccion.posicion(personaje.position())
		personaje.orientacion(direccion)
		personaje.position(nuevaPosicion)
	}
}


object jugador inherits Personaje (position = game.at(3,1)) {
	
	var property energia = 35
	var property orientacion = derecha
	const property tareasRealizadas = #{}
	var tareaEnMano = sinTarea
	
	
	method image() {
		if(self.estaEscondido())
			return "Personaje/Escondido.png"
		return "Personaje/Jugador" + orientacion.nombre() + tareaEnMano.color() + ".png"
	}
	
	override method moverse(nuevaPosicion) {
		super(nuevaPosicion)
		self.disminuirEnergia(1)
	}
	
//       CONSUMIBLES
	method consumir() {
		position.allElements().forEach({elemento=>elemento.serConsumido()})
	}
	
	method serConsumido(){}
	
	method aumentarEnergia(cantidad) {
		energia=(energia + cantidad).min(100)
	}
	
	method disminuirEnergia(cantidad) {
		energia=(energia - cantidad).max(0)
			if(energia==0){
				pantallaJuego.terminar()
				game.addVisual(fondoPerdioEnergia)
				game.schedule(500, {sonido.reproducir("Lost.wav")})
				game.schedule(5000, {game.stop()})
		}
	}


//		ACCIONES POR ENTORNO (ESCONDERSE)
	method estaEscondido() = position == planta.position()
		//if(position == planta.position()){
			//game.removeTickEvent("Perseguir")
			//jefe.correrse()
		//	return true
		//}
		//jefe.moverse()
		//return false
	//}

	

//	      TAREAS
	method usarImpresora() {
		position.allElements().forEach({impresora=>impresora.darCopia()})
	}
	
	method darCopia(){}
	
	method agregarTarea(tarea) {
		tareaEnMano = tarea
	}
	
	method entregarTarea() {
		position.allElements().forEach({companieri=>companieri.presentarTarea(tareaEnMano)})
	}
	
	method interactuar(){
		position.allElements().forEach({elemento => elemento.analizar()})
	}
	
	method analizar(){}
	
	method presentarTarea(tarea){}
	
	method terminarTarea(tarea) {
		tareaEnMano = sinTarea
		tareasRealizadas.add(tarea)
	}
	
}
