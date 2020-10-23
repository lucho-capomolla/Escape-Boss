import wollok.game.*
import jefe.*
import oficina.*
import jugador.*
import configuraciones.*
import tareas.*
import niveles.*

object pantallaJuego {
	
	method iniciar() {
		niveles.nivel1()
	}
	
	method terminar(){
		game.clear()
	}
}
	

object fondoPerdioEnergia{
	var property position = game.origin()
	method image() = "Fondos/GameOverEnergia.png"
}

object fondoJefeGano {
	var property position = game.origin()
	method image() = "Fondos/GameOverJefe.png"
}

object fondoGanador{
	var property position = game.origin()
	method image() = "Fondos/Tomorrowland.png"
}


object energiaJugador {
	var property position = game.at(16,1)
	/*
	method image() { 
	if(jugador.energia().between(1,10)){ return "Energia/0.jpg"}
	if(jugador.energia().between(10,20)){ return "Energia/10.jpg"}
	if(jugador.energia().between(21,30)){ return "Energia/20.jpg"}
	if(jugador.energia().between(31,40)){ return "Energia/30.jpg"}
	if(jugador.energia().between(41,50)){ return "Energia/40.jpg"}
	if(jugador.energia().between(51,60)){ return "Energia/50.jpg"}
	if(jugador.energia().between(61,70)){ return "Energia/60.jpg"}
	if(jugador.energia().between(71,80)){ return "Energia/70.jpg"}
	if(jugador.energia().between(81,90)){ return "Energia/80.jpg"}
	if(jugador.energia().between(91,99)){ return "Energia/90.jpg"}
	else{
	return "Energia/100.jpg"}
	}
	*/
	method image() = "BarraEnergia/Energia" + self.energia() + ".png"
	
	method energia() = (jugador.energia()/10).roundUp().toString() 
	
}