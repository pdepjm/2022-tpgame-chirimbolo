import wollok.game.*
import jugador.*
import mundo.*

object config {
    method configuracionesTecnicas(){
        game.width(35)
        game.height(20)
        game.cellSize(50)
        game.ground("assets/grilla.jpg")
        game.title("Two piece")
    }
    
    method actions(){
    	game.onCollideDo(stats.personajeActual(), {chocado => chocado.chocasteConJugador()})
    }
    
    method setPersonaje(){
    	stats.personajeActual().teclas()
		game.addVisual(stats.personajeActual())
        stats.mostrarVidas()
    }
}