import wollok.game.*
import terreno.*
import movimiento.*
import configs.*
import jugador.*

class Personaje{
	var position = game.at(0,3)
	var imageIzq
	var imageDer
	var image = imageIzq
	var habilidad
	
	method image() = image
	method image(imagenNueva) { image = imagenNueva }
	
	method position() = position
	
	method moverA(dir) {
		if (dir == derecha){self.image(imageDer)}
		else {self.image(imageIzq)}
		
		if (self.position().x() > game.width()){
			position = game.at(0,position.y())
			terreno.pantallas()
		}
		position = dir.siguientePosicion(position)
	}
	
	method habilidadEspecial() {
		self.image(habilidad)
		if (jugador.personajeActual() == merry) {position = game.at(self.position().x() + 5, position.y())}
	}
	
	method teclas(){
		keyboard.w().onPressDo({self.moverA(arriba)})
		keyboard.a().onPressDo({self.moverA(izquierda)})
		keyboard.s().onPressDo({self.moverA(abajo)})
		keyboard.d().onPressDo({self.moverA(derecha)})
		keyboard.shift().onPressDo({self.habilidadEspecial()})
	}
}

class Enemigo{
	const image
	const position = game.at(10,0)
	
	method position() = position
	
	method image() = image
	
	method atacar(){
		game.addVisual(projectil)
		projectil.moverse()
	}
}

object projectil{
	var position = enemigo1.position()
	
	method position() = position
	method position(nueva) {position = nueva}
	
	method image() = "assets/sol.png"
	
	method moverse(){
		if (self.position().x() < jugador.personajeActual().position().x()){
			position = game.at(self.position().x() - 1, position.y())
		}
		else{
			game.removeVisual(self)
		}
	}
}







