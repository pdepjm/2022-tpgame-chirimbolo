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
		stats.cambiarIsla(self) // cambia la isla del jugador
		stats.cambiarPersonaje(new Personaje(image="luffyQuieto.jpg", position = game.at(0, game.height() / 2), positionAnterior = null)) // cambia el personaje del jugador
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
		bordes.crearRio(20, 21, 0)
		bordes.crearRio(20, 22, 0)
		bordes.crearRio(20, 23, 0)
    	game.schedule(5000, {piedra.spawnear()})
    	enemigos.lista().forEach({enemigo => 
    		game.addVisual(enemigo)
			game.onTick(2000, "movimiento " + enemigo.nombre(), {
    			enemigo.moverRandom()
    			enemigo.disparar(500)
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
		stats.personajeActual().piedraEnMano(true)
		stats.personajeActual().habilitadoATirarPiedra() // se podria hacer un metodo en Personaje para que la piedra no se meta con el personaje (delegar)
	}
	method mover() {
		position = position.right(1)
	}	
	method tirar() {
		position = stats.personajeActual().position().right(1)
		game.addVisual(self)
		game.onTick(100, "revoleando piedra", {self.mover()})
		game.onTick(5000, "chequeo piedra en borde", {self.piedraEnBorde()})
	}
	
	method spawnear() {
		position = game.at((0).randomUpTo(18.5).roundUp(), (0).randomUpTo(15.5).roundUp())
		game.addVisual(self)
		game.onCollideDo(self, {chocado => chocado.chocasteConPiedra()})
	}
	method piedraEnBorde() {
		if (bordes.estaEnBorde(position)) {
			game.removeVisual(self)
			game.removeTickEvent("revoleando piedra")
			game.removeTickEvent("chequeo piedra en borde")
			self.spawnear()
		}
	}
}

class Enemigo {
	var property image
	var property position
	var positionAnterior = null
	const nombre
	var vivo = true
	
	method nombre() = nombre
	
	method morir() {
		vivo = false
		game.say(self, "nos vemos locura")
		game.removeTickEvent("movimiento " + nombre)
		game.schedule(3000, {game.removeVisual(self)})
	}
	method estaVivo() = vivo
	
	method chocasteConPiedra() {
		self.morir()
		game.removeVisual(piedra)
		game.removeTickEvent("revoleando piedra")
		game.removeTickEvent("chequeo piedra en borde")
		game.schedule(5000, {piedra.spawnear()})
		if (enemigos.todosMuertos()) {
			game.addVisualIn(mundo, game.center().left(5))
		}
	}
	
	method moverRandom() {
		positionAnterior = position
		if (position.y() >= 18) {
			position = position.down(1)
		} 
		else if (position.y() <= 1) {
			position = position.up(1)
		} else {
			const random = 1.randomUpTo(2)
			if (random < 1.5) position = position.down(1) else position = position.up(1)
		}
	}
	
	method disparar(tiempo) {
		const proyectil = new Proyectil(position = position.left(1), nombre = "proyectil" + contador.numero().toString())
		contador.aumentar()
		game.addVisual(proyectil)
		game.onTick(tiempo, "movimiento proyectil " + proyectil.nombre(), {
			proyectil.mover()
		})
		game.schedule(34 * tiempo, {
			if (game.hasVisual(proyectil)) {
				game.removeVisual(proyectil)
				game.removeTickEvent("movimiento proyectil " + proyectil.nombre())
			}
		})
	}
}

class Boss inherits Enemigo { // cuando pierde una vida tira proyectiles mas rapido
	var vida = 2
	
	method perderVida() {
		vida -= 1
		if (vida == 0) {
			self.morir()
		} else {
			game.say(self, "nice shot bro, pero me queda otra vida")
			self.enojado()
		}
	}
	
	override method chocasteConPiedra() {
		self.perderVida()
		game.removeVisual(piedra)
		game.removeTickEvent("revoleando piedra")
		game.removeTickEvent("chequeo piedra en borde")
		game.schedule(5000, {piedra.spawnear()})
		if (enemigos.todosMuertos()) {
			game.addVisualIn(mundo, game.center().left(5))
		}
	}
	
	override method morir() {
		vivo = false
		game.say(self, "nos vemos locura")
		game.removeTickEvent("movimiento boss enojado")
		game.schedule(3000, {game.removeVisual(self)})
	}
	
	method enojado() {
		game.removeTickEvent("movimiento " + nombre)
		game.onTick(1000, "movimiento boss enojado", {
			self.moverRandom()
    		self.disparar(250)
		})
	}
}

const enemigo1 = new Enemigo(image = "merry.jpg", position = game.at(26, 16), nombre = "enemigo1")
const enemigoBoss = new Boss(image = "merry.jpg", position = game.at(29, 9), nombre = "enemigoBoss")
const enemigo2 = new Enemigo(image = "merry.jpg", position = game.at(32, 3), nombre = "enemigo2")

object enemigos {
	const enemigos = [enemigo1, enemigo2, enemigoBoss]
	method lista() = enemigos
	
	method todosMuertos() = enemigos.all({enemigo => !enemigo.estaVivo()})
}

class Proyectil {
	const property image = "merry.jpg"
	var property position
	const nombre
	
	method nombre() = nombre 

	method mover() {
		position = position.left(1)
	}
	method chocasteConJugador() {
		stats.perderVida()
		game.removeVisual(self)
		game.removeTickEvent("movimiento proyectil " + nombre)
	}
	
	method chocasteConPiedra() {}
}

object contador { // Para el nombre de los proyectiles
	var numero = 0
	method numero() = numero
	method aumentar() {numero += 1}
}