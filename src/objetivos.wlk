import wollok.game.*
import oficina.*

//	NIVEL 1
class Tarea {
	var property position
	var estado = "Not"
	var property color = ""
	
	method image() = "Objetivos/Tarea" + color + estado + ".png"
	
	method seEntrego(){
		estado = "Ok"
	}
	
	method reEntregar(){
		estado = "Not"
	}
}

object tareaAzul inherits Tarea(position = game.at(16,3), color = "Azul") {}

object tareaRojo inherits Tarea(position = game.at(16,7), color = "Rojo") {}

object tareaVerde inherits Tarea(position = game.at(16,5), color = "Verde") {}

object sinTarea inherits Tarea {}


//	NIVEL 2
class Pedido inherits Tarea{
	var property tipo
	
	override method image() = "Objetivos/Pedido" + color + tipo + estado + ".png"
}

const productos = [helado, cafe]

object helado inherits Pedido(tipo = "Helado") {}

object cafe inherits Pedido(tipo = "Cafe") {}


object pedidoAzul inherits Pedido(position = game.at(16,3), color = "Azul") {}

object pedidoRojo inherits Pedido(position = game.at(16,7), color = "Rojo") {}

object pedidoVerde inherits Pedido(position = game.at(16,5), color = "Verde") {}

object vacio inherits Pedido{}


//	NIVEL 3
object contenidoMochila {
	var property position = game.at(16,3)
	
	method image() = "Objetivos/ContenidoMochila.png"
}

class ObjetoEstado {
	var property position = game.at(16,3)
	var nombre
	var estado = "Not"
	
	method image() = "Objetivos/" + nombre + estado + ".png"
	
	method encontrado() {
		estado = "Ok"
	}
	
}

object auricularesEstado inherits ObjetoEstado(nombre = "Auriculares") {}

object llavesEstado inherits ObjetoEstado(nombre = "Llaves") {}

object laptopEstado inherits ObjetoEstado(nombre = "Laptop") {}

object credencialEstado inherits ObjetoEstado(nombre = "Credencial") {}

object celularEstado inherits ObjetoEstado(nombre = "Celular") {}

object billeteraEstado inherits ObjetoEstado(nombre = "Billetera") {} 




