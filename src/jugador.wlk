import wollok.game.*
import oficina.*
import configuraciones.*
import direcciones.*

object jugador inherits Personaje (position = game.at(3,1)) {
	//var property position = game.at(3,1)
	var property energia = 100
	var property orientacion = derecha
	const property tareasRealizadas = #{}
	const tareasPendientes = #{}
	
	method image() {
		if(self.estaEscondido())
			return "JugadorEscondido.png"
		return "Jugador" + orientacion.nombre() + ".png"
	}
	
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
		tareasPendientes.add(tarea)
	}
	
	method terminarTarea(tarea) {
		tareasPendientes.remove(tarea)
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
