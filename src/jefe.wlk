import wollok.game.*
import jugador.*
import configuraciones.*
import direcciones.*

object jefe inherits Personaje(position = game.at(14,9)){
	var property orientacion = izquierda
	
	method image()="Jefe" + orientacion.nombre() + ".png"
		
	method esAtravesable() = true
	
	method teEncontro() {
		if(position == jugador.position())
			game.addVisual(fondoJefeGano)
			game.schedule(10000, {game.stop()})	
	}
	
	method potenciar(){
	}
	
	method moverse(){
		game.onTick(1000, "Perseguir", {self.moverHaciaJugador()})
	}
	
	method moverHaciaJugador(){
	var direccionMasConveniente = self.direccionMasConveniente(self.direccionesAtravesables())
	self.moverHaciaSiSePuede(self,direccionMasConveniente)	
	}
	
	method direccionMasConveniente(direcciones)=direcciones.min({ direccion => direccion.posicion(position).distance(jugador.position()) }) 
	
	method direccionesAtravesables() = [izquierda, arriba, abajo, derecha]
		
}
