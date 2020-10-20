import wollok.game.*
import configuraciones.*
import pantallaJuego.*
import sonidos.*

object menuInicio {
	
	method iniciar(){
		game.addVisualIn(self, game.origin())
		configuraciones.cambiarEstado(estadoMenuInicio)
	}
	
	method cerrar(){
		game.allVisuals().forEach({visual => game.removeVisual(visual)})
	}
	
	method elegirDificultad(){
		configuraciones.cambiarEstado(estadoDificultad)
		//confirmacion.play()
		game.addVisualIn(dificultades, game.origin())
	}
	
	method mostrarInstrucciones(){
		game.addVisualIn(instrucciones, game.origin())
		game.schedule(5000, {self.continuar()})
	}
	
	method continuar(){
		self.cerrar()
		pantallaJuego.iniciar()
	}
	
	method image() = "Fondos/MenuInicio.png"
}

object dificultades{
	
	method image() = "Fondos/MenuDificultades.png"
}

object instrucciones{
	
	method image() = "Fondos/pantallaInicio3.png"
}
