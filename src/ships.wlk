import wollok.game.*
import weapons.*
import example.*
import sonidos.*

class Nave {

	var impactado = false

	method disparar()

	method explotar()

	method impactoLaser() {
		impactado = true
		self.explotar()
		explosion.play()
		self.desaparecer()
	}

	method desaparecer() {
		game.schedule(500, { game.removeVisual(self)})
	}

}

class MainShip inherits Nave {

	var position = game.at(game.width() / 2, 0)
	var image = "image/Main Ship - Base - Full health.png"

	method image() = image

	method image(nuevaImagen) {
		image = nuevaImagen
	}

	method position() = position

	method position(nuevaPosicion) {
		position = nuevaPosicion
	}

	override method disparar() {
		if (!impactado) {
			const unLaser = new Laser(position = game.at(position.x(), position.y() + 1.5))
			sonidoDisparos.play()
			game.addVisual(unLaser)
			unLaser.moverArriba()
		}
	}

	override method impactoLaser() {
		game.sound("assets/whoosh.mp3").play()
		vidas.perderVida()
		if (vidas.vidas() == 0) super()
	}

	override method explotar() {
		self.image("image/explosion-soldado.png")
	}

	method reiniciar() {
		self.image("image/Main Ship - Base - Full health.png")
		impactado = !impactado
	}

}

class EnemyShip inherits Nave {
	var cuenta = 0
	const limiteCuenta = 11
	var moverADerecha = true
	var property position

	method position() = position

	method moverDerecha() {
		self.position(self.position().right(1))
		//position = game.at(position.x() + 1, position.y())
	}

	method moverIzquierda() {
		self.position(self.position().left(1))
		//position = game.at(position.x() - 1, position.y())
	}

	method moverAlternado() {
		if (moverADerecha) self.moverDerecha() else self.moverIzquierda()
		moverADerecha = !moverADerecha
	}
	
	method moverNormal() {
		if (cuenta!=limiteCuenta and moverADerecha) {
			self.moverDerecha()
			cuenta+=1
		} else if(cuenta!=limiteCuenta and !moverADerecha){
			self.moverIzquierda()
			cuenta+=1
		}else{
			cuenta=0
			moverADerecha = !moverADerecha
		}
		//if ((cuenta!=4) and moverADerecha) {self.moverDerecha() cuenta+=1}
		//else if((cuenta!=4) and !moverADerecha){self.moverIzquierda()cuenta+=1} else
		//cuenta=0
		//moverADerecha = !moverADerecha
	}

	override method impactoLaser() {
		super()
		puntos.sumarPunto()
	}

	override method disparar() {
		if (!impactado) {
			const unLaser = new Laser(position = game.at(position.x(), position.y() - 1))
			game.addVisual(unLaser)
			unLaser.moverAbajo()
		}
	}

}

class Capitan inherits EnemyShip {

	var image = "image/captain.png"

	method image() = image

	method image(nuevaImagen) {
		image = nuevaImagen
	}

	override method explotar() {
		self.image("image/explosion-soldado.png")
	}

}

class Soldado inherits EnemyShip {

	var image = "image/soldier.png"

	method image() = image

	method image(nuevaImagen) {
		image = nuevaImagen
	}

	override method explotar() {
		self.image("image/explosion-soldado.png")
	}

}

class MotherShip inherits EnemyShip {

	var image = "image/motherShip.png"

	method image() = image

	method image(nuevaImagen) {
		image = nuevaImagen
	}

	override method disparar() {
		if (!impactado) {
			const unLaser = new Laser(position = game.at(position.x(), position.y() - 1.5))
			sonidoDisparos.play()
			game.addVisual(unLaser)
			unLaser.moverAbajo()
		}
	}

	override method impactoLaser() {
		if (!impactado) {
			vidasMotherShip.perderVida()
			if (vidasMotherShip.vidasMother() == 0) {
				self.explotar()
				juego.youWin()
			}
		}
	}

	override method explotar() {
		self.image("image/explosion-soldado.png")
		game.removeVisual(self)
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

}

