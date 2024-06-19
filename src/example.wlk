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
		keyboard.space().onPressDo{ mainShip.disparar()}
	}

	method pantallaInicial() {
		game.cellSize(32)
		game.height(20)
		game.width(32)
		game.title("Space Ship")
		game.boardGround("image/spaceBG.jpg")
		keyboard.enter().onPressDo{ self.juegoPrincipal()}
		game.addVisual(tableroInstrucciones)
		game.start()
	}

	method juegoPrincipal() {
		game.clear()
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
	}

	method jefeFinal() {
		const motherShip = new MotherShip(position = game.at(6, 16))
		game.clear()
		game.boardGround("image/spaceBG.jpg")
		game.addVisual(motherShip)
		game.addVisualCharacter(mainShip)
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

}

object puntos {

	var property puntos = 0

	method sumarPunto() {
		puntos = puntos + 1
		if (puntos == 12) juego.jefeFinal()
	}

}

object tableroGameOver {

	method position() = game.at(9, 10)

	method image() = "image/gameOver.png"

}

object tableroInstrucciones {

	method position() = game.at(0, 0)

	method image() = "image/instrucciones.jpg"

}

