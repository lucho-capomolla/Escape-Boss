import wollok.game.*

class Consumible {
	
	// Todos los consumibles duran X cantidad de tiempo, ej game.onTick(5000, ...) serian 5 segundos
	// o podrian ser X turnos 
	method potenciar(jugador) {
		
	} 
	
}

object cafeConLeche inherits Consumible {
	
	// Ponele que este te reponga la paciencia
}

object barritaEnergetica inherits Consumible {
	
	// Este te hace ir 2 cuadraditos o dos pasos por cada movimiento
}

object llamadaAfip inherits Consumible {
	
	// Este hace que el jefe se quede bloqueado en su posicion por X turnos/segundos
}



object planta {
	
	// Hacer que el jugador se esconda en la planta por X turnos, y el jefe se aleja a la direccion contraria
	// Cuando ingresa a la planta, se cambia la imagen y el jefe no puede colisionar con el, averiguar como seria
}



object impresora {
	
	// 3 impresoras de diferente tipo, no se si conviene que haya una sola clase, e instanciarlas como diferentes
	// o hacer 3 objetos
}


object companieri {
	
	// El que te tira las Quest para ir a entregarle una tarea especifica
}