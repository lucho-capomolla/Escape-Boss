import jugador.*
import wollok.game.*
import tarjetas.*
import oficina.*
import jefe.*
import direcciones.*

const ancho = 19
const altura = 12

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
	//method puedeMoverse(posicion) = posicion.allElements().all({objeto => objeto.esAtravesable()})
