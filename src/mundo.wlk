import wollok.game.*
import jugador.*
import config.*
import islaEnemigos.*
import islaLaberinto.*
import islaPreguntas.*

object mundo{
	const islas = [islaEnemigos, islaLaberinto, islaPreguntas]
	var property image = "trofeo.png" // que sea un barquito asi cuando pasa por encima vuelve al mundo principal y queda re facha
	var property position
	
	method islas() = islas
	
	method mostrarIslas(){
		self.islas().forEach({isla => 
			game.addVisual(isla) 
			isla.agregarBloques() 
			isla.bloquesInvisibles().forEach({bloque => game.addVisual(bloque)})
		})
	}
	
	method estanTodasCompletadas() = islas.all({isla => isla.estaCompletada()})
	
	method completarIsla() {}
	method estaCompletada() = true
	
	method configIsla(){
		stats.cambiarPersonaje(new Personaje(imagenOriginal="barco.png", position = game.at(6,9), positionAnterior = null)) // cambia el personaje del jugador
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
		self.configIsla()
		self.cargar()
	}
	method chocasteConPiedra() {}
	
	method ganaste() {
    	if (self.estanTodasCompletadas()) {
    		game.clear()
    		fondo.image("ganar.jpg")
    		game.addVisual(fondo)
    		game.schedule(5000, {game.stop()})
    	}
    }
}

object configBasicaIsla {
	method configuraciones(isla) {
		game.clear()
		fondo.position().drawElement(fondo)
		stats.cambiarIsla(isla)
		config.setPersonaje()
		config.configuracionesTecnicas()
		config.actions()
	}
	
	
}

object moneda {
	method image() = "moneda.png"
	method position() = game.at(9, 10)
	
	method chocasteConJugador() {
		mundo.ganaste()
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
		cant.times({a => game.addVisual(new Bloque(image = "bloque.png", position = game.at(startingX - 1 + a, startingY)))})
	}
	
	method crearColumna(cant, startingX, startingY) {
		cant.times({a => game.addVisual(new Bloque(image = "bloque.png", position = game.at(startingX, startingY - 1 + a)))})
	}
	method crearRio(cant, startingX, startingY) { // sabemos que son iguales, por favor no nos hagan modificar todos los mensajes del laberito :(
		cant.times({a => game.addVisual(new Bloque(image = "lava.png", position = game.at(startingX, startingY - 1 + a)))})
	} // cambiar imagen
	
	method estaEnBorde(position) = position.x() < 0 || position.x() > game.width() - 1 || position.y() < 0 || position.y() > game.height() - 1
}

class Bloque {
	var image
	var position
	
	method image() = image
	method position() = position
	
	method chocasteConJugador() {
		stats.personajeActual().chocaBloque()
	}
	method chocasteConPiedra() {}
}

class BloqueInvisible{
	var position
	var isla
	
	method position() = position
	
	method chocasteConJugador(){
		isla.chocasteConJugador()
	}
	
}







