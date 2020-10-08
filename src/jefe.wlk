import wollok.game.*
import jugador.*

object jefe {
	var property position = game.at(14,9)
	
	method image() = "JefeIzquierda.png"
	
	
	method teEncontro() {
		if(position == jugador.position())
			game.say(self, "Asi te queria agarrar chinwenwencha!")
			game.schedule(2000, {game.stop()})
	}
	
	// El jefe te persigue de acuerdo a la posicion en la que te encontras, y si choca con algo que no es atravesable, que se dirija a la posicion donde
	// PUEDE MOVERSE
	
}
