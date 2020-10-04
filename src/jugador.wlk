import wollok.game.*

object jugador {
	var property position = game.at(3,2)
	var paciencia = 100

	method image() {
		return "JugadorDerechapng"
	}
	
	method moverA(nuevaPosicion) {
		position = nuevaPosicion
	}
	
	method consumirPotenciador(objeto) {
		objeto.potenciar(self)
	}
	
	method esconderse() {
		
		// tiene que estar colisionando con la planta, y cambia su imagen
	}
	
	method usarImpresora() {
		// para conseguir la tarea de una impresora particular
	}
	
	method presentarTarea() {
		
		// hacer una coleccion,donde tenga las 3 tareas asignadas por defecto, y otra coleccion, donde estan las tareas listas
		// una vez que ésta está lista, entregarla a su respectivo compañery.
	}
}
