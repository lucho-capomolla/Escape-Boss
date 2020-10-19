import wollok.game.*
import configuraciones.*
import pantallaJuego.*

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
	
	method image() = "MenuInicio.png"
}

object dificultades{
	
	method image() = "MenuDificultades.png"
}

object instrucciones{
	
	method image() = "Instrucciones.png"
}
