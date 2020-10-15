import jugador.*
import wollok.game.*
import tarjetas.*
import oficina.*
import jefe.*
import direcciones.*

const ancho = 19
const altura = 12

object prueba {	
	
	method iniciar() {
		game.addVisual(puerta)
		game.addVisual(cafeConLeche)
		game.addVisual(chocolate)
		game.addVisual(hamburguesa)
		game.addVisual(jefe)
		game.addVisual(companieriAzul)
		game.addVisual(companieriRojo)
		game.addVisual(companieriVerde)
		game.addVisual(impresoraAzul)
		game.addVisual(impresoraRojo)
		game.addVisual(impresoraVerde)
		game.addVisual(jugador)
		game.addVisual(planta)
		configuraciones.configurarTeclas()
		configuraciones.configurarColisiones()
	}
}

object fondoPerdedor{
		var property position = game.at(3,1)
		method image() = "GameOver.png"
}

object fondoJefeGano {
	var property position = game.at(3,1)
	method image() = "GameOverJefe.png"
}

object configuraciones {
	
	method configurarTeclas() {
	
		//keyboard.up().onPressDo({arriba.moverse(1)})
		//keyboard.down().onPressDo({abajo.moverse(1)})
		//keyboard.right().onPressDo({derecha.moverse(1)})
		//keyboard.left().onPressDo({izquierda.moverse(1)})
		keyboard.up().onPressDo({jugador.moverHacia(arriba)})
		keyboard.down().onPressDo({jugador.moverHacia(abajo)})
		keyboard.right().onPressDo({jugador.moverHacia(derecha)})
		keyboard.left().onPressDo({jugador.moverHacia(izquierda)})
		keyboard.d().onPressDo({jugador.usarImpresora()})
		keyboard.c().onPressDo({jugador.consumir()})
	
		// Que pueda interactuar con el cuadro del carpincho?
		
		// Turno: Que el jugador se mueva durante su turno, y el Jefe durante el suyo -> ESTE TURNO = Tiempo, Cantidad de movimientos o Al tocar una Tecla
		// Etapa siguiente <- Pensarlo bien bien
	}
	
	method configurarColisiones() {
		game.onCollideDo(jugador, {algo => algo.teEncontro()})
	}	
}


class Personaje {
	var property position
	var property estiloDeMovimiento = normal
	
	method moverHacia(direccion) {
		estiloDeMovimiento.moverHaciaSiSePuede(self, direccion)
	}
}

object normal {
	
	method moverHacia(personaje, direccion) {
		const nuevaPosicion = direccion.posicion(personaje.position())
		personaje.orientacion(direccion)
		personaje.position(nuevaPosicion)
	}
	
	method moverHaciaSiSePuede(personaje, direccion) {
		if(direccion.puedeIr(personaje)){
			self.moverHacia(personaje, direccion)
		}
		else {
			personaje.error("No es por ahi man")
		}
	}
	
	method puedeMoverse(posicion) = posicion.allElements().all({objeto => objeto.esAtravesable()})
}
