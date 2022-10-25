import wollok.game.*
import jugador.*
import config.*
import mundo.*

const pregunta1 = new Pregunta(pregunta = "¿Cual es la capital de china?", respuestas = ["Beijing","Taiwan","Hong Kong"], respuestaCorrecta = 0)
const pregunta2 = new Pregunta(pregunta = "¿Cual es la capital de argentina?", respuestas = ["La plata","CABA","Buenos Aires"], respuestaCorrecta = 1)
const pregunta3 = new Pregunta(pregunta = "¿Cuál de los siguientes NO es un pecado capital?", respuestas = ["Envidia","Gula","Malicia"], respuestaCorrecta = 2)
const pregunta4 = new Pregunta(pregunta = "¿Quién es el autor de la frase 'Pienso, luego existo'", respuestas = ["Platón","Sócrates","Descartes"], respuestaCorrecta = 2)
const pregunta5 = new Pregunta(pregunta = "¿De qué país es típico el Shawarma?", respuestas = ["India","Armenia","Líbano"], respuestaCorrecta = 0)
const pregunta6 = new Pregunta(pregunta = "¿En qué país de África el español es la lengua oficial?", respuestas = ["Guinea Ecuatorial","Costa de Marfil","Cabo Verde"], respuestaCorrecta = 0)
const pregunta7 = new Pregunta(pregunta = "¿Cuánto tiempo tarda la luz del Sol en llegar a la Tierra?", respuestas = ["12 minutos","8 minutos","8 segundos"], respuestaCorrecta = 1)
const pregunta8 = new Pregunta(pregunta = "¿Cual es el significado de la vida?", respuestas = ["Aprobar pdep","42","Ver el final de One Piece"], respuestaCorrecta = 1)

object islaPreguntas{
	var completada = false
	const preguntas = [pregunta1, pregunta2, pregunta3, pregunta4, pregunta5, pregunta6, pregunta7, pregunta8]
	var preguntaActual = 0
	const bg = "fondoIslaPreguntas.png"
	
	method position() = game.at(3,3) // 30, 17
	method image() = "islaAcertijo.png"

	method completarIsla() {
		completada = true
	}
	method estaCompletada() = completada
	
	method configIsla(){
		stats.cambiarPersonaje(new Personaje(image="luffy.png", position = game.at(17, 3)))
		configBasicaIsla.configuraciones(self)
		fondo.image(bg)
		//bordes.crear()
	}
	
	method chocasteConJugador(){
		self.configIsla()
		self.cargar()
	}
	
	method cargar() {
		preguntaActual = 0.randomUpTo(preguntas.size() - 1).roundUp()
		game.addVisual(preguntas.get(preguntaActual))
		preguntas.get(preguntaActual).mostrarBotones()
	}
	
	method preguntaCorrecta(){
		preguntas.remove(preguntas.get(preguntaActual))
		self.finDePreguntas()
		game.say(stats.personajeActual(), "La tengo clarisima")
	}
	
	method preguntaIncorrecta(){
		preguntas.remove(preguntas.get(preguntaActual))
		stats.perderVida()
		self.finDePreguntas()
		game.say(stats.personajeActual(), "Pifie maaal")
	}
	
	method finDePreguntas() {
		if (preguntas.size() == 0) {
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
	var respuestas
	var respuestaCorrecta
	
	method text() = pregunta
	method position() = game.at(17, 15)
	
	method mostrarBotones(){
		if (respuestaCorrecta == 0) {
			game.addVisual(new Boton(position = game.at(12,7), esCorrecto = true, respuesta = respuestas.get(0)))
			game.addVisual(new Boton(position = game.at(17,7), esCorrecto = false, respuesta = respuestas.get(1)))
			game.addVisual(new Boton(position = game.at(22,7), esCorrecto = false, respuesta = respuestas.get(2)))
		}
		else if (respuestaCorrecta == 1) {
			game.addVisual(new Boton(position = game.at(12,7), esCorrecto = false, respuesta = respuestas.get(0)))
			game.addVisual(new Boton(position = game.at(17,7), esCorrecto = true, respuesta = respuestas.get(1)))
			game.addVisual(new Boton(position = game.at(22,7), esCorrecto = false, respuesta = respuestas.get(2)))
		} else {
			game.addVisual(new Boton(position = game.at(12,7), esCorrecto = false, respuesta = respuestas.get(0)))
			game.addVisual(new Boton(position = game.at(17,7), esCorrecto = false, respuesta = respuestas.get(1)))
			game.addVisual(new Boton(position = game.at(22,7), esCorrecto = true, respuesta = respuestas.get(2)))
		}
	}
	
	method chocasteConJugador() {}
}

class Boton{
	var position
	var respuesta
	const esCorrecto
	
	method text() = respuesta
	
	method image() = "boton.png"
	
	method position() = position
	
	method chocasteConJugador(){
		if (esCorrecto) islaPreguntas.preguntaCorrecta()
		else islaPreguntas.preguntaIncorrecta()
	}
}