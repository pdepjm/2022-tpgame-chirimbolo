import wollok.game.*
import merry.*
import personajes.*
import configs.*

object isla {
	const position = game.at(15,0)
	
	method position() = position
	method image() = "assets/isla.png"
	
	method desembarcar(){
		game.clear()
		islaPantalla.inicializar()
	}
}
