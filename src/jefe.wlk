import wollok.game.*
import jugador.*
import direcciones.*
import pantallaJuego.*
import sonidos.*
import oficina.*
import menuInicio.*

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

	method puedeEsconderse() = false
	
	method moverse(){
		game.onTick(dificultad.nivel(), "Perseguir", {self.perseguir()})
	}
	
	method perseguir(){
		if(jugador.estaEscondido()){
			self.irAPuerta()
		}
		else{
			self.moverHaciaJugador()
		}
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
	
	//filter direcciones -> si la posicion que vas a caer es atravesable
	
	method direccionesAtravesables() = [izquierda, arriba, abajo, derecha]
	//method direccionesAtravesables() = [izquierda, arriba, abajo, derecha].filter({posicion => posicion.esAtravesable()})
	//method direccionesAtravesables() = [izquierda, arriba, abajo, derecha].filter({posicion => posicion.allElements().forEach({elemento => elemento.esAtravesable()})})
		
}
