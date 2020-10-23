import wollok.game.*
import configuraciones.*
import pantallaJuego.*
import jugador.*
import oficina.*
import jefe.*
import tareas.*

class Nivel {
	
	method cargarNivel(){
		game.addVisual(cafeConLeche)
		game.addVisual(chocolate)
		game.addVisual(hamburguesa)
		game.addVisual(planta)
		
		game.addVisual(energiaJugador)
		//game.addVisual(tarjetas)
		
		game.addVisual(puerta)
		game.addVisual(cuadrito)
		game.addVisual(jugador)
		game.showAttributes(jugador)
		
		configuraciones.cambiarEstado(estadoJuego)
		configuraciones.configurarColisiones()
	}
	
	method finalizarNivel(){}
	
	method reiniciarElementos() {
		jugador.moverAlInicio()
		jugador.aumentarEnergia(100)
		self.reiniciarTareas()
	}
	
	method reiniciarTareas(){
		tareaAzul.reEntregar()
		tareaRojo.reEntregar()
		tareaVerde.reEntregar()
	}
}


object nivel1 inherits Nivel{
	const tareasNecesarias = #{tareaAzul, tareaVerde, tareaRojo}
	
	override method cargarNivel() {
				
		// Todo esto es propio del primer nivel
		game.addVisual(companieriAzul)
		game.addVisual(companieriRojo)
		game.addVisual(companieriVerde)
		game.addVisual(impresoraAzul)
		game.addVisual(impresoraRojo)
		game.addVisual(impresoraVerde)
		
		game.addVisual(tareaAzul)
		game.addVisual(tareaRojo)
		game.addVisual(tareaVerde)
		
		super()
		
		game.addVisual(jefe)
		jefe.moverse()
	}
	
	override method finalizarNivel(){
		if(tareasNecesarias == jugador.tareasRealizadas()){
			game.allVisuals().forEach({visual => game.removeVisual(visual)})
			//game.clear()
			pantallaJuego.avanzarNivel(nivel2)
			self.reiniciarElementos()
		}
		else{
			game.say(puerta, "Te faltan más tareas!")
		}
	}
}

object nivel2 inherits Nivel{
	const objetosNecesarios = #{}
	
	override method cargarNivel(){

		// Ademas de agregar objetos propios de este nivel. Los consumibles pueden ser los mismos del nivel anterior

		// Aca podria estar otra planta, y a su vez el otro jefe
		//game.addVisual(planta2)
		//game.addVisual(jefe2)
		//jefe2.moverse()
		super()
	}
	
	override method finalizarNivel(){
		if(objetosNecesarios == jugador.objetosEnMochila()){
			game.allVisuals().forEach({visual => game.removeVisual(visual)})
			pantallaJuego.avanzarNivel(nivel3)
			self.reiniciarElementos()
		}
		else{
			game.say(puerta, "Te faltan objetos!")
		}
	}
}


object nivel3 inherits Nivel{
	const tareasNecesarias = #{tareaAzul, tareaVerde, tareaRojo}
	const objetosNecesarios = #{}
	
	override method cargarNivel(){
		nivel1.cargarNivel()
		nivel2.cargarNivel()
		super()
	}
	
	override method finalizarNivel(){
		if(tareasNecesarias == jugador.tareasRealizadas() and objetosNecesarios == jugador.objetosEnMochila()){
			game.clear()
			pantallaJuego.terminarJuego()
		}
		else{
			game.say(puerta, "Todavía te faltan cosas, apurate!")
		}
	}
	
}
