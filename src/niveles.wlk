import wollok.game.*
import configuraciones.*
import pantallaJuego.*
import jugador.*
import oficina.*
import jefe.*
import objetivos.*
import tarjetas.*
import sonidos.*

const musicaJuego = sonido.sonido("MisionImposible.mp3")

class Nivel {
	var nivelPasado = false
	
	method nivelPasado() = nivelPasado
		
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
		game.addVisual(cuadrito1)	
		game.addVisual(jugador)	

		game.showAttributes(jugador)	
		game.addVisual(energiaJugador)	
	
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
	
	method pasarDeNivel() {
		nivelPasado = true
	}
}


object nivel1 inherits Nivel{
	const tareasNecesarias = #{tareaAzul, tareaVerde, tareaRojo}
	
	override method cargarNivel() {
		musicaJuego.play()
		game.addVisual(fondoUltimoNivel)
		game.addVisual(ascensor2)
		
		mazoTarjeta.mazoTarjetas(mazo1)
		
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
			self.pasarDeNivel()
			pantallaJuego.avanzarNivel(nivel2)
		}
		else{
			game.say(ascensor2, "Te faltan más tareas, apurate!")
		}
	}
}

object nivel2 inherits Nivel{
	const companierisAyudados = #{companieriRojo, companieriAzul, companieriVerde}
	
	override method cargarNivel(){
		game.addVisual(fondoNivel2)
		game.addVisual(ascensor1)
		
		mazoTarjeta.mazoTarjetas(mazo2)
		
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
			self.pasarDeNivel()
			pantallaJuego.avanzarNivel(nivel3)
		}
		else{
			game.say(ascensor1, "Segui ayudando a tus compañeris!")
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
		mazoTarjeta.mazoTarjetas(mazo3)
		game.addVisual(cuadrito2)
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
			self.pasarDeNivel()
			pantallaJuego.terminarJuego()
		}
		else{
			game.say(puerta, "Todavía te faltan cosas, apurate!")
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

