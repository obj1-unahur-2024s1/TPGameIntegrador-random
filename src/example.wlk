import wollok.game.*
import ships.*
import sonidos.*

object juego {

	const mainShip = new MainShip()

	method configurar() {
		game.cellSize(32)
		game.height(20)
		game.width(32)
		game.title("Space Ship")
		game.boardGround("image/spaceBG.jpg")
	}

	method pantallaInicial() {
		self.configurar()
		keyboard.enter().onPressDo{ self.juegoPrincipal()}
		game.title("Space Ship")
		game.addVisual(tableroInstrucciones)
		game.start()
	}

	method juegoPrincipal() {
		game.clear()
		keyboard.space().onPressDo{ mainShip.disparar()}
		self.configurar()
		self.iniciar()
	}

	method iniciar() {
		musicaDeFondo.iniciar()
		self.agregarCapitanes(15)
		self.agregarSoldados(13)
		game.addVisualCharacter(mainShip)
		game.addVisual(vidas)
	}

	method gameOver() {
		game.clear()
		game.addVisual(tableroGameOver)
		musicaDeFondo.sacarMusica()
		sonidoGameOver.play()
		
		keyboard.enter().onPressDo{ self.reiniciarJuego()}
	}

	method youWin() {
		game.clear()
		game.addVisual(tableroYouWin)
		
		keyboard.enter().onPressDo{ self.reiniciarJuego()}
	}

	method jefeFinal() {
		const motherShip = new MotherShip(position = game.at(6, 16))
		game.clear()
		game.addVisual(motherShip)
		game.addVisualCharacter(mainShip)
		game.addVisual(vidasMotherShip) //agrega las vidas
		vidas.reiniciarVidas()
		game.addVisual(vidas)
		game.onTick(1000, "moverAlternado", { motherShip.moverAlternado()})
		keyboard.space().onPressDo{ mainShip.disparar()}
		game.onTick(1000, "enemyFire" + self.identity().toString(), { motherShip.disparar()})
	}

	method agregarSoldados(ejeY) {
		const filaSoldados = [ new Soldado(position=game.at(6,ejeY)), new Soldado(position=game.at(9,ejeY)), new Soldado(position=game.at(12,ejeY)), new Soldado(position=game.at(15,ejeY)), new Soldado(position=game.at(18,ejeY)), new Soldado(position=game.at(21,ejeY)) ]
		filaSoldados.forEach{ soldier =>
			game.addVisual(soldier)
			game.onTick(1000, "moverAlternado", { soldier.moverAlternado()})
			const randomInterval = 3000.randomUpTo(6000)
			game.onTick(randomInterval, "enemyFire" + self.identity().toString(), { soldier.disparar()})
		}
	}

	method agregarCapitanes(ejeY) {
		const filaCapitan = [ new Capitan(position=game.at(4,ejeY)), new Capitan(position=game.at(7,ejeY)), new Capitan(position=game.at(10,ejeY)), new Capitan(position=game.at(13,ejeY)), new Capitan(position=game.at(16,ejeY)), new Capitan(position=game.at(19,ejeY)) ]
		filaCapitan.forEach{ soldier =>
			game.addVisual(soldier)
			game.onTick(1000, "moverAlternado", { soldier.moverAlternado()})
			const randomInterval = 3000.randomUpTo(6000)
			game.onTick(randomInterval, "enemyFire" + self.identity().toString(), { soldier.disparar()})
		}
	}
	method reiniciarJuego() {
	    game.clear()
	    self.configurar()
	    mainShip.position(game.at(game.width() / 2, 0))  // Reposicionar la nave
	    mainShip.image("image/Main Ship - Base - Full health.png")  //Restable la imagen
	    vidas.reiniciarVidas()  // Reiniciar las vidas
	    puntos.reiniciarPuntos()  // Reiniciar los puntos
	    self.juegoPrincipal()  // Iniciar el juego principal
}


}

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

}

object puntos {

	var property puntos = 0

	method sumarPunto() {
		puntos = puntos + 1
		if (puntos == 12) juego.jefeFinal()
	}
	method reiniciarPuntos() {
        puntos = 0
    }
}

// estos tableros deberiamos pasarlos a una clase

class Tablero {
	method position()
	method image()
}
object tableroGameOver inherits Tablero{

	override method position() = game.at(9, 10)

	override method image() = "image/gameOver.png"

}

object tableroYouWin inherits Tablero{

	override method position() = game.at(5, 5)

	override method image() = "image/tableroWin.png"

}

object tableroInstrucciones inherits Tablero{

	override method position() = game.at(0, 0)

	override method image() = "image/instrucciones.jpg"

}

