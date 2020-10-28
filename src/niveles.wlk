import wollok.game.*
import configuraciones.*
import pantallaJuego.*
import jugador.*
import oficina.*
import jefe.*
import tareas.*
import tarjetas.*

class Nivel {
	
	method cargarNivel(){
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
		//game.addVisual(impresoraAzul)	
		//game.addVisual(impresoraRojo)	
		//game.addVisual(impresoraVerde)
		muroHorizontal.agregarMurosHorizontales()
		muroVertical.agregarMurosVerticales()
		game.addVisual(cuadrito)	
		game.addVisual(jugador)	
		//game.addVisual(jefe1)	
		//jefe1.moverse()
		
		game.showAttributes(jugador)	
		game.addVisual(energiaJugador)	
		//game.addVisual(tareaAzul)	
		//game.addVisual(tareaRojo)	
		//game.addVisual(tareaVerde)
		game.addVisual(pikachu)
		game.addVisual(mazoTarjeta)
		configuraciones.configurarColisiones()	
		configuraciones.cambiarEstado(estadoJuego)
		
		game.onTick(9000, "Sacar tarjeta", {mazoTarjeta.ponerTarjeta()})
	}
	
	method finalizarNivel()
	
	method reiniciarElementos() {
		//game.removeTickEvent("Sacar tarjeta")
		jugador.moverAlInicio()
		jugador.aumentarEnergia(100)
	}
}


object nivel1 inherits Nivel{
	const tareasNecesarias = #{tareaAzul, tareaVerde, tareaRojo}
	
	override method cargarNivel() {
		
		// Todo esto es propio del primer nivel
		game.addVisual(impresoraAzul)
		game.addVisual(impresoraRojo)
		game.addVisual(impresoraVerde)
		
		game.addVisual(tareaAzul)
		game.addVisual(tareaRojo)
		game.addVisual(tareaVerde)
		
		super()
		
		game.addVisual(jefe1)
		jefe1.moverse()
	}
	
	override method finalizarNivel(){
		if(tareasNecesarias == jugador.tareasRealizadas()){
			game.allVisuals().forEach({visual => game.removeVisual(visual)})
			pantallaJuego.avanzarNivel(nivel2)
			self.reiniciarElementos()
			return true
		}
		else{
			game.say(puerta, "Te faltan más tareas, apurate!")
			return false
		}
	}
}

object nivel2 inherits Nivel{
	const companierisAyudados = #{companieriRojo, companieriAzul, companieriVerde}
	
	override method cargarNivel(){
		game.addVisual(fondoNivelSuperior)
		
		game.addVisual(maquinaCafe)
		game.addVisual(heladera)
		super()
		
		game.addVisual(jefe2)
		jefe2.moverse()
		
	}
	
	override method finalizarNivel(){
		if(companierisAyudados == jugador.companierisAyudados()){
			game.allVisuals().forEach({visual => game.removeVisual(visual)})
			pantallaJuego.avanzarNivel(nivel3)
			self.reiniciarElementos()
			return true
		}
		else{
			game.say(puerta, "Segui ayudando a tus compañeris!")
			return false
		}
	}
}


object nivel3 inherits Nivel{
	const objetosNecesarios = #{llaves, laptop, credencial, celular, auriculares, billetera}
	
	override method cargarNivel(){
		
		game.addVisual(mochila)
		game.addVisual(llaves)
		game.addVisual(laptop)
		game.addVisual(credencial)
		game.addVisual(celular)
		game.addVisual(auriculares)
		game.addVisual(billetera)
		
		super()
		
		game.addVisual(jefe1)
		game.addVisual(jefe2)
		jefe1.moverse()
		jefe2.moverse()
	}
	
	override method finalizarNivel(){
		if(objetosNecesarios == jugador.objetosEnMochila()){
			pantallaJuego.terminarJuego()
			return true
		}
		else{
			game.say(puerta, "Todavía te faltan cosas, apurate!")
			return false
		}
	}
	
}


/*
 * Fase 1: Entregar las 3 tareas
 * Fase 2: Entregar los objetos que pide el compañeri 
 * Fase 3: Buscar la mochila y buscar los 6 objetos personales, e irse (Laptop, Celular, Llaves, Billetera, Auriculares, Credencial)
 */

