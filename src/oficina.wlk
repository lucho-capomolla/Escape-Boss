import wollok.game.*
import jugador.*
import objetivos.*
import jefe.*
import pantallaJuego.*
import sonidos.*
import niveles.*

class Consumible {
	var property position
	var energiaAportada
	const nombre
	
	method image() = "Oficina/" + nombre + ".png"

	method interactuar() {
		jugador.aumentarEnergia(energiaAportada)
		game.say(jugador, "Aumento la energia en " + energiaAportada.toString())
		game.removeVisual(self)
		sonido.reproducir("Burp.mp3")
	} 
	method teEncontro() = true

	method esAtravesable() = true
	
}

object cafeConLeche inherits Consumible (nombre = "Cafe", energiaAportada=25, position = game.at(3,5)) {}

object chocolate inherits Consumible (nombre = "Chocolate", energiaAportada=45, position = game.at(13,7)){}

object hamburguesa inherits Consumible (nombre = "Hamburguesa", energiaAportada=60, position = game.at(11,2)) {}

object pizza inherits Consumible (nombre = "Pizza", energiaAportada = 30, position = game.at(8,8)){}

object bebida inherits Consumible (nombre = "Bebida", energiaAportada = 20, position = game.at(10,5)){}

object rosquilla inherits Consumible (nombre = "Rosquilla", energiaAportada = 50, position = game.at(8,2)){}



// Mochila y Objetos personales
object mochila {
	var property position = game.center()
	
	method image() = "Oficina/Mochila.png"
	
	method interactuar() {
		jugador.agarrarMochila()
		game.removeVisual(self)
	}
	
	method teEncontro() = true
	
	method esAtravesable() = true
}

class ObjetoPersonal {
	var property position
	const nombre
	var estado
	var property guardado= false
	
	method estado() = estado
	
	method image() = "Oficina/" + nombre + ".png"
	
	method esAtravesable() = true
	
	method teEncontro() = true
	
	method interactuar() {
		if(jugador.puedoGuardar()){
			jugador.guardarObjeto(self)
			estado.encontrado()
			game.removeVisual(self)
			//sonido.reproducir("Guardar.mp3")
			self.estaGuardado()
		}
		else{
			game.say(jugador, "Necesito algo para guardarlo...")
		}
	}
	
	method estaGuardado(){
		guardado=true
	}
}

object billetera inherits ObjetoPersonal (position = game.at(3,2), nombre = "Billetera", estado = billeteraEstado){}

object celular inherits ObjetoPersonal (position = game.at(7,6), nombre = "Celular", estado = celularEstado){}

object credencial inherits ObjetoPersonal (position = game.at(14,1), nombre = "Credencial", estado = credencialEstado){}

object laptop inherits ObjetoPersonal (position = game.at(12,4), nombre = "Laptop", estado = laptopEstado){}

object llaves inherits ObjetoPersonal (position = game.at(7,9), nombre = "Llaves", estado = llavesEstado){}

object auriculares inherits ObjetoPersonal (position = game.at(12,8), nombre = "Auriculares", estado = auricularesEstado){} 



// Plantas
class Planta {
	var property position
	
	method image() = "Oficina/Planta.png"
	
	method teEncontro() = position == jugador.position()
	
	method interactuar() {
		jugador.error("Eto no eh comida papi")
	}
	
	method esAtravesable() = jugador.puedeEsconderse() and not(jefe1.puedeEsconderse())
}

object planta1 inherits Planta(position = game.at(3,6)){}

object planta2 inherits Planta(position = game.at(13,4)){}



// Impresoras
class Impresora {
	var property position
	var tarea
	const color
	const tipo
	
	method image() = "Oficina/Impresora" + tipo + color + ".png"
	
	method esAtravesable() = true
	
	method interactuar() {
		if(self.puedeImprimir()){
			jugador.agregarTarea(tarea)
			game.say(self, "Printer does BRRR BRRR")
			sonido.reproducir("Impresion.mp3")
		}
		else{
			game.say(self, "Hace falta magenta")
		}
	}
	
	method puedeImprimir() = not(jugador.entregoTarea(tarea))
		
	method teEncontro() = true
}

object impresoraAzul inherits Impresora (tipo = "A", color = "Azul", tarea = tareaAzul, position = game.at(3,3)) {}

object impresoraRojo inherits Impresora (tipo = "B", color = "Rojo", tarea = tareaRojo, position = game.at(9,4)) {}

object impresoraVerde inherits Impresora (tipo = "A", color = "Verde", tarea = tareaVerde, position = game.at(14,3)) {}


// Comestibles para compañeros
class Maquina {
	var property position
	const nombre
	const producto
	
	method image() = "Oficina/" + nombre + ".png"
	
	method esAtravesable() = true
	
	method teEncontro() = true
	
	method interactuar() {
		jugador.agarrarObjeto(producto)
		//sonido.reproducir("Take.mp3")
	}
}

object maquinaCafe inherits Maquina (position = game.at(6,10), nombre = "MaquinaCafe", producto = cafe){}

object heladera inherits Maquina (position = game.center(), nombre = "Heladerita", producto = helado){}



