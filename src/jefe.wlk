import wollok.game.*
import jugador.*
import direcciones.*
import pantallaJuego.*

object jefe inherits Personaje(position = game.at(14,9)){
	var property orientacion = izquierda
	var dificultad = facil
	
	method elegirDificultad(nuevaDificultad) {
		dificultad = nuevaDificultad
	}
	
	method image()="Jefe" + orientacion.nombre() + ".png"
		
	method esAtravesable() = true
	
	method teEncontro() {
		if(position == jugador.position())
			//game.allVisuals().forEach({visual => game.removeVisual(visual)})
			game.clear()
			game.addVisual(fondoJefeGano)
			game.schedule(10000, {game.stop()})	
	}
	
	method potenciar(){
	}
	
	method moverse(){
		game.onTick(dificultad.nivel(), "Perseguir", {self.moverHaciaJugador()})
	}
	
	method moverseOpuesto(){
		game.onTick(2000, "Buscar", {self.moverOpuesto()})
	}
	
	method moverHaciaJugador(){
		var direccionMasConveniente = self.direccionMasConveniente(self.direccionesAtravesables())
		self.moverHaciaSiSePuede(self,direccionMasConveniente)	
	}
	
	method moverOpuesto(){
		var direccionMasConveniente = self.direccionMasConveniente(self.direccionesAtravesables())
		self.moverHaciaSiSePuede(self, direccionMasConveniente.opuesto())
	}
	
	
	method direccionMasConveniente(direcciones) = direcciones.min({ direccion => direccion.posicion(position).distance(jugador.position())}) 
	
	method direccionesAtravesables() = [izquierda, arriba, abajo, derecha]
		
}
