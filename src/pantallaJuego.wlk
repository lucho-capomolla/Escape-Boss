import wollok.game.*
import jefe.*
import oficina.*
import jugador.*
import configuraciones.*

object pantallaJuego {
	
	method iniciar() {
		game.addVisual(puerta)
		game.addVisual(cafeConLeche)
		game.addVisual(chocolate)
		game.addVisual(hamburguesa)
		game.addVisual(jefe)
		game.addVisual(companieriAzul)
		game.addVisual(companieriRojo)
		game.addVisual(companieriVerde)
		game.addVisual(impresoraAzul)
		game.addVisual(impresoraRojo)
		game.addVisual(impresoraVerde)
		game.addVisual(planta)
		game.addVisual(jugador)
		configuraciones.configurarTeclas()
		configuraciones.configurarColisiones()
		jefe.moverse()
		//if(jugador.estaEscondido()){
			//jefe.moverseOpuesto()
		//}
	//	else{jefe.moverse()}
	}
}
	

object fondoPerdedor{
		var property position = game.at(3,1)
		method image() = "GameOver.png"
}

object fondoJefeGano {
	var property position = game.at(3,1)
	method image() = "GameOverJefe.png"
}


class Dificultad{
	var nivelDeDificultad
	method nivel()=nivelDeDificultad

}

object facil inherits Dificultad(nivelDeDificultad=3000){
	
}

object normal inherits Dificultad(nivelDeDificultad=2000){

}

object dificil inherits Dificultad(nivelDeDificultad=1000){
	
}