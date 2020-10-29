import wollok.game.*
import pantallaJuego.*
import jugador.*
import jefe.*
import oficina.*
import objetivos.*


object contador {
	var property position = game.at(1,11)
	method image() = "ContadorTurnos/Contador" + pantallaJuego.cantidadTurnos().toString() + ".png"
}


class Tarjeta {
	var property position = game.at(15,10)
	var nombreTarjeta
	
	method image() = "Tarjetas/" + nombreTarjeta + ".png"
	
	method producirEfecto(){}
}

object mazoTarjeta inherits Tarjeta(nombreTarjeta = "Mazo") {
	var property mazoTarjetas = []
	
	method ponerTarjeta() {
		var tarjetaElegida = mazoTarjetas.anyOne()
		game.addVisual(tarjetaElegida)
		tarjetaElegida.producirEfecto()
		game.schedule(2000, {game.removeVisual(tarjetaElegida)})
	} 
	
}


object jefeAUnaImpresora inherits Tarjeta(nombreTarjeta = "JefeAImpresora"){
	const impresoras = [impresoraAzul, impresoraRojo, impresoraVerde]
	
	override method producirEfecto() {
		const posImpresora = impresoras.map({impresora => impresora.position()})
		jefe1.position(posImpresora.anyOne())
	}
}


object jefeACompanieri inherits Tarjeta(nombreTarjeta = "JefeACompanieri"){
	const companieris = [companieriAzul, companieriRojo, companieriVerde]
	
	override method producirEfecto() {
		const posCompanieri = companieris.map({companieri => companieri.position()})
		jefe1.position(posCompanieri.anyOne())
	}
}


object agregarEnergia inherits Tarjeta(nombreTarjeta = "AgregarEnergia"){
	var cantidad = 15
	
	method cantidad(unaCantidad) {
		cantidad = unaCantidad
	}
	
	override method producirEfecto() {
		jugador.aumentarEnergia(cantidad)
	}
}


object restaurarEnergia inherits Tarjeta(nombreTarjeta = "RestaurarEnergia") {
	
	override method producirEfecto() {
		jugador.energia(100)
	}
}


object perderEnergia inherits Tarjeta(nombreTarjeta = "PerderEnergia") {
	var porcentaje = 15
	
	method porcentaje(unPorcentaje) {
		porcentaje = unPorcentaje
	}
	
	override method producirEfecto() {
		const aRestar = (jugador.energia() * 15) /100
		jugador.disminuirEnergia(aRestar)
	}
}


object perderTarea inherits Tarjeta(nombreTarjeta = "PerderTarea"){
	
	override method producirEfecto() {
		if(not(jugador.tareasRealizadas().isEmpty())) {
			const tareaAPerder = jugador.tareasRealizadas().anyOne()
			jugador.quitarTarea(tareaAPerder)
		}
	}
}


object volverAlInicio inherits Tarjeta(nombreTarjeta = "VolverAlInicio") {
	
	override method producirEfecto() {
		jugador.moverAlInicio()
	}
}


