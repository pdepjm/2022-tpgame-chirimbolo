import wollok.game.*
import jugador.*
import config.*
import mundo.*

object islaEnemigos{
	const property image = "islaEnemigos.png"
	const property position = game.at(3,3) // 30, 17
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
		//bordes.crear()
	}
	
	method chocasteConJugador(){
		self.configIsla()
		self.cargar()
	}
	
	method cargar(){
		game.addVisual(enemigo1)
    	game.schedule(5000, {piedra.spawnear()})
		enemigos.lista().forEach({enemigo => 
			game.onTick(2000, "movimiento enemigo", {
    		enemigo.moverRandom()
    		enemigo.disparar()
    	})
		})
	}
}

object piedra {
	var position
	
	method position() = position
	method image() = "merry.jpg"
	
	method chocasteConJugador() {
		game.removeVisual(self)
		jugador.personajeActual().piedraEnMano(true)
		jugador.personajeActual().habilitadoATirarPiedra() // se podria hacer un metodo en Personaje para que la piedra no se meta con el personaje (delegar)
	}
	method mover() {
		position = position.right(1)
	}	
	method tirar() {
		position = jugador.personajeActual().position().right(1)
		game.addVisual(self)
		game.onTick(100, "revoleando piedra", {self.mover()})
		game.onTick(5000, "chequeo piedra en borde", {self.piedraEnBorde()})
	}
	
	method spawnear() {
		position = game.at((-0.5).randomUpTo(18.5).roundUp(), (-0.5).randomUpTo(18.5).roundUp())
		game.addVisual(self)
		game.onCollideDo(self, {chocado => chocado.chocasteConPiedra()})
	}
	method piedraEnBorde() {
		if (bordes.estaEnBorde(position)) {
			game.removeVisual(self)
			game.removeTickEvent("revoleando piedra")
			self.spawnear()
		}
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
		game.removeVisual(piedra)
		game.removeTickEvent("revoleando piedra")
		game.schedule(5000, {piedra.spawnear()})
		if (enemigos.todosMuertos()) {
			game.addVisualIn(mundo, game.center().left(5))
		}
	}
	
	method moverRandom() {
		position = game.at((24.5).randomUpTo(33.5).roundUp(), (-0.5).randomUpTo(18.5).roundUp())
	}
	method disparar() {
		const proyectil = new Proyectil(position = position.left(1))
		game.addVisual(proyectil)
		game.onTick(500, "movimiento proyectil", {
			proyectil.mover()
		})
		game.schedule(17000, {
			if (game.hasVisual(proyectil)) {
				game.removeVisual(proyectil)
			}
		})
	}
}

class Boss inherits Enemigo {
	var vida = 2
	method perderVida() {
		vida -= 1
		if (vida == 0) {
			self.morir()
		}
	}
	override method chocasteConPiedra() {
		self.perderVida()
		game.removeVisual(self)
		game.removeVisual(piedra)
		game.removeTickEvent("revoleando piedra")
		game.schedule(5000, {piedra.spawnear()})
		if (enemigos.todosMuertos()) {
			game.addVisualIn(mundo, game.center().left(5))
		}
	}
}

const enemigo1 = new Enemigo(image = "merry.jpg", position = game.at(29, 9))
const enemigo2 = new Enemigo(image = "merry.jpg", position = game.at(29, 10))
const enemigoBoss = new Boss(image = "merry.jpg", position = game.at(29, 11))

object enemigos {
	const enemigos = [enemigo1, enemigo2, enemigoBoss]
	method lista() = enemigos
	
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
	/*
	 * method proyectilEnBorde() {
		if (bordes.estaEnBorde(position)) {
			game.removeVisual(self)
		}
	}
	 */
	
	method chocasteConPiedra() {}
}