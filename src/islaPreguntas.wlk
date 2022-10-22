import wollok.game.*
import jugador.*
import config.*
import mundo.*

object islaPreguntas{
	var completada = false
	const preguntas = [pregunta1, pregunta2]
	var preguntaActual = 0
	
	method position() = game.at(25,10) // 30, 17
	method image() = "islaAcertijo.png"

	method completarIsla() {
		completada = true
	}
	method estaCompletada() = completada
	
	method configIsla(){
		stats.cambiarPersonaje(new Personaje(image="luffyQuieto.jpg", position = game.at(17, 3)))
		configBasicaIsla.configuraciones(self)
		//bordes.crear()
	}
	
	method chocasteConJugador(){
		preguntaActual = 0
		self.configIsla()
		self.cargar()
	}
	
	method cargar() {
		game.addVisual(preguntas.get(preguntaActual))
		preguntas.get(preguntaActual).mostrarBotones()
	}
	
	method preguntaCorrecta(){
		preguntaActual++
		self.finDePreguntas()
		game.say(stats.personajeActual(), "La tengo clarisima")
	}
	
	method preguntaIncorrecta(){
		preguntaActual++
		stats.perderVida()
		self.finDePreguntas()
		game.say(stats.personajeActual(), "Pifie maaal")
	}
	
	method finDePreguntas() {
		if (preguntaActual == preguntas.size()) {
			self.configIsla()
			game.addVisualIn(mundo, game.center())
		} else {
			self.configIsla()
			self.cargar()
		}
	}
}

class Pregunta{
	var pregunta
	var respuestaCorrecta
	
	method text() = pregunta
	method position() = game.at(17, 15)
	
	method mostrarBotones(){
		if (respuestaCorrecta == 0) {
			game.addVisual(new Boton(position = game.at(12,7), esCorrecto = true))
			game.addVisual(new Boton(position = game.at(17,7), esCorrecto = false))
			game.addVisual(new Boton(position = game.at(22,7), esCorrecto = false))
		}
		else if (respuestaCorrecta == 1) {
			game.addVisual(new Boton(position = game.at(12,7), esCorrecto = false))
			game.addVisual(new Boton(position = game.at(17,7), esCorrecto = true))
			game.addVisual(new Boton(position = game.at(22,7), esCorrecto = false))
		} else {
			game.addVisual(new Boton(position = game.at(12,7), esCorrecto = false))
			game.addVisual(new Boton(position = game.at(17,7), esCorrecto = false))
			game.addVisual(new Boton(position = game.at(22,7), esCorrecto = true))
		}
	}
	
	method chocasteConJugador() {}
}

const pregunta1 = new Pregunta(pregunta = "¿Cual es la capital de china?", respuestaCorrecta = 1)
const pregunta2 = new Pregunta(pregunta = "¿Cual es la capital de argentina?", respuestaCorrecta = 2)

class Boton{
	var position
	const esCorrecto
	
	method image() = "boton.png"
	
	method position() = position
	
	method chocasteConJugador(){
		if (esCorrecto) islaPreguntas.preguntaCorrecta()
		else islaPreguntas.preguntaIncorrecta()
	}
}