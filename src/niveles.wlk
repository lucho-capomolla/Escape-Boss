import wollok.game.*
import configuraciones.*
import pantallaJuego.*
import jugador.*
import oficina.*
import jefe.*
import objetivos.*
import tarjetas.*

class Nivel {
	
	method cargarNivel(){
	
		muroHorizontal.agregarMurosHorizontales()
		muroVertical.agregarMurosVerticales()
		
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
		game.addVisual(cuadrito)	
		game.addVisual(jugador)	

		game.showAttributes(jugador)	
		game.addVisual(energiaJugador)	
		//game.addVisual(pikachu)
		game.addVisual(mazoTarjeta)
		configuraciones.configurarColisiones()	
		configuraciones.cambiarEstado(estadoJuego)
		
		game.onTick(10000, "Sacar tarjeta", {mazoTarjeta.ponerTarjeta()})
	}
	
	method finalizarNivel()
	
	method reiniciarElementos() {
		jefe1.volverAlInicio()
		jefe2.volverAlInicio()
		game.removeTickEvent("Sacar tarjeta")
		mazoTarjeta.mazoTarjetas([])
		jugador.moverAlInicio()
		jugador.aumentarEnergia(100)
	}
}


object nivel1 inherits Nivel{
	const tareasNecesarias = #{tareaAzul, tareaVerde, tareaRojo}
	
	override method cargarNivel() {
		game.addVisual(fondoNivelSuperior)
		game.addVisual(ascensor2)
		
		mazoTarjeta.mazoTarjetas([jefeAUnaImpresora, jefeACompanieri, agregarEnergia, restaurarEnergia, perderEnergia, perderTarea, volverAlInicio])
		
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
			self.reiniciarElementos()
			pantallaJuego.avanzarNivel(nivel2)
			return true
		}
		else{
			game.say(ascensor2, "Te faltan más tareas, apurate!")
			return false
		}
	}
}

object nivel2 inherits Nivel{
	const companierisAyudados = #{companieriRojo, companieriAzul, companieriVerde}
	
	override method cargarNivel(){
		game.addVisual(fondoNivelSuperior)
		game.addVisual(ascensor1)
		
		mazoTarjeta.mazoTarjetas([jefeACompanieri, agregarEnergia, restaurarEnergia, perderEnergia, volverAlInicio])
		
		self.inicializarPedidos()
		
		game.addVisual(maquinaCafe)
		game.addVisual(heladera)
		
		super()
		
		game.addVisual(jefe2)
		jefe2.moverse()
		
	}
	
	override method finalizarNivel(){
		if(companierisAyudados == jugador.companierisAyudados()){
			game.allVisuals().forEach({visual => game.removeVisual(visual)})
			self.reiniciarElementos()
			pantallaJuego.avanzarNivel(nivel3)
			return true
		}
		else{
			game.say(ascensor1, "Segui ayudando a tus compañeris!")
			return false
		}
	}
	
	method inicializarPedidos() {
		companieriRojo.generarPedido()
		game.addVisual(pedidoRojo)
		companieriAzul.generarPedido()
		game.addVisual(pedidoAzul)
		companieriVerde.generarPedido()
		game.addVisual(pedidoVerde)
	}
}


object nivel3 inherits Nivel{
	const objetosNecesarios = #{llaves, laptop, credencial, celular, auriculares, billetera}
	
	override method cargarNivel(){
		game.addVisual(puerta)
		mazoTarjeta.mazoTarjetas([jefeACompanieri, agregarEnergia, restaurarEnergia, perderEnergia, volverAlInicio])
		
		game.addVisual(contenidoMochila)
		self.prepararObjetos()
		
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
	
	method prepararObjetos() {
		game.addVisual(mochila)
		game.addVisual(llaves)
		game.addVisual(laptop)
		game.addVisual(credencial)
		game.addVisual(celular)
		game.addVisual(auriculares)
		game.addVisual(billetera)
		
		game.addVisual(auricularesEstado)
		game.addVisual(llavesEstado)
		game.addVisual(laptopEstado)
		game.addVisual(credencialEstado)
		game.addVisual(celularEstado)
		game.addVisual(billeteraEstado)
	}
	
}


/*
 * Fase 1: Entregar las 3 tareas
 * Fase 2: Entregar los objetos que pide el compañeri 
 * Fase 3: Buscar la mochila y buscar los 6 objetos personales, e irse (Laptop, Celular, Llaves, Billetera, Auriculares, Credencial)
 */

