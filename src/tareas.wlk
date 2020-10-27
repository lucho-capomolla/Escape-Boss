import wollok.game.*
import oficina.*

class Tarea {
	var property position
	var estado = "Not"
	method image() = "Tareas/Tarea" + self.color() + estado + ".png"
	
	method color()
	
	method seEntrego(){
		estado = "Ok"
	}
	
	method reEntregar(){
		estado = "Not"
	}
}

object tareaAzul inherits Tarea(position = game.at(16,3)) {
	override method color() = "Azul"
}

object tareaRojo inherits Tarea(position = game.at(16,7)) {
	override method color() = "Rojo"
}

object tareaVerde inherits Tarea(position = game.at(16,5)) {
	override method color() = "Verde"
}

object sinTarea inherits Tarea {
	override method color() = ""
}