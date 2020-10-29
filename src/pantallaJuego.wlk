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
	var property cantidadTurnos = 0
	
	var nivelActual = nivel1
	
	method nivelActual() = nivelActual
	
	method iniciar() {
		nivelActual.cargarNivel()
	}
	
	method avanzarNivel(unNivel) {
		nivelActual = unNivel
		self.iniciar()
	}
	
	method hacerTurno() {
		cantidadTurnos += 1
	}
	
	method terminarJuego(){
		game.clear()
		game.addVisual(fondoGanador)
		sonido.reproducir("Yodelling.mp3")
		game.schedule(5000, {game.stop()})
	}
}

object fondoNivelSuperior {
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