import wollok.game.*
import jugador.*
import configuraciones.*

object jefe {
	var property position = game.at(14,9)
	var property image = "JefeIzquierda.png"
	
	method esAtravesable() = true
	
	method teEncontro() {
		if(position == jugador.position())
			game.addVisual(fondoJefeGano)
			game.schedule(10000, {game.stop()})	
	}
	
	method potenciar(){
	}
	
		
}
