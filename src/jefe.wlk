import wollok.game.*
import jugador.*
import direcciones.*
import pantallaJuego.*
import sonidos.*
import oficina.*
import menuInicio.*

class Jefe inherits Personaje{
	var property orientacion
	var dificultad
	
	method elegirDificultad(nuevaDificultad) {
		dificultad = nuevaDificultad
	}
	
	
	
	
	
	override method moverHacia(personaje, direccion){
		const nuevaPosicion = direccion.posicion(personaje.position())
		if(self.puedeMoverse(nuevaPosicion)){
			personaje.orientacion(direccion)
			pikachu.position(personaje.position())
			personaje.position(nuevaPosicion)
		}
	}
	
	
	
	
	
	
	method esAtravesable() = true
	
	method teEncontro() {
		if(position == jugador.position())
			game.clear()
			self.mostrarFondo()
			game.schedule(250, {sonido.reproducir("Lost.wav")})
			game.schedule(8000, {game.stop()})	
	}
	
	method mostrarFondo(){}
	
	method puedeEsconderse() = false
	
	method esconderse() {
		self.dejarDePerseguir()
		game.schedule(2000, {self.moverse()})
	}
	
	method moverse(){
		game.onTick(dificultad.nivel(), "Perseguir", {self.perseguir()})
	}
	
	method dejarDePerseguir(){
		game.removeTickEvent("Perseguir")
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
	
	method direccionesAtravesables() = [izquierda, arriba, abajo, derecha].filter({direccion => direccion.puedeIr(self)})
		
}


object jefe1 inherits Jefe(position = game.at(14,1), orientacion = izquierda) {
	
	method image() = "Jefe/Jefe1" + orientacion.nombre() + ".png"
	
	override method mostrarFondo() {
		game.addVisual(fondoJefeGano)
	}
}

object jefe2 inherits Jefe(position = game.at(14,10), orientacion = izquierda) {
	
	method image() = "Jefe/Jefe2" + orientacion.nombre() + ".png"
	
	override method teEncontro() {
		game.addVisual(fondoJefeGano)
		super()
	}
}



object pikachu {
	var property position = game.origin()
	
	method image() = "Oficina/Vacio.png"
	
	method esAtravesable() = false
}
