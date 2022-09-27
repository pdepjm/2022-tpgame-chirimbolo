import personajes.*
import isla.*
import wollok.game.*
import configs.*
import jugador.*

object terreno {
	const random = (1.randomUpTo(1)).roundUp()
	var pantallas = 1
	
	method pantallas() {
		if (pantallas == random && jugador.pantallaActual() == mar) game.addVisual(choque)
		else if (pantallas == random && jugador.pantallaActual() == isla) {
			game.addVisual(enemigo1)
			enemigo1.atacar()	
		}
		return pantallas++
	}
	
	method cambioDePantalla() {pantallas = 1}
	
	/*method generarEnemigos(){
		random.times({a => game.at(a + random, random - a).drawElement(enemigo)})
	}*/
}
