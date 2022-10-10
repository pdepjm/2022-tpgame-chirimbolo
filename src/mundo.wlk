import wollok.game.*
import jugador.*
import config.*

object mundo{
	const islas = [islaEnemigos, islaLaberinto, islaAcertijo]
	
	method islas() = islas
	
	method mostrarIslas(){
		self.islas().forEach({isla => game.addVisual(isla)})
	}
	
	method estanTodasCompletadas() = islas.all({isla => isla.estaCompletada()})
}

object mar{
	const property image = "mar.jpg" // que sea un barquito asi cuando pasa por encima vuelve al mundo principal y queda re facha
	var property position
	const completada = true
	
	method completarIsla() {}
	method estaCompletada() = completada
	
	method configIsla(){
		game.clear() // borra todo lo que hay en la pantalla
		jugador.cambiarIsla(self) // cambia la isla del jugador
		jugador.cambiarPersonaje(new Personaje(image="merry.jpg", position = game.center(), positionAnterior = null)) // cambia el personaje del jugador
		config.setPersonaje() // configura el personaje
		config.config() // configura la pantalla
		config.actions()
	}
	method cargar() {
		mundo.mostrarIslas()
		if (mundo.estanTodasCompletadas()) game.addVisual(moneda)
	}
	method chocasteConJugador() {
		jugador.islaActual().completarIsla()
		self.configIsla()
		self.cargar()
	}
}

object moneda {
	method image() = "moneda.jpg"
	method position() = game.at(9, 10)
	
	method chocasteConJugador() {
		jugador.ganaste()
	}
}

object islaEnemigos{
	const property image = "islaEnemigos.png"
	const property position = game.at(30,17) // 30, 17
	var completada = false
	
	method completarIsla() {
		completada = true
	}
	method estaCompletada() = completada
	
	method configIsla(){
		game.clear() // borra todo lo que hay en la pantalla
		jugador.cambiarIsla(self) // cambia la isla del jugador
		jugador.cambiarPersonaje(new Personaje(image="luffyQuieto.jpg", position = game.at(0, game.height() / 2), positionAnterior = null)) // cambia el personaje del jugador
		config.setPersonaje() // configura el personaje
		config.config() // configura la pantalla
		config.actions()
		game.schedule(5000, {game.onCollideDo(piedra, {chocado => chocado.chocasteConPiedra()})})
		jugador.personajeActual().habilitadoATirarPiedra()
	}
	
	method chocasteConJugador(){
		self.configIsla()
		self.cargar()
	}
	
	method cargar(){
		game.addVisual(enemigo1)
		game.onTick(2000, "movimiento enemigo", {
    		enemigo1.moverRandom()
    		enemigo1.disparar()
    	})
    	game.schedule(5000, {piedra.spawnear()})
	}
}

object piedra {
	var position
	
	method position() = position
	method image() = "piedra.jpg"
	method chocasteConJugador() {
		game.removeVisual(self)
	}
	method mover() {
		position = position.right(1)
	}	
	method tirar() {
		game.addVisualIn(self, jugador.personajeActual().position().right(1))
		game.onTick(500, "revoleando piedra", {self.mover()})
	}
	
	method spawnear() {
		position = game.at((-0.5).randomUpTo(18.5).roundUp(), (-0.5).randomUpTo(18.5).roundUp())
		game.addVisual(self)
	}
}

class Enemigo {
	var property image
	var property position
	var vivo = true
	
	method morir() {
		vivo = false
	}
	method estaVivo() = vivo
	
	method chocasteConPiedra() {
		self.morir()
		game.removeVisual(self)
		if (enemigos.todosMuertos()) {
			game.addVisualIn(mar, game.center().left(5))
		}
	}
	
	method moverRandom() {
		position = game.at((24.5).randomUpTo(33.5).roundUp(), (-0.5).randomUpTo(18.5).roundUp())
	}
	method disparar() {
		const proyectil = new Proyectil(position = position.left(1))
		game.addVisual(proyectil)
		game.onTick(500, "movimiento proyectil", {proyectil.mover()})
	}
}

const enemigo1 = new Enemigo(image = "merry.jpg", position = game.at(29, 9))
const enemigo2 = new Enemigo(image = "merry.jpg", position = game.at(29, 9))
const enemigo3 = new Enemigo(image = "merry.jpg", position = game.at(29, 9))
object enemigos {
	const enemigos = [enemigo1, enemigo2, enemigo3]
	
