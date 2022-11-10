import wollok.game.*
import jugador.*
import mundo.*
import islaEnemigos.*
import islaLaberinto.*
import islaPreguntas.*

object config {
    method configuracionesTecnicas(){
        game.width(35)
        game.height(20)
        game.cellSize(50)
        game.ground("suelo.png")
        game.title("Three piece")
        
    }
    
    method actions(){
    	game.onCollideDo(stats.personajeActual(), {chocado => chocado.chocasteConJugador()})
    }
    
    method setPersonaje(){
    	stats.personajeActual().teclas()
		game.addVisual(stats.personajeActual())
        stats.mostrarVidas()
    }
    
    method restart(){
    	stats.vida([cora1, cora2, cora3, cora4, cora5])
    	mundo.islas([ islaEnemigos, islaLaberinto, islaPreguntas ])
    	mundo.islas().forEach({isla => isla.descompletar()})
    	cancion.resume()
    	keyboard.r().onPressDo({})
    }
}

object fondo {
	var property image = "fondoMar.png"
	var property position = game.at(-1,-1)
}

class Musica {
	
	const theme 
	
	method play() {
		theme.volume(0.25)
		theme.shouldLoop(true)
		game.schedule(10, {theme.play()})
	}
	
	method stop() {
		theme.stop()
	}
	
	method pause(){
		theme.pause()
	}
	
	method resume(){
		theme.resume()
	}
		
}

object menu{
	method mostrar(){
		config.configuracionesTecnicas()
		fondo.image("menu.png")
		keyboard.enter().onPressDo({mundo.configIsla()})
	}
}