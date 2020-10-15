import wollok.game.*
import oficina.*
import configuraciones.*
import direcciones.*
import tareas.*

object jugador inherits Personaje (position = game.at(3,1)) {
	//var property position = game.at(3,1)
	var property energia = 100
	var property orientacion = derecha
	const property tareasRealizadas = #{}
	var tareaEnMano = sinTarea
	
	method image() {
		if(self.estaEscondido())
			return "Escondido.png"
		return "Personaje/Jugador" + orientacion.nombre() + tareaEnMano.color() + ".png"
	}
	
	// Agregar que el jugador cambie de imagen, de acuerdo a la tarea que lleva en su mano
	// Ej: JugadorDeFrente + tarea
	// Donde tarea puede ser Verde|Rojo|Azul o nada directamente
	
	override method moverHacia(nuevaPosicion) {
		//if(self.puedeMoverse(nuevaPosicion))
			//position = nuevaPosicion
		super(nuevaPosicion)
		self.disminuirEnergia(1)
	}
	
	//method puedeMoverse(posicion) = posicion.allElements().all({objeto => objeto.esAtravesable()})
	
	method aumentarEnergia(cantidad) {
		energia=(energia + cantidad).min(100)
	}
	
	method disminuirEnergia(cantidad) {
		energia=(energia - cantidad).max(0)
			if(energia==0){
		//game.say(self, "Sin energía")
		game.addVisual(fondoPerdedor)
		game.schedule(5000, {game.stop()})
		
		// Hacer que se bloqueen las teclas cuando se queda sin energia, sino muestra un mensaje de Error
		}
	}

	method estaEscondido() = position == planta.position()
	
	method estaEnLaPuerta() {
		if(position == puerta.position())
			puerta.escapar()
	}
	
	method usarImpresora() {
		position.allElements().forEach({impresora=>impresora.darCopia()})
	}
	
	method darCopia(){
	}
	
	method agregarTarea(tarea) {
		tareaEnMano = tarea
	}
	
	method terminarTarea(tarea) {
		tareaEnMano = sinTarea
		tareasRealizadas.add(tarea)
	}
	
	method presentarTarea() {
		
		// hacer una coleccion,donde tenga las 3 tareas asignadas por defecto, y otra coleccion, donde estan las tareas listas
		// una vez que ésta está lista, entregarla a su respectivo compañery.
		
		
		// Conviene que presente la tarea estando en la misma posicion, o que presente la tarea cuando se encuentra a la derecha
	}
	
	method consumir() {
		position.allElements().forEach({elemento=>elemento.serConsumido()})
	}
	
	method serConsumido(){
	}
}
