import wollok.game.*
import jugador.*
import direcciones.*
import pantallaJuego.*
import sonidos.*
import oficina.*

object jefe inherits Personaje(position = game.at(14,1)){
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
			game.schedule(250, {sonido.reproducir("Lost.wav")})
			game.schedule(10000, {game.stop()})	
	}
	
	method moverse(){
		game.onTick(dificultad.nivel(), "Perseguir", {self.moverHaciaJugador()})
	}
		/*game.onTick(dificultad.nivel(), "Perseguir", {self.moverHaciaJugador()})
		if(jugador.estaEscondido()){
			game.removeTickEvent("Perseguir")
			game.onTick(dificultad.nivel(), "Buscar", {self.irAPuerta()})
		}
		else{
			game.onTick(dificultad.nivel(), "Perseguir", {self.moverHaciaJugador()})
		}*/
	
	
	method correrse(){
		game.removeTickEvent("Perseguir")
		game.onTick(dificultad.nivel(), "Buscar", {self.irAPuerta()})
	}
	
	method moverHaciaJugador(){
		var direccionMasConveniente = self.direccionMasConveniente(self.direccionesAtravesables())
		self.moverHaciaSiSePuede(self,direccionMasConveniente)	
	}
	
	method irAPuerta(){
		const direccionAPuerta = self.perritoGuardian(self.direccionesAtravesables())
		self.moverHaciaSiSePuede(self, direccionAPuerta)
	}
	
	
	method direccionMasConveniente(direcciones) = direcciones.min({ direccion => direccion.posicion(position).distance(jugador.position())}) 
	
	method perritoGuardian(direcciones) = direcciones.min({direccion => direccion.posicion(position).distance(puerta.position())})
	
	method direccionesAtravesables() = [izquierda, arriba, abajo, derecha]
		
}
