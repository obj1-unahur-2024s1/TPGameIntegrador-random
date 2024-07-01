import wollok.game.*
import ships.*
import sonidos.*
import tablero.*
import vidas.*

object juego {

	const mainShip = new MainShip(color = "")
	const mainShipCol = new MainShip(color = "rojo")
	var modoColores = false

	method modoColores() = modoColores

	method configurar() {
		game.cellSize(32)
		game.height(20)
		game.width(32)
		game.title("Space Ship")
		game.boardGround("image/spaceBG.jpg")
	}

	method iniciarJuego() {
		self.configurar()
		self.pantallaInicial()
		game.start()
	}

	method pantallaInicial() {
		keyboard.enter().onPressDo{ self.juegoPrincipal()}
		keyboard.down().onPressDo{ modoColores = true}
		keyboard.up().onPressDo{ modoColores = false}
		keyboard.space().onPressDo{ self.pantallaInstrucciones()}
		game.addVisual(tableroInicio)
		game.addVisual(tableroDificultad)
		musicaDeFondo.iniciar()
	}

	method pantallaInstrucciones() {
		keyboard.x().onPressDo{ game.removeVisual(tableroInstrucciones)}
		game.addVisual(tableroInstrucciones)
	}

	method juegoPrincipal() {
		game.clear()
		self.iniciar()
	}

	method iniciar() {
		self.agregarCapitanes(15)
		self.agregarSoldados(13)
		self.agregarPlayer()
		game.addVisual(vidas)
	}

	method agregarPlayer() {
		if (modoColores) {
			game.addVisualCharacter(mainShipCol)
			keyboard.space().onPressDo{ mainShipCol.disparar()}
			keyboard.z().onPressDo{ mainShipCol.cambiarColor()}
		} else {
			game.addVisualCharacter(mainShip)
			keyboard.space().onPressDo{ mainShip.disparar()}
		}
	}

	method gameOver() {
		game.clear()
		game.addVisual(tableroGameOver)
		keyboard.enter().onPressDo{ self.reiniciarJuego()}
		musicaDeFondo.sacarMusica()
		sonidoGameOver.play()
	}

	method youWin() {
		game.clear()
		musicaDeFondo.sacarMusica()
		sonidoWin.play()
		game.addVisual(tableroYouWin)
		keyboard.enter().onPressDo{ self.reiniciarJuego()}
	}

	method jefeFinal() {
		game.clear()
		self.agregarMotherShip()
		self.agregarPlayer()
		vidas.reiniciarVidas()
		game.addVisual(vidas)
	}

	method agregarMotherShip() {
		const motherShip = new MotherShip(color = "", position = game.at(6, 16))
		const motherShipCol = new MotherShip(color = "rojo", position = game.at(6, 16))
		if (modoColores) {
			game.addVisual(motherShipCol)
			game.addVisual(vidasMotherShip) // agrega las vidas
			game.onTick(1000, "moverAlternado", { motherShipCol.moverAlternado()})
			game.onTick(200, "enemyFire" + self.identity().toString(), { motherShipCol.disparar()})
			game.onTick(1200, "alternarColores" + self.identity().toString(), { motherShipCol.cambiarColor()})
		} else {
			game.addVisual(motherShip)
			game.addVisual(vidasMotherShip) // agrega las vidas
			game.onTick(1000, "moverAlternado", { motherShip.moverAlternado()})
			game.onTick(200, "enemyFire" + self.identity().toString(), { motherShip.disparar()})
		}
	}

	method agregarSoldados(ejeY) {
		const filaSoldados = [ new Soldado(color="", position=game.at(3,ejeY)), new Soldado(color="", position=game.at(6,ejeY)), new Soldado(color="", position=game.at(9,ejeY)), new Soldado(color="", position=game.at(12,ejeY)), new Soldado(color="", position=game.at(15,ejeY)), new Soldado(color="", position=game.at(18,ejeY)) ]
		const filaSoldadosCol = [ new Soldado(color="verde", position=game.at(3,ejeY)), new Soldado(color="verde", position=game.at(6,ejeY)), new Soldado(color="verde", position=game.at(9,ejeY)), new Soldado(color="verde", position=game.at(12,ejeY)), new Soldado(color="verde", position=game.at(15,ejeY)), new Soldado(color="verde", position=game.at(18,ejeY)) ]
		if (modoColores) {
			filaSoldadosCol.forEach{ soldier =>
				game.addVisual(soldier)
				game.onTick(1000, "moverAlternado", { soldier.moverNormal()})
				const randomInterval = 3000.randomUpTo(6000)
				game.onTick(randomInterval, "enemyFire" + self.identity().toString(), { soldier.disparar()})
			}
		} else {
			filaSoldados.forEach{ soldier =>
				game.addVisual(soldier)
				game.onTick(1000, "moverAlternado", { soldier.moverNormal()})
				const randomInterval = 3000.randomUpTo(6000)
				game.onTick(randomInterval, "enemyFire" + self.identity().toString(), { soldier.disparar()})
			}
		}
	}

	method agregarCapitanes(ejeY) {
		const filaCapitan = [ new Capitan(color="", position=game.at(1,ejeY)), new Capitan(color="", position=game.at(4,ejeY)), new Capitan(color="", position=game.at(7,ejeY)), new Capitan(color="", position=game.at(10,ejeY)), new Capitan(color="", position=game.at(13,ejeY)), new Capitan(color="", position=game.at(16,ejeY)), new Capitan(color="", position=game.at(19,ejeY)) ]
		const filaCapitanCol = [ new Capitan(color="rojo", position=game.at(1,ejeY)), new Capitan(color="azul", position=game.at(4,ejeY)), new Capitan(color="rojo", position=game.at(7,ejeY)), new Capitan(color="azul", position=game.at(10,ejeY)), new Capitan(color="rojo", position=game.at(13,ejeY)), new Capitan(color="azul", position=game.at(16,ejeY)), new Capitan(color="rojo", position=game.at(19,ejeY)) ]
		if (modoColores) {
			filaCapitanCol.forEach{ soldier =>
				game.addVisual(soldier)
				game.onTick(1000, "moverAlternado", { soldier.moverNormal()})
				const randomInterval = 3000.randomUpTo(6000)
				game.onTick(randomInterval, "enemyFire" + self.identity().toString(), { soldier.disparar()})
			}
		} else {
			filaCapitan.forEach{ soldier =>
				game.addVisual(soldier)
				game.onTick(1000, "moverAlternado", { soldier.moverNormal()})
				const randomInterval = 3000.randomUpTo(6000)
				game.onTick(randomInterval, "enemyFire" + self.identity().toString(), { soldier.disparar()})
			}
		}
	}


	method reiniciarJuego() {
		game.clear()
		musicaDeFondo.reiniciar()
		vidas.reiniciarVidas()
		vidasMotherShip.reiniciarVidas() // Reiniciar las vidas
		puntos.reiniciarPuntos() // Reiniciar los puntos
		self.pantallaInicial() // Iniciar el juego principal
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

