import wollok.game.*
import weapons.*
import juego.*
import ships.*
import sonidos.*
import tablero.*

object vidas {

	const position = game.at(1, 18)
	var property image = "image/2vidas.png"
	var property vidas = 2

	method image() = image

	method vidas() = vidas

	method position() = position

	method perderVida() {
		vidas = vidas - 1
		image = "image/1vidas.png"
		if (vidas == 0) juego.gameOver()
	}

	method reiniciarVidas() {
		vidas = 2
		image = "image/2vidas.png"
	}
	method impactoLaser(){
		//para que no cause problemas el impacto del laser
	}
	
	method color(){
		//para que no cause error
	}

}

object vidasMotherShip {

	const position = game.at(25, 18)
	var image = "image/barraCompleta.jpeg"
	var vidasMother = 4

	method image() = image

	method vidasMother() = vidasMother

	method position() = position

	method perderVida() {
		vidasMother = vidasMother - 1
		if (vidasMother == 3) {
			image = "image/barra3-4.jpeg"
		} else if (vidasMother == 2) {
			image = "image/barra1-4.jpeg"
		} else if (vidasMother == 1) {
			image = "image/barraCasiVacia.jpeg"
		} else if (vidasMother == 0) {
			juego.youWin()
		}
	}
	method color(){
		//para que no cause error
	}
}
