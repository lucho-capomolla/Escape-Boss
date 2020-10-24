import wollok.game.*
import jefe.*
import oficina.*
import jugador.*
import configuraciones.*
import tareas.*
import sonidos.*
import tarjetas.*

object pantallaJuego {
	var property cantidadTurnos = 0
	/*
	var nivelActual = nivel1
	
	method nivelActual() = nivelActual
	
	method iniciar() {
		nivelActual.cargarNivel()
	}
	
	method avanzarNivel(unNivel) {
		nivelActual = unNivel
		self.iniciar()
	}
	
	method terminarJuego(){
		game.addVisual(fondoGanador)
		sonido.reproducir("Yodelling.mp3")
		game.schedule(5000, {game.stop()})
	}*/
	
	method iniciar() {
		
		game.addVisual(puerta)	
		game.addVisual(cafeConLeche)	
		game.addVisual(chocolate)	
		game.addVisual(hamburguesa)	
		game.addVisual(rosquilla)
		game.addVisual(bebida)
		game.addVisual(pizza)
		game.addVisual(companieriAzul)	
		game.addVisual(companieriRojo)	
		game.addVisual(companieriVerde)	
		game.addVisual(planta1)
		game.addVisual(planta2)	
		game.addVisual(impresoraAzul)	
		game.addVisual(impresoraRojo)	
		game.addVisual(impresoraVerde)
		muroHorizontal.agregarMurosHorizontales()
		muroVertical.agregarMurosVerticales()
		game.addVisual(cuadrito)	
		game.addVisual(jugador)	
		game.addVisual(jefe1)	
		jefe1.moverse()
		
		game.showAttributes(jugador)	
		game.addVisual(energiaJugador)	
		game.addVisual(tareaAzul)	
		game.addVisual(tareaRojo)	
		game.addVisual(tareaVerde)	
		game.addVisual(pikachu)
		
		configuraciones.configurarColisiones()	
		configuraciones.cambiarEstado(estadoJuego)
		
	}
	
	method hacerTurno() {
		cantidadTurnos += 1
	}
	
	method terminarJuego(){
		jefe1.dejarDePerseguir()
		game.addVisual(fondoGanador)
		sonido.reproducir("Yodelling.mp3")
		game.schedule(5000, {game.stop()})
	}
}

object fondoPerdioEnergia{
	var property position = game.origin()
	method image() = "Fondos/GameOverEnergia.png"
}

object fondoJefeGano {
	var property position = game.origin()
	method image() = "Fondos/GameOverJefe.png"
}

object fondoGanador{
	var property position = game.origin()
	method image() = "Fondos/Tomorrowland.png"
}


object energiaJugador {
	var property position = game.at(16,1)
	
	method image() = "BarraEnergia/Energia" + self.energia() + ".png"
	
	method energia() = (jugador.energia()/10).roundUp().toString() 
	
}