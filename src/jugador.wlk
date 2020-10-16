import wollok.game.*
import oficina.*
import configuraciones.*
import direcciones.*
import tareas.*
import jefe.*

object jugador inherits Personaje (position = game.at(3,1)) {
	
	var property energia = 100
	var property orientacion = derecha
	const property tareasRealizadas = #{}
	var tareaEnMano = sinTarea
	
	
	method image() {
		if(self.estaEscondido())
			return "Escondido.png"
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
	
	method serConsumido(){
	}
	
	method aumentarEnergia(cantidad) {
		energia=(energia + cantidad).min(100)
	}
	
	method disminuirEnergia(cantidad) {
		energia=(energia - cantidad).max(0)
			if(energia==0){
		game.addVisual(fondoPerdedor)
		// Agregar un fondo particular cuando se pierda por quedarse sin energía
		game.schedule(5000, {game.stop()})
		
		// Hacer que se bloqueen las teclas cuando se queda sin energia, sino muestra un mensaje de Error
		}
	}


//		ACCIONES POR ENTORNO (ESCONDERSE)
	method estaEscondido() = position == planta.position()

	

//	      TAREAS
	method usarImpresora() {
		position.allElements().forEach({impresora=>impresora.darCopia()})
	}
	
	method darCopia(){
	}
	
	method agregarTarea(tarea) {
		tareaEnMano = tarea
	}
	
	method entregarTarea() {
		position.allElements().forEach({companieri=>companieri.presentarTarea(tareaEnMano)})
	}
	
	method presentarTarea(tarea){
	}
	
	method terminarTarea(tarea) {
		tareaEnMano = sinTarea
		tareasRealizadas.add(tarea)
	}
	
}
