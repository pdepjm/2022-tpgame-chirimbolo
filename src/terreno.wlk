import merry.*
import isla.*
import wollok.game.*
import personajes.*

object terreno {
	const random = (1.randomUpTo(5)).roundUp()
	var pantallas = 0
	
	method pantallas() = pantallas++
	
	method cambioDePantalla() {pantallas = 0}
	
	method generarIsla(){
		if (pantallas == random){
			game.addVisual(isla)
		}
	}
	
	method generarEnemigos(){
		random.times({a => game.at(a + random, random - a).drawElement(enemigo)})
	}
}
