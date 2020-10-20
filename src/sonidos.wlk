import wollok.game.*

object sonido{

	
	method sonido(audio) = game.sound("Sonidos/" + audio)
	
	method reproducir(audio) {
		self.sonido(audio).play()
	}
}
