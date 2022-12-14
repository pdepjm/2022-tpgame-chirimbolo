import wollok.game.*
import jugador.*
import config.*
import islaEnemigos.*
import islaLaberinto.*
import islaPreguntas.*

const cancion = new Musica(theme = game.sound("mainSound.mp3"))

object mundo {

	const islasOriginales = [ islaEnemigos, islaLaberinto, islaPreguntas ]
	var islas = [ islaEnemigos, islaLaberinto, islaPreguntas ]
	var property image = "trofeo.png"
	var property position
	
	method islasOriginales() = islasOriginales
	
	method bloquesInvisibles() = null
	// estos dos methods son para que no me tire warnings innecesarias
	method agregarBloques() {}

	method mostrarIslas() {
		islas.forEach({ isla =>
			game.addVisual(isla)
			isla.agregarBloques()
			isla.bloquesInvisibles().forEach({ bloque => game.addVisual(bloque)})
		})
	}
	
	method reestablecerIslas() {
		islas = islasOriginales.copy()
    	islas.forEach({isla => isla.descompletar()})
	}

	method estanTodasCompletadas() = islasOriginales.all({ isla => isla.estaCompletada() })

	method completarIsla() {}

	method descompletar() {}

	method estaCompletada() = true

	method configIsla() {
		stats.cambiarPersonaje(new Personaje(imagenOriginal = "barco.png", position = game.at(15, 10), positionAnterior = null)) // cambia el personaje del jugador
		configBasicaIsla.configuraciones(self)
		self.mostrarIslas()
		fondo.image("fondoMar.png")
	}

	method cargar() {
		if (self.estanTodasCompletadas()) {
			game.addVisual(moneda)
			game.say(stats.personajeActual(), "Si agarro esa moneda brillante GANO!")
		}
	}

	method chocasteConJugador() {
		game.clear()
		stats.islaActual().completarIsla()
		islas.remove(stats.islaActual())
		islas.add(new Tick(position = stats.islaActual().position()))
		game.sound("agarrarTrofeo.mp3").play()
		self.configIsla()
		self.cargar()
	}

	method chocasteConPiedra() {}

	method ganaste() {
		if (self.estanTodasCompletadas()) {
			game.clear()
			fondo.image("ganar.png")
			game.addVisual(fondo)
			cancion.pause()
			const ganar = new Musica(theme = game.sound("ganar.mp3"))
			ganar.play()
			keyboard.r().onPressDo({
				config.restart() 
				menu.mostrar()
				ganar.stop()
			})
		}
	}
}

object configBasicaIsla {
	
	method configuraciones(isla) {
		game.clear()
		game.addVisual(fondo)
		stats.cambiarIsla(isla)
		config.setPersonaje()
		config.configuracionesTecnicas()
		config.actions()
	}
}

object moneda {

	var property position = game.at(9, 10)

	method image() = "moneda.png"

	method chocasteConJugador() {
		mundo.ganaste()
	}

}

object bordes {
	method crearFila(cant, startingX, startingY) {
		cant.times({ a => game.addVisual(new Bloque(image = "bloque.png", position = game.at(startingX - 1 + a, startingY)))})
	}

	method crearColumna(cant, startingX, startingY) {
		cant.times({ a => game.addVisual(new Bloque(image = "bloque.png", position = game.at(startingX, startingY - 1 + a)))})
	}

	method crearRio(cant, startingX, startingY) { // sabemos que son iguales, por favor no nos hagan modificar todos los mensajes del laberito :(
		cant.times({ a => game.addVisual(new Bloque(image = "lava.png", position = game.at(startingX, startingY - 1 + a)))})
	} // cambiar imagen

	method estaEnBorde(position) = position.x() < 0 || position.x() > game.width() - 1 || position.y() < 0 || position.y() > game.height() - 1
}

class BloqueAbstracto {
	var position

	method position() = position

	method chocasteConJugador() {}

	method chocasteConPiedra() {}
}

class Bloque inherits BloqueAbstracto {
	var image

	method image() = image

	override method chocasteConJugador() {
		stats.personajeActual().chocaBloque()
	}
}

class BloqueInvisible inherits BloqueAbstracto {
	var isla
	
	override method chocasteConJugador() {
		isla.chocasteConJugador()
	}
}

class BloqueInvisibleEnemigo inherits BloqueAbstracto {
	var enemigo
	
	override method chocasteConPiedra(){
		enemigo.chocasteConPiedra()
	}
	
	method actualizarPosicion(posicion) {
		position = game.at(position.x(), posicion.y() + 1)
	}
}

class Tick {

	var position

	method image() = "tick.png"

	method position() = position

	method chocasteConJugador() {
		game.say(stats.personajeActual(), "Esta isla ya la complete")
	}
	
	method agregarBloques() {}
	
	method bloquesInvisibles() = []
}

