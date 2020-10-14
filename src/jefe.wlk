import wollok.game.*
import jugador.*
import configuraciones.*

object jefe {
	var property position = game.at(14,9)
	var property image = "JefeIzquierda.png"
	
	method esAtravesable() = true
	
	method teEncontro() {
		if(position == jugador.position())
			//game.say(self, "Asi te queria agarrar chinwenwencha!")
			game.addVisual(fondoPerdedor)
			game.addVisual(fondoJefeGano)
			game.schedule(5000, {game.stop()})
			
			// Tal vez podria hacerse que en esa pantalla de Game Over, se pueda poner al Jefe y al jugador todo gris
			// y al jefe tirando ese comentario
			
			
	}
	
	method potenciar(){
	}
	
	// El jefe te persigue de acuerdo a la posicion en la que te encontras, y si choca con algo que no es atravesable, que se dirija a la posicion donde
	// PUEDE MOVERSE
		
}
