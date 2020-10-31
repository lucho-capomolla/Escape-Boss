import wollok.game.*
import jefe.*
import oficina.*
import jugador.*
import configuraciones.*
import objetivos.*
import sonidos.*
import tarjetas.*
import niveles.*

object pantallaJuego {

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
		musicaJuego.stop()
		sonido.reproducir("Yodelling.mp3")
		sonido.reproducir("TurnDownForWhat.mp3")
		game.clear()
		game.addVisual(fondoGanador)
		game.schedule(10000, {game.stop()})
	}
}

object fondoUltimoNivel {
	var property position = game.origin()
	method image() = "Fondos/FondoUltimoPiso.png"
}

object fondoNivel2 {
	var property position = game.origin()
	method image() = "Fondos/FondoPisosAltos.png"
}

object fondoPerdioEnergia{
	var property position = game.origin()
	method image() = "Fondos/GameOverEnergia.png"
}

object fondoJefe1Gano {
	var property position = game.origin()
	method image() = "Fondos/GameOverJefe1.png"
}

object fondoJefe2Gano {
	var property position = game.origin()
	method image() = "Fondos/GameOverJefe2.png"
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