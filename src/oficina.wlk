import wollok.game.*
import jugador.*

class Consumible {
	var energiaAportada

	// Todos los consumibles duran X cantidad de tiempo, ej game.onTick(5000, ...) serian 5 segundos
	// o podrian ser X turnos 

	method serConsumido() {
		jugador.aumentarEnergia(energiaAportada)
		game.say(jugador, "Aumento la energia en " + energiaAportada)
		game.removeVisual(self)
	} 
	method teEncontro() = true

	method esAtravesable() = true
	
	method image()
	
	method position()
}


object cafeConLeche inherits Consumible (energiaAportada=20) {
	
	override method image() = "Cafe.png"
	
	override method position() = game.at(7,7)
}

object chocolate inherits Consumible (energiaAportada=35){
	
	override method image() = "chocolate.png"
	
	override method position() = game.at(13,8)
}

object hamburguesa inherits Consumible (energiaAportada=50) {
	
	override method image() = "hamburguesa.png"
	
	override method position() = game.at(11,2)
}



object planta {
	
	var property position = game.at(9,3)
	
	method image() = "pepita.png"
	
	method teEncontro() = position == jugador.position()
	
	method serConsumido() {
		jugador.error("Eto no eh comida papi")
	}
	
	method potenciar(){
	}
	
	method esAtravesable() = true
	
}


class Impresora {
	method esAtravesable() = false
}

object impresoraAzul inherits Impresora {
	var property position = game.at(3,5)
	
	method image() = "ImpresoraAzul.png"
}

object impresoraRojo inherits Impresora {
	var property position = game.at(8,2)
	
	method image() = "ImpresoraRojo.png"
}

object impresoraVerde inherits Impresora {
	var property position = game.center()
	
	method image() = "ImpresoraVerde.png"
}


class Companieri {
	
	method esAtravesable() = false
}

object companieriAzul inherits Companieri {
	var property position = game.at(13,5)
	
	method image() = "CompanieriAzul.png"
}

object companieriRojo inherits Companieri {
	var property position = game.at(6,4)
	
	method image() = "CompanieriRojo.png"
}

object companieriVerde inherits Companieri {
	var property position =game.at(3,8)
	
	method image() = "CompanieriVerde.png"
}




object puerta {
	var property position = game.at(8,9)
	
	method image() = "puerta.png"
	
	method teEncontro() = true
	
	method potenciar(){
	}
	
	method esAtravesable() = true
	// cuando colisione, que haya un if donde verifique si tiene las 3 tareas completadas, si no es asi, no sucede nada
	// recien puede terminar el juego cuando tenga las tareas terminadas
}