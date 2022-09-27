import configs.*

object jugador{
	var pantallaActual = mar
	var personajeActual = merry
	
	method pantallaActual(nueva) {pantallaActual = nueva}
	method personajeActual(nuevo) {personajeActual = nuevo}
	
	method pantallaActual() = pantallaActual
	method personajeActual() = personajeActual
	
	method cambiarPantalla(pantalla){
		self.pantallaActual(pantalla)
		self.personajeActual(pantalla.personajes().head())
	}
}
