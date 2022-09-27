import wollok.game.*
import personajes.*
import isla.*
import jugador.*
import terreno.*

const merry = new Personaje(imageIzq="assets/merry.png",imageDer="assets/merry.png", habilidad="assets/merry.png")
const luffy = new Personaje(imageIzq="assets/luffyCorriendoIzq.png",imageDer="assets/luffyCorriendoDer.png", habilidad="assets/ataqueLuffy.gif")
const mar = new Pantalla(personajes=[merry],image="assets/marFondo.jpg")
const isla = new Pantalla(personajes=[luffy], image="assets/desembarco.jpg")

const enemigo1 = new Enemigo(image = "assets/enemigo.png")
const enemigo2 = new Enemigo(image = "assets/enemigo.png")
const enemigo3 = new Enemigo(image = "assets/enemigo.png")


object config {
	method acciones(){
		game.onCollideDo(merry, {chocado => 
			choque.desembarcar()
			jugador.cambiarPantalla(isla)
			terreno.cambioDePantalla()
		})
	}
	
	method configs(){
		game.width(30) // 30
  		game.height(15) // 15
  		game.cellSize(50)
		game.title("Juego")
		//game.boardGround("loading.png")
	}
}

class Pantalla{
	const personajes
	const image
	const fondo = new Fondo(imagen=image)
	
	method personajes() = personajes
	
	method inicializar(){
		game.at(0,0).drawElement(fondo)
		personajes.forEach({personaje => game.addVisual(personaje)})
		personajes.forEach({personaje => personaje.teclas()})
	}
	
}

class Fondo {
	var imagen
	
	method image() = imagen
	method image(image) {imagen = image}
}

object sol {
	const imagen = "assets/sol.png"
	
	method image() = imagen
}