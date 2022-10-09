import wollok.game.*
import jugador.*

object config {
    method config(){
        game.width(35)
        game.height(20)
        game.cellSize(50)
        game.ground("assets/grilla.jpg")
        game.title("Two piece")
    }
    
    method actions(){
    	game.onCollideDo(jugador.personajeActual(), {elementoChocado =>
    		elementoChocado.desembarcar(elementoChocado)
    	})
    }
    
    method setPersonaje(){
    	jugador.personajeActual().teclas()
		game.addVisual(jugador.personajeActual())
        jugador.vida().times({a => game.addVisual(new Corazon(position = game.at(0 + a,18)))})
    }
}