// Compañeros
class Companieri {
	var property position
	var tareaRequerida
	var pedido	
	var producto
	const color
	var property objetoEntregado = false
	var property tareaEntregada= false
	
	method image() = "Oficina/Companieri" + color + ".png"
	
	method esAtravesable() = true
	
	method generarPedido() {
		 pedido.tipo(producto.tipo())
	}
	
	method tipoProducto() = producto.tipo()
	
	method interactuar() {
		if(jugador.noTieneNingunaTarea() and jugador.noTieneNingunObjeto()) {
			game.say(self, "No me hagas perder el tiempo.")
		}
		else{
			if(jugador.noTieneNingunObjeto()){
				self.entregarTarea()
			}
			else{
				self.entregarObjeto()
			}
		}
	}
	
	method entregarTarea() {
		const tarea = jugador.tareaEnMano()
		
		if(tareaRequerida == tarea) {
			game.say(self, "Me has salvado! Estoy agradecido")
			jugador.terminarTarea(tarea)
			tarea.seEntrego()
			sonido.reproducir("Carpeta.mp3")
			self.tareaLista()
		}
		else{
			game.say(self, "Te equivocaste de tarea, papafrita")
		}
	}
	
	method tareaLista(){
		tareaEntregada=true
	}
	
	method entregarObjeto() {
		const objeto = jugador.objetoEnMano()
		
		if(producto == objeto and not(objetoEntregado)){
			game.say(self, "Gracias! Me salvaste la tarde")
			jugador.entregarObjeto(self)
			pedido.seEntrego()
			self.entregoObjeto()
		}
		else{
			game.say(self, "Gracias, pero no era lo que quería.")
		}
	}
	
	method entregoObjeto() {
		objetoEntregado = true
	}
	
	method teEncontro() = true
}

object companieriAzul inherits Companieri (color = "Azul", tareaRequerida = tareaAzul, producto = productos.anyOne(), pedido = pedidoAzul,  position = game.at(13,8)){}

object companieriRojo inherits Companieri (color = "Rojo", tareaRequerida = tareaRojo, producto = productos.anyOne(), pedido = pedidoRojo, position = game.at(6,4)){}

object companieriVerde inherits Companieri (color = "Verde", tareaRequerida = tareaVerde, producto = productos.anyOne(), pedido = pedidoVerde, position = game.at(3,8)){}



// Puerta y Ascensor
//		Posicion de salida
const salida = game.at(8,10)
class Salida {
	var property position = salida
	
	method avanzar() = pantallaJuego.nivelActual().finalizarNivel()
	
	method image() 
	
	method teEncontro() = self.avanzar()
	
	method esAtravesable() = true
}

object puerta inherits Salida {
	
	override method image() = "Oficina/Puerta.png"
}

object ascensor1 inherits Salida {
	
	override method image() = "Oficina/Ascensor1.png"
}

object ascensor2 inherits Salida {
	
	override method image() = "Oficina/Ascensor2.png"
}


// Muros
class Muro {
	var property position
	method esAtravesable() = false
	
	method image() = "Oficina/Vacio.png"
}

object muroHorizontal inherits Muro(position = game.at(6,7)){
	override method image() = "Oficina/MuroHorizontal.png"
	
	method agregarMurosHorizontales() {
		game.addVisual(self)
		game.addVisual(muroHorizontal2)
		game.addVisual(muroHorizontal3)
		game.addVisual(muroHorizontal4)
		game.addVisual(muroHorizontal5)
	}
}

object muroHorizontal2 inherits Muro(position = game.at(7,7)){}
object muroHorizontal3 inherits Muro(position = game.at(8,7)){}
object muroHorizontal4 inherits Muro(position = game.at(9,7)){}
object muroHorizontal5 inherits Muro(position = game.at(10,7)){}


object muroVertical inherits Muro(position = game.at(8,3)){
	override method image() = "Oficina/MuroVertical.png"
	
	method agregarMurosVerticales() {
		game.addVisual(self)
		game.addVisual(muroVertical2)
		game.addVisual(muroVertical3)
		game.addVisual(muroVertical4)
	}
}

object muroVertical2 inherits Muro(position = game.at(8,4)){}
object muroVertical3 inherits Muro(position = game.at(8,5)){}
object muroVertical4 inherits Muro(position = game.at(8,6)){}



// Easter Egg
object cuadrito {
	var property position = game.at(10,10)
	
	method image() = "Oficina/cuadro.png"
	
	method teEncontro() = position == jugador.position()
	
	method interactuar(){
		if(pantallaJuego.nivelActual()==nivel1){
		jefe1.esconderse()
		}else{ 
			if(pantallaJuego.nivelActual()==nivel2){
				jefe2.esconderse()
			}else{
				jefe1.esconderse()
				jefe2.esconderse()
				}
		}
		game.addVisual(carpinchito)
		game.schedule(2000, {game.removeVisual(carpinchito)})
	}
	
	method esAtravesable() = true
}

object carpinchito {
	var property position = game.origin()
	
	method image() = "Fondos/Carpinchito.jpg"
}