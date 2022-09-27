import wollok.game.*
import personajes.*
import configs.*

object choque {
	const position = game.at(15,0)
	
	method position() = position
	method image() = "assets/isla.png"
	
	method desembarcar(){
		game.clear()
		isla.inicializar()
	}
}
