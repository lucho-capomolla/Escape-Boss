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
		//game.clear()
	}
	
	method continuar(){
		self.cerrar()
		pantallaJuego.iniciar()
	}
	
	method image() = "pantallaInicio1.png"
	//jefe.elegirDificultad(DIFICULTAD SELECCIONADA)
	
}
