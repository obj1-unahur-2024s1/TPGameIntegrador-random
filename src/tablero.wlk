import wollok.game.*
import weapons.*
import juego.*
import ships.*
import sonidos.*

class Tablero {
	var position
	var image
	method position() = position
	method image() = image
		
	
}
/* 
object tableroInicio {

	method position() = game.at(0, 0)

	method image() = "image/inicio.png"

}

object tableroGameOver  {

	 method position() = game.at(9, 10)

	 method image() = "image/gameOver.png"

}

object tableroYouWin  {

	 method position() = game.at(5, 5)

	method image() = "image/tableroWin.png"

}

object tableroInstrucciones  {

	method position() = game.at(0, 2)

	method image() = "image/intrucciones2.jpeg"

}
* 
*/

object tableroDificultad {

	//const imageNormal = "image/normal.png"
	//const imageDificil = "image/dificil.png"

	method position() = game.at(10, 1)

	method image() = "image/"+ juego.modo().toString()+ ".png"

}

