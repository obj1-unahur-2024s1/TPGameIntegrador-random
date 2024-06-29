import wollok.game.*
import juego.*
import ships.*
import weapons.*
import vidas.*

object sonidoWin{
	method play(){
	game.sound("assets/winning.mp3").play()}
}

object sonidoGameOver{
	method play(){
	game.sound("assets/game-over.mp3").play()}
}

object sonidoDisparos {
	method play() {
		game.sound("assets/laser.mp3").play()
		}
}

object explosion {
	method play() {game.sound("assets/explosion.mp3").play()}
}


object musicaDeFondo {
	const musicaFondo = game.sound("assets/musicafondo.mp3")
	
	method iniciar(){
	    musicaFondo.shouldLoop(true)
		musicaFondo.volume(0.3)
		game.schedule(500, { musicaFondo.play()})
		}

	method sacarMusica() {musicaFondo.stop()}	
}






