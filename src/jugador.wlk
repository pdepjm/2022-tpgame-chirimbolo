import wollok.game.*
import mundo.*
import config.*
import islaEnemigos.*

object stats {
	var personajeActual = null
	var islaActual = null
	const vida = [cora1, cora2, cora3, cora4, cora5]
	
	method personajeActual() = personajeActual
    method islaActual() = islaActual
	method vida() = vida

    method cambiarPersonaje(personaje) {personajeActual = personaje}
    method cambiarIsla(isla) {islaActual = isla}
    
    method perderVida() {
    	game.say(self.personajeActual(), "AUCH!")
    	self.borrarVidas()
    	self.restarVida()
    	self.perdiste()
    	self.mostrarVidas()
    }
    method restarVida() { // es para los tests
    	vida.remove(vida.last())
    }
    method borrarVidas() {
    	game.sound("perderVida.mp3").play()
    	vida.forEach({cora => game.removeVisual(cora)})
    }
    method mostrarVidas() {
    	vida.forEach({cora => game.addVisual(cora)})
    }
    method perdiste() {
    	if (vida.isEmpty()) {
    		game.clear()
    		fondo.image("perder.jpg")
    		game.addVisual(fondo)
    		game.schedule(5000, {game.stop()})
    		game.sound("perder.mp3").play()
    	}
    }
}

class Personaje{
	var imagenOriginal
    var property image = imagenOriginal
    var position
    var positionAnterior = null
    var property piedraEnMano = false
    
    var imageMirandoDerecha = image
    var imageMirandoIzquierda = (self.imageSinPng() + "I.png").toString()
    
    method imageSinPng() = imagenOriginal.split(".").get(0)
    
    method setImages() {
    	image = imagenOriginal
    	imageMirandoDerecha = image 
    	imageMirandoIzquierda = (self.imageSinPng() + "I.png").toString()
    }
    
    method position() = position

    method teclas(){
		keyboard.w().onPressDo({self.moverA(arriba)})
		keyboard.a().onPressDo({self.moverA(izquierda) self.image(imageMirandoIzquierda)})
		keyboard.s().onPressDo({self.moverA(abajo)})
		keyboard.d().onPressDo({self.moverA(derecha) self.image(imageMirandoDerecha)})
		keyboard.m().onPressDo({
			mundo.islasOriginales().forEach({isla => isla.completarIsla()})
			mundo.cargar()
		})
    }

    method moverA(dir) {
    	positionAnterior = position
    	position = dir.siguientePosicion(position)
    	if (bordes.estaEnBorde(position)) {
    		position = positionAnterior
    	}
	}
	
	method chocaBloque() {
		position = positionAnterior
	}
	
	method chocasteConPiedra() {}
	
	method habilitadoATirarPiedra() {
		imageMirandoIzquierda = self.imageSinPng() + "ConPiedraI.png".toString()
		imageMirandoDerecha = self.imageSinPng() + "ConPiedra.png".toString()
		image = imageMirandoDerecha
		keyboard.space().onPressDo({
			if (self.piedraEnMano()) {
				piedra.tirar()
				self.piedraEnMano(false)
				self.setImages()
			}
		})
	}
}

object perder {
	method image() = "perder.png"
	method position() = game.at(-1,-1)
}

object ganar {
	method image() = "ganar.png"
	method position() = game.at(-1,-1)
}

object arriba {
	method siguientePosicion(pos) = pos.up(1) 	
}
object derecha {
	method siguientePosicion(pos) = pos.right(1) 	
}
object izquierda {
	method siguientePosicion(pos) = pos.left(1) 	
}
object abajo {
	method siguientePosicion(pos) = pos.down(1) 	
}

class Corazon {
	const image = "corazon.png"
	var position
	
	method image() = image
	method position() = position
	
	method chocasteConJugador() {}
	method chocasteConPiedra() {}
}

const cora1 = new Corazon(position = game.at(3, 18))
const cora2 = new Corazon(position = game.at(4, 18))
const cora3 = new Corazon(position = game.at(5, 18))
const cora4 = new Corazon(position = game.at(6, 18))
const cora5 = new Corazon(position = game.at(7, 18))