import wollok.game.*
import personajes.*
import merry.*

object config {
	method acciones(){
		game.onCollideDo(merry, {isla => isla.desembarcar()})
	}
	
	method configs(){
		game.width(30) // 30
  		game.height(15) // 15
  		game.cellSize(50)
		game.title("Juego")
		//game.boardGround("loading.png")
	}
}

object marPantalla {
	method inicializar(){
		game.at(0,0).drawElement(fondos)
		game.at(25,10).drawElement(sol)
		game.addVisual(merry)
		merry.teclas()
	}
}

object islaPantalla {
	method inicializar(){
		fondos.image("assets/desembarco.jpg")
		game.at(0,0).drawElement(fondos)
		game.addVisualIn(merry,game.at(0,10))
		luffy.teclas()
		game.addVisual(luffy)
	}
}

object fondos {
	var imagen = "assets/1.jpg"
	
	method image() = imagen
	method image(image) {imagen = image}
}

object sol {
	const imagen = "assets/sol.png"
	
	method image() = imagen
}