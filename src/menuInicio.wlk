import wollok.game.*
import configuraciones.*
import pantallaJuego.*
import sonidos.*

object menuInicio {
	var musicaInicio = sonido.sonido("HouseOfTheRisingSun.mp3")
	
	method iniciar(){
		game.addVisualIn(self, game.origin())
		configuraciones.cambiarEstado(estadoMenuInicio)
		game.schedule(1, {musicaInicio.play()})
	}
	
	method cerrar(){
		game.allVisuals().forEach({visual => game.removeVisual(visual)})
	}
	
	method elegirDificultad(){
		configuraciones.cambiarEstado(estadoDificultad)
		game.addVisualIn(dificultades, game.origin())
	}
	
	method mostrarInstrucciones(){
		game.addVisualIn(instrucciones, game.origin())
		game.schedule(8000, {self.continuar()})
	}
	
	method continuar(){
		self.cerrar()
		musicaInicio.stop()
		pantallaJuego.iniciar()
	}
	
	method image() = "Fondos/MenuInicio.png"
}

object dificultades{
	
	method image() = "Fondos/MenuDificultades.png"
}

class Dificultad{
	var nivelDeDificultad
	method nivel() = nivelDeDificultad
}

object facil inherits Dificultad(nivelDeDificultad=2000){
}

object normal inherits Dificultad(nivelDeDificultad=1000){
}

object dificil inherits Dificultad(nivelDeDificultad=500){	
}


object instrucciones{
	
	method image() = "Fondos/Instrucciones.png"
}
