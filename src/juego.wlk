import wollok.game.*
import ships.*
import sonidos.*
import tablero.*
import vidas.*

object juego {

	// const mainShip = new MainShip()
	method configurar() {
		game.cellSize(32)
		game.height(20)
		game.width(32)
		game.title("Space Ship")
		game.boardGround("image/spaceBG.jpg")
	}

	method pantallaInicial() {
		game.clear()
		self.configurar()
		keyboard.enter().onPressDo{ self.juegoPrincipal()}
		keyboard.space().onPressDo{ self.pantallaInstrucciones()}
		game.addVisual(tableroInicio)
		game.start()
	}

	method pantallaInstrucciones() {
		keyboard.x().onPressDo{ game.removeVisual(tableroInstrucciones)}
		game.addVisual(tableroInstrucciones)
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
		game.addVisual(vidasMotherShip) // agrega las vidas
		vidas.reiniciarVidas()
		game.addVisual(vidas)
		game.onTick(1000, "moverAlternado", { motherShip.moverAlternado()})
		keyboard.space().onPressDo{ mainShip.disparar()}
		game.onTick(200, "enemyFire" + self.identity().toString(), { motherShip.disparar()})
	}

	method agregarSoldados(ejeY) {
		const filaSoldados = [ new Soldado(position=game.at(3,ejeY)), new Soldado(position=game.at(6,ejeY)), new Soldado(position=game.at(9,ejeY)), new Soldado(position=game.at(12,ejeY)), new Soldado(position=game.at(15,ejeY)), new Soldado(position=game.at(18,ejeY)) ]
		filaSoldados.forEach{ soldier =>
			game.addVisual(soldier)
			game.onTick(1000, "moverAlternado", { soldier.moverNormal()})
			const randomInterval = 3000.randomUpTo(6000)
			game.onTick(randomInterval, "enemyFire" + self.identity().toString(), { soldier.disparar()})
		}
	}

	method agregarCapitanes(ejeY) {
		const filaCapitan = [ new Capitan(position=game.at(1,ejeY)), new Capitan(position=game.at(4,ejeY)), new Capitan(position=game.at(7,ejeY)), new Capitan(position=game.at(10,ejeY)), new Capitan(position=game.at(13,ejeY)), new Capitan(position=game.at(16,ejeY)), new Capitan(position=game.at(19,ejeY)) ]
		filaCapitan.forEach{ soldier =>
			game.addVisual(soldier)
			game.onTick(1000, "moverAlternado", { soldier.moverNormal()})
			const randomInterval = 3000.randomUpTo(6000)
			game.onTick(randomInterval, "enemyFire" + self.identity().toString(), { soldier.disparar()})
		}
	}

	method reiniciarJuego() {
		game.clear()
		vidas.reiniciarVidas() // Reiniciar las vidas
		puntos.reiniciarPuntos() // Reiniciar los puntos
		mainShip.reiniciar()
		self.configurar()
		self.juegoPrincipal() // Iniciar el juego principal
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

