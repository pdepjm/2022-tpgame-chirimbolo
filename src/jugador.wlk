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
    	vida.remove(vida.last())
    	self.perdiste()
    	self.mostrarVidas()
    }
    method borrarVidas() {
    	vida.forEach({cora => game.removeVisual(cora)})
    }
    method mostrarVidas() {
    	vida.forEach({cora => game.addVisual(cora)})
    }
    method perdiste() {
    	if (vida.isEmpty()) {
    		game.clear()
    		game.addVisual(perder)
    		game.say(perder, "PERDISTE!")
    		game.schedule(5000, {game.stop()})
    	}
    }
    method ganaste() {
    	if (mundo.estanTodasCompletadas()) {
    		game.clear()
    		game.addVisual(ganar)
    		game.say(ganar, "GANASTE!")
    		game.schedule(5000, {game.stop()})
    	}
    }
}

class Personaje{
    var image
    var property position
    var property positionAnterior
    var property piedraEnMano = false

    method image() = image

    method teclas(){
		keyboard.w().onPressDo({self.moverA(arriba)})
		keyboard.a().onPressDo({self.moverA(izquierda)})
		keyboard.s().onPressDo({self.moverA(abajo)})
		keyboard.d().onPressDo({self.moverA(derecha)})
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
		keyboard.space().onPressDo({
			if (self.piedraEnMano()) {
				piedra.tirar()
				self.piedraEnMano(false)
			}
		})
	}
}

object perder {
	method image() = "perder.jpg"
	method position() = game.center()
}

object ganar {
	method image() = "ganar.jpg"
	method position() = game.center()
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
	const image = "assets/corazon.jpg"
	var position
	
	method image() = image
	method position() = position
	
	method chocasteConJugador() {}
	method chocasteConPiedra() {}
}

const cora1 = new Corazon(position = game.at(1, 18))
const cora2 = new Corazon(position = game.at(2, 18))
const cora3 = new Corazon(position = game.at(3, 18))
const cora4 = new Corazon(position = game.at(4, 18))
const cora5 = new Corazon(position = game.at(5, 18))