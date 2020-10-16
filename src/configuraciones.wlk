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
		game.addVisual(planta)
		game.addVisual(jugador)
		configuraciones.configurarTeclas()
		configuraciones.configurarColisiones()
		jefe.moverse()
		//if(jugador.estaEscondido()){
			//jefe.moverseOpuesto()
		//}
	//	else{jefe.moverse()}
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

		keyboard.up().onPressDo({jugador.moverse(arriba)})
		keyboard.down().onPressDo({jugador.moverse(abajo)})
		keyboard.right().onPressDo({jugador.moverse(derecha)})
		keyboard.left().onPressDo({jugador.moverse(izquierda)})
		keyboard.s().onPressDo({jugador.usarImpresora()})
		keyboard.a().onPressDo({jugador.consumir()})
		keyboard.d().onPressDo({jugador.entregarTarea()})
		//keyboard.w().onPressDo({jugador.estaerEgg()})
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
	
	method moverse(direccion) {
		self.moverHaciaSiSePuede(self, direccion)
	}
	
	method moverHaciaSiSePuede(personaje, direccion) {
		if(direccion.puedeIr(personaje)){
			self.moverHacia(personaje, direccion)
		}
		else {
			personaje.error("No es por ahi man")
		}
	}
	
	method moverHacia(personaje, direccion) {
		const nuevaPosicion = direccion.posicion(personaje.position())
		personaje.orientacion(direccion)
		personaje.position(nuevaPosicion)
	}
	

}

	
	//method puedeMoverse(posicion) = posicion.allElements().all({objeto => objeto.esAtravesable()})
