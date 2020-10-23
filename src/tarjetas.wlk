import wollok.game.*
import pantallaJuego.*

class Tarjeta {
	var cantidadTurnos = pantallaJuego.cantidadTurnos()
	
	method cantidadTurnos() = cantidadTurnos
	

}


object contador inherits Tarjeta {
	var property position = game.at(1,10)
	method image() = "Tarjetas/Contador.png"
	
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