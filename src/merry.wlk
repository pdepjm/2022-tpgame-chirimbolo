import wollok.game.*
import terreno.*
import movimiento.*

object merry {
	var position = game.at(0,3)
	
	method position() = position
	
	method moverA(dir) {
		if (self.position() == game.at(game.width(),3)){
			position = game.at(0,3)
			terreno.pantallas()
			terreno.generarIsla()
		}
		position = dir.siguientePosicion(position)
	}
	
	method image() = "merry.png"
	
	method teclas(){
		keyboard.w().onPressDo({self.moverA(arriba)})
		keyboard.a().onPressDo({self.moverA(izquierda)})
		keyboard.s().onPressDo({self.moverA(abajo)})
		keyboard.d().onPressDo({self.moverA(derecha)})
	}
}
