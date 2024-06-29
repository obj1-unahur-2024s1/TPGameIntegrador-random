import wollok.game.*
import weapons.*
import juego.*
import ships.*
import sonidos.*

class Tablero {

	method position()

	method image()

}

object tableroInicio inherits Tablero {

	override method position() = game.at(0, 0)

	override method image() = "image/inicio.png"

}

object tableroGameOver inherits Tablero {

	override method position() = game.at(9, 10)

	override method image() = "image/gameOver.png"

}

object tableroYouWin inherits Tablero {

	override method position() = game.at(5, 5)

	override method image() = "image/tableroWin.png"

}

object tableroInstrucciones inherits Tablero {

	override method position() = game.at(0, 0)

	override method image() = "image/instrucciones.jpg"

}

