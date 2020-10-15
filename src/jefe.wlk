import wollok.game.*
import jugador.*
import configuraciones.*

object jefe inherits Personaje(position = game.at(14,9)){
	//var property position = game.at(14,9)
	var property image = "JefeIzquierda.png"
	
	method esAtravesable() = true
	
	//method moverA(nuevaPosicion) {
		//position = nuevaPosicion
	//}
	
	method teEncontro() {
		if(position == jugador.position())
			game.addVisual(fondoJefeGano)
			game.schedule(10000, {game.stop()})	
	}
	
	method potenciar(){
	}
	
	method moverse(){
		//game.onTick(2000, "Perseguir", {self.})
	}
		
}
