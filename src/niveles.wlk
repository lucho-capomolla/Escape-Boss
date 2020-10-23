import wollok.game.*
import configuraciones.*
import pantallaJuego.*
import jugador.*
import oficina.*
import jefe.*
import tareas.*

object niveles {
	
	method nivel1() {
		configuraciones.cambiarEstado(estadoJuego)
		game.addVisual(puerta)
		game.addVisual(cafeConLeche)
		game.addVisual(chocolate)
		game.addVisual(hamburguesa)
		game.addVisual(companieriAzul)
		game.addVisual(companieriRojo)
		game.addVisual(companieriVerde)
		game.addVisual(planta)
		game.addVisual(impresoraAzul)
		game.addVisual(impresoraRojo)
		game.addVisual(impresoraVerde)
		game.addVisual(cuadrito)
		game.addVisual(jugador)
		game.addVisual(jefe)
		game.showAttributes(jugador)
		
		game.addVisual(energiaJugador)
		game.addVisual(tareaAzul)
		game.addVisual(tareaRojo)
		game.addVisual(tareaVerde)
		configuraciones.configurarColisiones()
		
		jefe.moverse()
	}
	
	
	method nivel2(){
		configuraciones.cambiarEstado(estadoJuego)
	}
	
	method nivel3(){
		
	}
	
	method avanzaNivel2(){
		self.terminarNivel1()
		self.nivel2()
	}
	
	method terminarNivel1(){
		game.allVisuals().forEach({visual => visual.removeVisual()})
		//o game.clear()
	}
}

