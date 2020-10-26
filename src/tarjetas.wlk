import wollok.game.*
import pantallaJuego.*
import jugador.*
import jefe.*
import oficina.*



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
	const mazoTarjetas = [jefeAUnaImpresora, jefeACompanieri, agregarEnergia, restaurarEnergia, perderEnergia]
	
	method ponerTarjeta() {
		const tarjetaElegida = mazoTarjetas.anyOne()
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



// Cada 10 turnos, muestra una tarjeta, y se resetea el contador



	
	// Se podrian hacer muchas tarjetas, y que cada cierta cantidad de turnos, se levante una tarjeta de forma aleatoria
	// Y una vez levantada que muestre en pantalla su información, y active su efecto por 1 o mas turnos?
	
	
// OPCIONAL: Desaparece el jefe por 5 turnos

//El jefe vaya a una impresora
//El jefe vaya a un compañero
//Agregar 15 de energia
//Devolver 100% de energia
//Sacarnos 25% de energia