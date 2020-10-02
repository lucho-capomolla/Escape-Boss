import wollok.game.*

object jugador {
	var property position = game.center()
	var paciencia = 100

	method image() {
		return "Jugador2.png"
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
	
	method presentarTarea() {
		
		// hacer una coleccion,donde tenga las 3 tareas asignadas por defecto, y otra coleccion, donde estan las tareas listas
		// una vez que ésta está lista, entregarla a su respectivo compañery.
	}
}
