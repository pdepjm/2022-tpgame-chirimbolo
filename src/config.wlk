import wollok.game.*
import jugador.*
import mundo.*

object config {
    method config(){
        game.width(35)
        game.height(20)
        game.cellSize(50)
        game.ground("assets/grilla.jpg")
        game.title("Two piece")
    }
    
    method actions(){
    	game.onCollideDo(jugador.personajeActual(), {chocado => chocado.chocasteConJugador()})
    }
    
    method setPersonaje(){
    	jugador.personajeActual().teclas()
		game.addVisual(jugador.personajeActual())
        jugador.mostrarVidas()
    }
}
