import wollok.game.*
import jugador.*
import config.*

object mundo{
	const islas = [islaEnemigos, islaLaberinto, islaAcertijo]
	
	method islas() = islas
	
	method mostrarIslas(){
		self.islas().forEach({isla => game.addVisual(isla)})
	}
}

object mar{
	method configIsla(isla){
		game.clear() // borra todo lo que hay en la pantalla
		jugador.cambiarIsla(isla) // cambia la isla del jugador
		jugador.cambiarPersonaje(new Personaje(image="merry.jpg", position = game.origin())) // cambia el personaje del jugador
		config.setPersonaje() // configura el personaje
		config.config() // configura la pantalla
	}
	
	method bordes(){
		return true
	}
}

object islaEnemigos{
	const image = "islaEnemigos.png"
	const position = game.at(30,17) // 30, 17
	
	method image() = image
	method position() = position
	
	method configIsla(isla){
		game.clear() // borra todo lo que hay en la pantalla
		jugador.cambiarIsla(isla) // cambia la isla del jugador
		jugador.cambiarPersonaje(new Personaje(image="luffyQuieto.jpg", position = game.at(0, game.height() / 2))) // cambia el personaje del jugador
		config.setPersonaje() // configura el personaje
		config.config() // configura la pantalla
	}
	
	method desembarcar(isla){
		self.configIsla(isla)
		//self.cargar()
	}
	
	method cargar(){
	}
	
	method bordes(){}
}

object islaLaberinto{
	const image = "islaLaberinto.png"
	const position = game.at(2,2) // 30, 3
	
	method image() = image
	method position() = position
	
	method configIsla(isla){
		game.clear()
		jugador.cambiarIsla(isla)
		jugador.cambiarPersonaje(new Personaje(image="luffyQuieto.jpg", position = game.at(0, game.height() / 2)))
		config.setPersonaje()
		config.config()
	}
	
	method bordes(){
		
	}
	
	method desembarcar(isla){
		self.configIsla(isla)
		self.cargar()
	}
	
	method cargar(){
		self.crearFila(4, jugador.personajeActual().position().x(), jugador.personajeActual().position().y() + 3)
		self.crearFila(4, jugador.personajeActual().position().x(), jugador.personajeActual().position().y() - 3)
		self.crearColumna(5, jugador.personajeActual().position().x() + 3, jugador.personajeActual().position().y() - 2)
		self.crearColumna(5, jugador.personajeActual().position().x() + 3, jugador.personajeActual().position().y() - 2)
	}
	
	method crearFila(cant, startingX, startingY){
		cant.times({a => game.addVisual(new Bloque(image = "bloque.png", position = game.at(startingX + a - 1, startingY)))})
	}
	
	method crearColumna(cant, startingX, startingY){
		cant.times({a => game.addVisual(new Bloque(image = "bloque.png", position = game.at(startingX, startingY + a - 1)))})
	}
	
}

object islaAcertijo{
	const image = "islaAcertijo.png"
	const position = game.at(25,10) // 30, 17
	
	method image() = image
	method position() = position
	
	method configIsla(isla){
		game.clear()
		jugador.cambiarIsla(isla)
		jugador.cambiarPersonaje(new Personaje(image="luffyQuieto.jpg", position = game.at(0, game.height() / 2)))
		config.setPersonaje()
		config.config()
	}
	
	method desembarcar(isla){
		self.configIsla(isla)
		//self.cargar()
	}
	
	method cargar(){
	}
}

class Bloque {
	var image
	var position
	
	method image() = image
	method position() = position
}
