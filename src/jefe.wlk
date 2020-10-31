import wollok.game.*
import jugador.*
import direcciones.*
import pantallaJuego.*
import sonidos.*
import oficina.*
import menuInicio.*
import niveles.*

class Jefe inherits Personaje{
	var property orientacion
	var dificultad
	
	method elegirDificultad(nuevaDificultad) {
		dificultad = nuevaDificultad
	}
	
	
	
	
	/* 
	override method moverHacia(personaje, direccion){
		const nuevaPosicion = direccion.posicion(personaje.position())
		if(self.puedeMoverse(nuevaPosicion)){
			personaje.orientacion(direccion)
			pikachu.position(personaje.position())
			personaje.position(nuevaPosicion)
		}
	}*/
	
	
	
	method volverAlInicio() {}
	
	method esAtravesable() = true
	
	method teEncontro() {
		if(position == jugador.position()){
			musicaJuego.stop()
			game.clear()
			self.mostrarFondo()
			sonido.reproducir("Lost.wav")
			sonido.reproducir("MadWorld.mp3")
			game.schedule(12000, {game.stop()})	
			
			}
	}
	
	method mostrarFondo(){}
	
	method puedeEsconderse() = false
	
	method esconderse() {
		self.dejarDePerseguir()
		game.schedule(4000, {self.moverse()})
	}
	
	method moverse(){}
	
	method dejarDePerseguir(){}
	
	method perseguir(){
		if(jugador.estaEscondido()){
			self.irASalida()
		}
		else{
			self.moverHaciaJugador()
		}
	}
	
	method moverHaciaJugador(){
		var direccionMasConveniente = self.direccionMasConveniente(self.direccionesAtravesables())
		self.moverHaciaSiSePuede(self,direccionMasConveniente)	
	}
	
	method irASalida(){
		const direccionAPuerta = self.perritoGuardian(self.direccionesAtravesables())
		self.moverHaciaSiSePuede(self, direccionAPuerta)
	}

	method direccionMasConveniente(direcciones) = direcciones.min({ direccion => direccion.posicion(position).distance(jugador.position())}) 
	
	method perritoGuardian(direcciones) = direcciones.min({direccion => direccion.posicion(position).distance(salida)})
	
	method direccionesAtravesables() = [izquierda, arriba, abajo, derecha].filter({direccion => direccion.puedeIr(self)})
		
}


object jefe1 inherits Jefe(position = game.at(14,1), orientacion = izquierda) {
	
	method image() = "Jefe/Jefe1" + orientacion.nombre() + ".png"
	
	override method volverAlInicio() {
		position = game.at(14,1)
	}
	
	override method moverse() {
		game.onTick(dificultad.nivel(), "Perseguir1", {self.perseguir()})
	}
	
	override method dejarDePerseguir() {
		game.removeTickEvent("Perseguir1")
	}
	
	override method mostrarFondo() {
		game.addVisual(fondoJefe1Gano)
	}
}

object jefe2 inherits Jefe(position = game.at(14,10), orientacion = izquierda) {
	
	method image() = "Jefe/Jefe2" + orientacion.nombre() + ".png"
	
	override method volverAlInicio() {
		position = game.at(14,10)
	}
	
	override method moverse() {
		game.onTick(dificultad.nivel(), "Perseguir2", {self.perseguir()})
	}
	
	override method dejarDePerseguir() {
		game.removeTickEvent("Perseguir2")
	}
	
	override method mostrarFondo() {
		game.addVisual(fondoJefe2Gano)
	}
}


/*
object pikachu {
	var property position = game.origin()
	
	method image() = "Oficina/Vacio.png"
	
	method esAtravesable() = false
}*/
