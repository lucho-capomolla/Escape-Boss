import wollok.game.*
import configuraciones.*
import pantallaJuego.*

object menuInicio {
	
	method iniciar(){
		game.addVisualIn(self, game.at(3,1))
		configuraciones.cambiarEstado(estadoMenuInicio)
	}
	
	method cerrar(){
		game.allVisuals().forEach({visual => game.removeVisual(visual)})
	}
	
	method elegirDificultad(){
		configuraciones.cambiarEstado(estadoDificultad)
		game.addVisualIn(dificultades, game.at(3,1))
	}
	
	method mostrarInstrucciones(){
		game.addVisualIn(instrucciones, game.at(3,1))
		game.schedule(5000, {self.continuar()})
	}
	
	method continuar(){
		self.cerrar()
		pantallaJuego.iniciar()
	}
	
	method image() = "pantallaInicio1.png"
}

object dificultades{
	
	method image() = "pantallaInicio2.png"
}

object instrucciones{
	
	method image() = "pantallaInicio3.png"
}
