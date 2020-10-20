import wollok.game.*
import jugador.*
import direcciones.*
import pantallaJuego.*
import sonidos.*

object jefe inherits Personaje(position = game.at(14,9)){
	var property orientacion = izquierda
	var dificultad
	
	method elegirDificultad(nuevaDificultad) {
		dificultad = nuevaDificultad
	}
	
	method image()="Jefe/Jefe" + orientacion.nombre() + ".png"
		
	method esAtravesable() = true
	
	method teEncontro() {
		if(position == jugador.position())
			pantallaJuego.terminar()
			game.addVisual(fondoJefeGano)
			sonido.reproducir("Lost.wav")
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
