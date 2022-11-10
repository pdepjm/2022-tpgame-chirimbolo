import wollok.game.*
import jugador.*
import mundo.*

object config {
    method configuracionesTecnicas(){
        game.width(35)
        game.height(20)
        game.cellSize(50)
        game.ground("suelo.png")
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

object fondo {
	var property image = "fondoMar.png"
	var property position = game.at(-1,-1)
}

class Musica {
	
	const theme 
	
	method play() {
		theme.volume(0.5)
		theme.shouldLoop(true)
		game.schedule(10, {theme.play()})
	}
	
	method stop() {
		theme.stop()
	}
		
}

object menu{
	method mostrar(){
		config.configuracionesTecnicas()
		fondo.image("menu.png")
		game.addVisual(fondo)
		keyboard.enter().onPressDo({mundo.configIsla()})
	}
}