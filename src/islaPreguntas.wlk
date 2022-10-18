import wollok.game.*
import jugador.*
import config.*
import mundo.*

object islaPreguntas{
	const property image = "islaAcertijo.png"
	const property position = game.at(25,10) // 30, 17
	var completada = false
	
	method completarIsla() {
		completada = true
	}
	method estaCompletada() = completada
	
	method configIsla(){
		game.clear()
		stats.cambiarIsla(self)
		stats.cambiarPersonaje(new Personaje(image="luffyQuieto.jpg", position = game.at(0, game.height() / 2), positionAnterior = null))
		config.setPersonaje()
		config.config()
		config.actions()
		//bordes.crear()
	}
	
	method chocasteConJugador(){
		self.configIsla()
		self.cargar()
	}
	
	method cargar() {
		game.addVisualIn(mundo, game.center())
	}
}