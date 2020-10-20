import wollok.game.*
import jefe.*
import oficina.*
import jugador.*
import configuraciones.*

object pantallaJuego {
	
	method iniciar() {
		configuraciones.cambiarEstado(estadoJuego)
		game.addVisual(puerta)
		game.addVisual(cafeConLeche)
		game.addVisual(chocolate)
		game.addVisual(hamburguesa)
		game.addVisual(jefe)
		game.addVisual(companieriAzul)
		game.addVisual(companieriRojo)
		game.addVisual(companieriVerde)
		game.addVisual(planta)
		game.addVisual(impresoraAzul)
		game.addVisual(impresoraRojo)
		game.addVisual(impresoraVerde)
		game.addVisual(jugador)
		game.showAttributes(jugador)
		configuraciones.configurarColisiones()
		jefe.moverse()
	}
	
	method terminar(){
		game.clear()
	}
}
	

object fondoPerdioEnergia{
	var property position = game.origin()
	method image() = "Fondos/GameOverEnergia.png"
}

object fondoJefeGano {
	var property position = game.origin()
	method image() = "Fondos/GameOverJefe.png"
}

object fondoGanador{
	var property position = game.origin()
	method image() = "Fondos/GoodEnding.png"
}

class Dificultad{
	var nivelDeDificultad
	method nivel()=nivelDeDificultad

}

object facil inherits Dificultad(nivelDeDificultad=2000){
}

object normal inherits Dificultad(nivelDeDificultad=1000){
}

object dificil inherits Dificultad(nivelDeDificultad=500){	
}