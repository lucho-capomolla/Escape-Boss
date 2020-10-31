import wollok.game.*
import pantallaJuego.*
import jugador.*
import jefe.*
import oficina.*
import objetivos.*
import sonidos.*

/*
object contador {
	var property position = game.at(1,11)
	method image() = "ContadorTurnos/Contador" + pantallaJuego.cantidadTurnos().toString() + ".png"
}*/


class Tarjeta {
	var property position = game.at(15,10)
	var nombreTarjeta
	
	method image() = "Tarjetas/" + nombreTarjeta + ".png"
	
	method producirEfecto(){}
}

const mazo1 = [jefeAUnaImpresora, jefe1ACompanieri, agregarEnergia, restaurarEnergia, perderEnergia, perderTarea, volverAlInicio]
const mazo2 = [jefe2ACompanieri, agregarEnergia, restaurarEnergia, perderEnergia, volverAlInicio]
const mazo3 = [jefe1ACompanieri, jefe2ACompanieri, agregarEnergia, restaurarEnergia, perderEnergia, volverAlInicio, perderObjeto]

object mazoTarjeta {
	var property position = game.at(15,10)
	var property mazoTarjetas
	
	method image() = "Tarjetas/Mazo.png"
	
	method ponerTarjeta() {
		const tarjetaElegida = mazoTarjetas.anyOne()
		game.addVisual(tarjetaElegida)
		sonido.reproducir("Alerta.wav")
		tarjetaElegida.producirEfecto()
		game.schedule(2000, {if(game.hasVisual(tarjetaElegida)) {game.removeVisual(tarjetaElegida)}})
	} 
}


object jefeAUnaImpresora inherits Tarjeta(nombreTarjeta = "JefeAImpresora"){
	const impresoras = [impresoraAzul, impresoraRojo, impresoraVerde]
	const posImpresora = impresoras.map({impresora => impresora.position()})
	
	override method producirEfecto() {
		jefe1.position(posImpresora.anyOne())
	}
}


class JefeACompanieri inherits Tarjeta{
	const companieris = [companieriAzul, companieriRojo, companieriVerde]
	const posCompanieri = companieris.map({companieri => companieri.position()})
}

object jefe1ACompanieri inherits JefeACompanieri(nombreTarjeta = "JefeACompanieri"){
	
	override method producirEfecto() {
		jefe1.position(posCompanieri.anyOne())
	}
}

object jefe2ACompanieri inherits JefeACompanieri(nombreTarjeta = "JefeACompanieri") {
	
	override method producirEfecto() {
		jefe2.position(posCompanieri.anyOne())
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


object perderObjeto inherits Tarjeta(nombreTarjeta = "PerderObjeto") {
	
	override method producirEfecto() {
		if(not(jugador.objetosEnMochila().isEmpty())) {
			const objetoAPerder = jugador.objetosEnMochila().anyOne()
			jugador.quitarObjeto(objetoAPerder)
		}
	}
}


object perderPedido inherits Tarjeta(nombreTarjeta = "PerderPedido"){
	
	override method producirEfecto() {
		if(not(jugador.companierisAyudados().isEmpty())) {
			const companieriPerdido = jugador.companierisAyudados().anyOne()
			jugador.quitarPedido(companieriPerdido)
		}
	}
}


object jefeAMaquina inherits Tarjeta(nombreTarjeta = "JefeAMaquina") {
	const maquinas = [maquinaCafe, heladera]
	const posMaquinas = maquinas.map({maquina => maquina.position()})
	
	override method producirEfecto() {
		jefe2.position(posMaquinas.anyOne())
	}
}



class JefeAObjeto inherits Tarjeta {
	const objetos = [billetera, credencial, llaves, laptop, auriculares, celular]
	const posObjetos = objetos.map({objeto => objeto.position()})
}


object jefe1AObjeto inherits JefeAObjeto(nombreTarjeta = "JefeAObjeto") {
	
	override method producirEfecto() {
		const objetoVigilado = posObjetos.anyOne()
		if(game.hasVisual(objetoVigilado)){
			jefe1.position(objetoVigilado)
		}
	}
}

object jefe2AObjeto inherits JefeAObjeto(nombreTarjeta = "JefeAObjeto") {
	
	override method producirEfecto() {
		const objetoVigilado = posObjetos.anyOne()
		if(game.hasVisual(objetoVigilado)){
			jefe2.position(objetoVigilado)
		}
	}
}
 

