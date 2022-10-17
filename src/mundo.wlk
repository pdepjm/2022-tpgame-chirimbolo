import wollok.game.*
import jugador.*
import config.*
import islaEnemigos.*
import islaLaberinto.*
import islaPreguntas.*

object mundo{
	const islas = [islaEnemigos, islaLaberinto, islaPreguntas]
	const property image = "mar.jpg" // que sea un barquito asi cuando pasa por encima vuelve al mundo principal y queda re facha
	var property position
	
	method islas() = islas
	
	method mostrarIslas(){
		self.islas().forEach({isla => game.addVisual(isla)})
	}
	
	method estanTodasCompletadas() = islas.all({isla => isla.estaCompletada()})
	
	method completarIsla() {}
	method estaCompletada() = true
	
	method configIsla(){
		game.clear() // borra todo lo que hay en la pantalla
		jugador.cambiarIsla(self) // cambia la isla del jugador
		jugador.cambiarPersonaje(new Personaje(image="merry.jpg", position = game.center(), positionAnterior = null)) // cambia el personaje del jugador
		config.setPersonaje() // configura el personaje
		config.config() // configura la pantalla
		config.actions()
		self.mostrarIslas()
	}
	method cargar() {
		if (self.estanTodasCompletadas()) game.addVisual(moneda)
	}
	method chocasteConJugador() {
		jugador.islaActual().completarIsla()
		self.configIsla()
		self.cargar()
	}
}

object moneda {
	method image() = "moneda.jpg"
	method position() = game.at(9, 10)
	
	method chocasteConJugador() {
		jugador.ganaste()
	}
}

object bordes {
	/*method crear() {
		self.crearColumna(22, -1, -1)
		self.crearColumna(22, 35, -1)
		self.crearFila(35, 0, -1)
		self.crearFila(35, 0, 20)
	}*/
	
	method crearFila(cant, startingX, startingY) {
		cant.times({a => game.addVisual(new Bloque(image = "bloque.jpg", position = game.at(startingX - 1 + a, startingY)))})
	}
	
	method crearColumna(cant, startingX, startingY) {
		cant.times({a => game.addVisual(new Bloque(image = "bloque.jpg", position = game.at(startingX, startingY - 1 + a)))})
	}
	
	method estaEnBorde(position) = position.x() < 0 || position.x() > game.width() - 1 || position.y() < 0 || position.y() > game.height() - 1
}

class Bloque {
	var image
	var position
	
	method image() = image
	method position() = position
	
	method chocasteConJugador() {
		jugador.personajeActual().chocaBloque()
	}
	method chocasteConPiedra() {}
}
