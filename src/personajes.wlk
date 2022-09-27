import wollok.game.*
import movimiento.*
import terreno.*

object luffy {
	var position = game.origin()
	var imagen = "assets/luffyQuieto.png"
	
	method image() = imagen
	method image(imagenNueva) { imagen = imagenNueva }
	method position() = position
	method position(posicion) {position = posicion}
	
	method teclas(){
		keyboard.shift().onPressDo{self.atacar()}
		keyboard.w().onPressDo({self.moverA(arriba)})
		keyboard.a().onPressDo({self.moverA(izquierda)})
		keyboard.s().onPressDo({self.moverA(abajo)})
		keyboard.d().onPressDo({self.moverA(derecha)})
	}
	
	method moverA(dir){
		if (dir == derecha){self.image("assets/luffyCorriendoDer.png")}
		else {self.image("assets/luffyCorriendoIzq.png")}
		
		if (self.position() == game.at(game.width(),3)){
			position = game.at(0,3)
			terreno.pantallas()
			terreno.generarEnemigos()
		}
		position = dir.siguientePosicion(position)
	}
	
	method atacar() {
		self.image("assets/ataqueLuffy.gif")
	}
}

object enemigo {
	var position = game.at(18,3)
	
	method image() = "assets/enemigo.png"
	method position() = position
	method position(nuevaPosicion) {position = nuevaPosicion}
}
