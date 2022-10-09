import wollok.game.*
import mundo.*

object jugador {
	var personajeActual = null
	var islaActual = null
	var vida = 5
	
	method personajeActual() = personajeActual
    method islaActual() = islaActual
	method vida() = vida

    method cambiarPersonaje(personaje) {personajeActual = personaje}
    method cambiarIsla(isla) {islaActual = isla}
    method perderVida() = vida--
}

class Personaje{
    var image
    var position

    method image() = image
    method position() = position

    method teclas(){
		keyboard.w().onPressDo({self.moverA(arriba)})
		keyboard.a().onPressDo({self.moverA(izquierda)})
		keyboard.s().onPressDo({self.moverA(abajo)})
		keyboard.d().onPressDo({self.moverA(derecha)})
    }

	method checkearBordes(){
        if (jugador.islaActual().bordes() == 1) position = game.at(position.x() + 1, position.y())
        if (jugador.islaActual().bordes() == -1) position = game.at(position.x() - 1, position.y())
        if (jugador.islaActual().bordes() == 2) position = game.at(position.x(), position.y() + 2 - 1)
        if (jugador.islaActual().bordes() == -2) position = game.at(position.x(), position.y() - 2 + 1)
        
		if (position.x() < 0) position = game.at(0, position.y())
        if (position.x() > game.width()) position = game.at(game.width(), position.y())
        if (position.y() < 0) position = game.at(position.x(), 0) 
        if (position.y() > game.height()) position = game.at(position.x(), game.height())
	}

    method moverA(dir) {
		self.checkearBordes()
		position = dir.siguientePosicion(position)
	}
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
}
