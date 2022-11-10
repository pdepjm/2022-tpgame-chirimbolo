import wollok.game.*
import jugador.*
import config.*
import mundo.*

object islaPreguntas {
	var completada = false
	
	const pregunta1 = new Pregunta(pregunta = "p1.png", respuestaCorrecta = 1)
	const pregunta2 = new Pregunta(pregunta = "p2.png", respuestaCorrecta = 2)
	const pregunta3 = new Pregunta(pregunta = "p3.png", respuestaCorrecta = 3)
	const pregunta4 = new Pregunta(pregunta = "p4.png", respuestaCorrecta = 2)
	const pregunta5 = new Pregunta(pregunta = "p5.png", respuestaCorrecta = 1)
	const pregunta6 = new Pregunta(pregunta = "p6.png", respuestaCorrecta = 3)
	const pregunta7 = new Pregunta(pregunta = "p7.png", respuestaCorrecta = 1)
	const pregunta8 = new Pregunta(pregunta = "p8.png", respuestaCorrecta = 2)
	const pregunta9 = new Pregunta(pregunta = "p9.png", respuestaCorrecta = 2)
	
	const preguntas = [pregunta1, pregunta2, pregunta3, pregunta4, pregunta5, pregunta6, pregunta7, pregunta8, pregunta9]
	var preguntaActual = 0
	const bg = "fondoIslaPreguntas.png"
	const bloquesInvisibles = []
	const cancion = new Musica(theme = game.sound("islaPreguntasSound.mp3"))

	method agregarBloques(){
		2.times({a => bloquesInvisibles.add(new BloqueInvisible(position = game.at(self.position().x() - 1, self.position().y() - 1 + a), isla = self))})
		2.times({a => bloquesInvisibles.add(new BloqueInvisible(position = game.at(self.position().x() - 1 + a, self.position().y() + 2), isla = self))})
		2.times({a => bloquesInvisibles.add(new BloqueInvisible(position = game.at(self.position().x() + 2, self.position().y() + 2 - a), isla = self))})
		2.times({a => bloquesInvisibles.add(new BloqueInvisible(position = game.at(self.position().x() - 1 + a, self.position().y() - 1), isla = self))})
	}
	
	method bloquesInvisibles() = bloquesInvisibles
	
	method position() = game.at(25,9)
	
	method image() = "islaPreguntas.png"
	
	method cancion() = cancion

	method completarIsla() {
		completada = true
	}
	method estaCompletada() = completada
	
	method configIsla(){
		stats.cambiarPersonaje(new Personaje(imagenOriginal="luffy.png", position = game.at(17, 3)))
		configBasicaIsla.configuraciones(self)
		fondo.image(bg)
		//bordes.crear()
	}
	
	method chocasteConJugador(){
		game.stop()
		self.configIsla()
		self.cargar()
	}
	
	method cargar() {
		preguntaActual = 0.randomUpTo(preguntas.size() - 1).roundUp()
		game.addVisual(preguntas.get(preguntaActual))
		preguntas.get(preguntaActual).mostrarBotones()
		cancion.play()
	}
	
	method preguntaCorrecta(){
		preguntas.remove(preguntas.get(preguntaActual))
		self.proximaPregunta()
		game.say(stats.personajeActual(), "La tengo clarisima")
	}
	
	method preguntaIncorrecta(){
		preguntas.remove(preguntas.get(preguntaActual))
		self.proximaPregunta()
		game.say(stats.personajeActual(), "Pifie maaal")
		stats.perderVida()
	}
	
	method proximaPregunta() {
		if (preguntas.isEmpty()) {
			self.configIsla()
			game.addVisualIn(mundo, game.center())
		} else {
			self.configIsla()
			self.cargar()
		}
	}
}

class Pregunta {
	var pregunta
	var respuestaCorrecta
	
	method image() = pregunta
	method position() = game.at(10, 10)
	
	method mostrarBotones(){
		if (respuestaCorrecta == 1) {
			game.addVisual(new Boton(image = "a.png", position = game.at(12,5), esCorrecto = true))
			game.addVisual(new Boton(image = "b.png", position = game.at(17,5), esCorrecto = false))
			game.addVisual(new Boton(image = "c.png", position = game.at(22,5), esCorrecto = false))
		}
		else if (respuestaCorrecta == 2) {
			game.addVisual(new Boton(image = "a.png", position = game.at(12,5), esCorrecto = false))
			game.addVisual(new Boton(image = "b.png", position = game.at(17,5), esCorrecto = true))
			game.addVisual(new Boton(image = "c.png", position = game.at(22,5), esCorrecto = false))
		} else {
			game.addVisual(new Boton(image = "a.png", position = game.at(12,5), esCorrecto = false))
			game.addVisual(new Boton(image = "b.png", position = game.at(17,5), esCorrecto = false))
			game.addVisual(new Boton(image = "c.png", position = game.at(22,5), esCorrecto = true))
		}
	}
	
	method chocasteConJugador() {}
}

class Boton{
	var image
	var position
	const esCorrecto
	
	method image() = image
	
	method position() = position
	
	method chocasteConJugador(){
		if (esCorrecto) islaPreguntas.preguntaCorrecta()
		else islaPreguntas.preguntaIncorrecta()
	}
}