	method todosMuertos() = enemigos.all({enemigo => !enemigo.estaVivo()})
}

class Proyectil {
	const property image = "merry.jpg"
	var property position

	method mover() {
		position = position.left(1)
	}
	method chocasteConJugador() {
		jugador.perderVida()
		game.removeVisual(self)
	}
	method chocasteConPiedra() {}
}

object islaLaberinto{
	const property image = "islaLaberinto.png"
	const property position = game.at(30,3) // 30, 3
	var completada = false
	
	method completarIsla() {
		completada = true
	}
	method estaCompletada() = completada
	
	method configIsla(){
		game.clear()
		jugador.cambiarIsla(self)
		jugador.cambiarPersonaje(new Personaje(image="luffyQuieto.jpg", position = game.at(0, (game.height() / 2) - 1), positionAnterior = null))
		config.setPersonaje()
		config.config()
		config.actions()
	}
	
	method chocasteConJugador(){
		self.configIsla()
		self.cargar()
	}
	
	method cargar() {	
		self.crearLaberinto()
		game.addVisualIn(mar, game.at(34, 18))
	}
	
	method crearLaberinto() { // creando el laberinto
		// PREGUNTAR SI HAY ALGUNA FORMA DE HACER UNA AUREOLA DE LUZ PARA QUE SE VEA SOLO EN UN RADIO ESPECIFICO
		self.crearColumna(10, 1, 10)
		self.crearFila(6, 2, 19)
		game.addVisual(new Bloque(image = "bloque.jpg", position = game.at(2, 18)))
		self.crearColumna(2, 2, 13)
		self.crearColumna(3, 2, 6)
		game.addVisual(new Bloque(image = "bloque.jpg", position = game.at(3, 6)))
		self.crearColumna(2, 2, 3)
		self.crearColumna(9, 1, 0)
		self.crearColumna(7, 4 ,11)
		self.crearColumna(2, 3, 10)
		game.addVisual(new Bloque(image = "bloque.jpg", position = game.at(3, 16)))
		self.crearColumna(2, 4, 8)
		self.crearColumna(2, 4, 1)
		game.addVisual(new Bloque(image = "bloque.jpg", position = game.at(3, 1)))
		game.addVisual(new Bloque(image = "bloque.jpg", position = game.at(5, 9)))
		self.crearFila(2, 4, 4)
		self.crearColumna(2, 5, 5)
		self.crearColumna(4, 6, 5)
		self.crearFila(3, 5, 2)
		self.crearColumna(2, 7, 3)
		self.crearFila(6, 6, 0)
		self.crearFila(5, 5, 17)
		self.crearFila(3, 9, 18)
		self.crearFila(6, 6, 15)
		self.crearFila(2, 10, 14)
		self.crearColumna(2, 6, 12)
		game.addVisual(new Bloque(image = "bloque.jpg", position = game.at(7, 13)))
		self.crearColumna(2, 7, 10)
		self.crearColumna(5, 8, 6)
		self.crearFila(2, 9, 6)
		self.crearColumna(3, 9, 2)
		self.crearColumna(4, 9, 10)
		self.crearFila(8, 10, 10)
		self.crearFila(3, 10, 8)
		self.crearFila(2, 12, 5)
		self.crearFila(3, 11, 4)
		self.crearFila(5, 10, 2)
		self.crearFila(2, 13, 1)
		self.crearFila(3, 12, 7)
		self.crearColumna(2, 14, 8)
		self.crearFila(3, 11, 17)
		game.addVisual(new Bloque(image = "bloque.jpg", position = game.at(13, 19)))
		game.addVisual(new Bloque(image = "bloque.jpg", position = game.at(14, 18)))
		self.crearColumna(2, 15, 12)
		self.crearColumna(4, 13, 13)
		self.crearFila(4, 11, 12)
		game.addVisual(new Bloque(image = "bloque.jpg", position = game.at(14, 15)))
		self.crearColumna(8, 16, 0)
		self.crearColumna(2, 15, 4)
		game.addVisual(new Bloque(image = "bloque.jpg", position = game.at(17, 4)))
		game.addVisual(new Bloque(image = "bloque.jpg", position = game.at(17, 2)))
		game.addVisual(new Bloque(image = "bloque.jpg", position = game.at(17, 0)))
		game.addVisual(new Bloque(image = "bloque.jpg", position = game.at(16, 16)))
		self.crearFila(3, 16, 18)
		self.crearColumna(3, 18, 15)
		self.crearColumna(2, 17, 14)
		self.crearColumna(2, 17, 11)
		self.crearFila(3, 18, 12)
		// mitad del laberinto de izq a derecha (maome)
		self.crearFila(3, 16, 9)
		self.crearFila(2, 17, 7)
		self.crearFila(2, 18, 6)
		game.addVisual(new Bloque(image = "bloque.jpg", position = game.at(18, 8)))
		self.crearFila(4, 19, 14)
		self.crearFila(4, 19, 10)
		self.crearColumna(3, 22, 11)
		self.crearColumna(2, 19, 1)
		self.crearFila(10, 20, 2)
		self.crearFila(2, 21, 1)
		self.crearFila(4, 27, 1)
		self.crearFila(2, 24, 0)
		self.crearFila(2, 32, 0)
		self.crearFila(3, 19, 4)
		self.crearColumna(3, 21, 5)
		self.crearFila(6, 20, 8)
		self.crearColumna(3, 23, 5)
		self.crearFila(3, 23, 4)
		self.crearColumna(2, 20, 16)
		self.crearFila(2, 20, 18)
		self.crearFila(3, 21, 16)
		self.crearColumna(2, 23, 17)
		self.crearColumna(3, 25, 17)
		self.crearFila(2, 24, 15)
		self.crearColumna(3, 24, 12)
		self.crearColumna(3, 25, 10)
		self.crearFila(2, 24, 9)
		self.crearFila(2, 25, 6)
		self.crearColumna(4, 27, 15)
		self.crearColumna(2, 28, 18)
		self.crearFila(2, 27, 14)
		self.crearFila(6, 26, 13)
		self.crearColumna(2, 27, 10)
		self.crearColumna(2, 29, 10)
		game.addVisual(new Bloque(image = "bloque.jpg", position = game.at(28, 11)))
		self.crearFila(4, 27, 8)
		self.crearFila(2, 27, 7)
		self.crearFila(2, 30, 9)
		self.crearColumna(2, 32, 8)
		self.crearColumna(2, 31, 11)
		self.crearColumna(2, 27, 4)
		self.crearColumna(2, 28, 4)
		self.crearColumna(4, 30, 3)
		self.crearColumna(2, 31, 3)
		self.crearColumna(2, 32, 2)
		self.crearColumna(2, 32, 5)
		self.crearColumna(2, 33, 5)
		self.crearFila(3, 29, 15)
		self.crearColumna(2, 30, 17)
		game.addVisual(new Bloque(image = "bloque.jpg", position = game.at(31, 18)))
		game.addVisual(new Bloque(image = "bloque.jpg", position = game.at(33, 19)))
		self.crearFila(2, 32, 17)
		self.crearFila(2, 33, 16)
		self.crearColumna(4, 33, 10)
		self.crearColumna(16, 34, 0)
	}
	
	method crearFila(cant, startingX, startingY) {
		cant.times({a => game.addVisual(new Bloque(image = "bloque.jpg", position = game.at(startingX - 1 + a, startingY)))})
	}
	
	method crearColumna(cant, startingX, startingY) {
		cant.times({a => game.addVisual(new Bloque(image = "bloque.jpg", position = game.at(startingX, startingY - 1 + a)))})
	}
	
}

object islaAcertijo{
	const property image = "islaAcertijo.png"
	const property position = game.at(25,10) // 30, 17
	var completada = false
	
	method completarIsla() {
		completada = true
	}
	method estaCompletada() = completada
	
	method configIsla(){
		game.clear()
		jugador.cambiarIsla(self)
		jugador.cambiarPersonaje(new Personaje(image="luffyQuieto.jpg", position = game.at(0, game.height() / 2), positionAnterior = null))
		config.setPersonaje()
		config.config()
		config.actions()
	}
	
	method chocasteConJugador(){
		self.configIsla()
		self.cargar()
	}
	
	method cargar() {
		game.addVisualIn(mar, game.center())
	}
}

class Bloque {
	var image
	var position
	
	method image() = image
	method position() = position
	
	method chocasteConJugador() {
		jugador.personajeActual().chocaBloque()
	}
}
