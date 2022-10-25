import wollok.game.*
import jugador.*
import config.*
import mundo.*

object islaLaberinto{
	var completada = false
	const bg = "fondoIslaLaberinto.png"
	
	method position() = game.at(30,3) // 30, 3
	method image() = "islaLaberinto.png"

	method completarIsla() {
		completada = true
	}
	method estaCompletada() = completada
	
	method configIsla(){
		stats.cambiarPersonaje(new Personaje(image="luffy.png", position = game.at(0, (game.height() / 2) - 1)))
		configBasicaIsla.configuraciones(self)
		reloj.empezar()
		fondo.image(bg)
		//bordes.crear()
	}
	
	method chocasteConJugador(){
		self.configIsla()
		self.cargar()
	}
	
	method cargar() {	
		self.crearLaberinto()
		game.addVisualIn(mundo, game.at(34, 18))
		game.addVisual(reloj)
	}
	
	method crearLaberinto() { // creando el laberinto
		// PREGUNTAR SI HAY ALGUNA FORMA DE HACER UNA AUREOLA DE LUZ PARA QUE SE VEA SOLO EN UN RADIO ESPECIFICO
		bordes.crearColumna(10, 1, 10)
		bordes.crearFila(6, 2, 19)
		game.addVisual(new Bloque(image = "bloque.png", position = game.at(2, 18)))
		bordes.crearColumna(2, 2, 13)
		bordes.crearColumna(3, 2, 6)
		game.addVisual(new Bloque(image = "bloque.png", position = game.at(3, 6)))
		bordes.crearColumna(2, 2, 3)
		bordes.crearColumna(9, 1, 0)
		bordes.crearColumna(7, 4 ,11)
		bordes.crearColumna(2, 3, 10)
		game.addVisual(new Bloque(image = "bloque.png", position = game.at(3, 16)))
		bordes.crearColumna(2, 4, 8)
		bordes.crearColumna(2, 4, 1)
		game.addVisual(new Bloque(image = "bloque.png", position = game.at(3, 1)))
		game.addVisual(new Bloque(image = "bloque.png", position = game.at(5, 9)))
		bordes.crearFila(2, 4, 4)
		bordes.crearColumna(2, 5, 5)
		bordes.crearColumna(4, 6, 5)
		bordes.crearFila(3, 5, 2)
		bordes.crearColumna(2, 7, 3)
		bordes.crearFila(6, 6, 0)
		bordes.crearFila(5, 5, 17)
		bordes.crearFila(3, 9, 18)
		bordes.crearFila(6, 6, 15)
		bordes.crearFila(2, 10, 14)
		bordes.crearColumna(2, 6, 12)
		game.addVisual(new Bloque(image = "bloque.png", position = game.at(7, 13)))
		bordes.crearColumna(2, 7, 10)
		bordes.crearColumna(5, 8, 6)
		bordes.crearFila(2, 9, 6)
		bordes.crearColumna(3, 9, 2)
		bordes.crearColumna(4, 9, 10)
		bordes.crearFila(8, 10, 10)
		bordes.crearFila(3, 10, 8)
		bordes.crearFila(2, 12, 5)
		bordes.crearFila(3, 11, 4)
		bordes.crearFila(5, 10, 2)
		bordes.crearFila(2, 13, 1)
		bordes.crearFila(3, 12, 7)
		bordes.crearColumna(2, 14, 8)
		bordes.crearFila(3, 11, 17)
		game.addVisual(new Bloque(image = "bloque.png", position = game.at(13, 19)))
		game.addVisual(new Bloque(image = "bloque.png", position = game.at(14, 18)))
		bordes.crearColumna(2, 15, 12)
		bordes.crearColumna(4, 13, 13)
		bordes.crearFila(4, 11, 12)
		game.addVisual(new Bloque(image = "bloque.png", position = game.at(14, 15)))
		bordes.crearColumna(8, 16, 0)
		bordes.crearColumna(2, 15, 4)
		game.addVisual(new Bloque(image = "bloque.png", position = game.at(17, 4)))
		game.addVisual(new Bloque(image = "bloque.png", position = game.at(17, 2)))
		game.addVisual(new Bloque(image = "bloque.png", position = game.at(17, 0)))
		game.addVisual(new Bloque(image = "bloque.png", position = game.at(16, 16)))
		bordes.crearFila(3, 16, 18)
		bordes.crearColumna(3, 18, 15)
		bordes.crearColumna(2, 17, 14)
		bordes.crearColumna(2, 17, 11)
		bordes.crearFila(3, 18, 12)
		// mitad del laberinto de izq a derecha (maome)
		bordes.crearFila(3, 16, 9)
		bordes.crearFila(2, 17, 7)
		bordes.crearFila(2, 18, 6)
		game.addVisual(new Bloque(image = "bloque.png", position = game.at(18, 8)))
		bordes.crearFila(4, 19, 14)
		bordes.crearFila(4, 19, 10)
		bordes.crearColumna(3, 22, 11)
		bordes.crearColumna(2, 19, 1)
		bordes.crearFila(10, 20, 2)
		bordes.crearFila(2, 21, 1)
		bordes.crearFila(4, 27, 1)
		bordes.crearFila(2, 24, 0)
		bordes.crearFila(2, 32, 0)
		bordes.crearFila(3, 19, 4)
		bordes.crearColumna(3, 21, 5)
		bordes.crearFila(6, 20, 8)
		bordes.crearColumna(3, 23, 5)
		bordes.crearFila(3, 23, 4)
		bordes.crearColumna(2, 20, 16)
		bordes.crearFila(2, 20, 18)
		bordes.crearFila(3, 21, 16)
		bordes.crearColumna(2, 23, 17)
		bordes.crearColumna(3, 25, 17)
		bordes.crearFila(2, 24, 15)
		bordes.crearColumna(3, 24, 12)
		bordes.crearColumna(3, 25, 10)
		bordes.crearFila(2, 24, 9)
		bordes.crearFila(2, 25, 6)
		bordes.crearColumna(4, 27, 15)
		bordes.crearColumna(2, 28, 18)
		bordes.crearFila(2, 27, 14)
		bordes.crearFila(6, 26, 13)
		bordes.crearColumna(2, 27, 10)
		bordes.crearColumna(2, 29, 10)
		game.addVisual(new Bloque(image = "bloque.png", position = game.at(28, 11)))
		bordes.crearFila(4, 27, 8)
		bordes.crearFila(2, 27, 7)
		bordes.crearFila(2, 30, 9)
		bordes.crearColumna(2, 32, 8)
		bordes.crearColumna(2, 31, 11)
		bordes.crearColumna(2, 27, 4)
		bordes.crearColumna(2, 28, 4)
		bordes.crearColumna(4, 30, 3)
		bordes.crearColumna(2, 31, 3)
		bordes.crearColumna(2, 32, 2)
		bordes.crearColumna(2, 32, 5)
		bordes.crearColumna(2, 33, 5)
		bordes.crearFila(3, 29, 15)
		bordes.crearColumna(2, 30, 17)
		game.addVisual(new Bloque(image = "bloque.png", position = game.at(31, 18)))
		game.addVisual(new Bloque(image = "bloque.png", position = game.at(33, 19)))
		bordes.crearFila(2, 32, 17)
		bordes.crearFila(2, 33, 16)
		bordes.crearColumna(4, 33, 10)
		bordes.crearColumna(16, 34, 0)
	}
}

object reloj {
	var segundos = 30
	
	method descontar() {
		segundos -= 1
	}
	
	method position() = game.at(22,19)
	
	method text() = "tiempo: " + segundos.toString()
	
	method reiniciar() {
		segundos = 30
	}
	method empezar() {
		game.onTick(1000, "descontar segundo", {
			self.descontar()
		})
		game.onTick(segundos * 1000, "Reiniciar reloj y perder vida", {
			self.reiniciar()
			stats.perderVida()
		})
	}
}