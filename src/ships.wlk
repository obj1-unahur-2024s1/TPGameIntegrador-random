import wollok.game.*
import weapons.*
import juego.*
import sonidos.*
import vidas.*

class Nave {
	var property color
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
	method cambiarColor(){
		if(color=="rojo") color = "verde"
		else if(color=="verde") color = "azul"
		else if(color=="azul") color = "rojo"
	}
}

class MainShip inherits Nave {

	var position = game.at(game.width() / 2, 0)
	var image = "image/Main_Ship.png"

	method image() {
		return if(color=="rojo")"image/Main_Ship_rojo.png" else if(color=="verde") "image/Main_Ship_verde.png" else if(color=="azul") "image/Main_Ship_azul.png" else image
	}

	method image(nuevaImagen) {
		image = nuevaImagen
	}

	method position() = position

	method position(nuevaPosicion) {
		position = nuevaPosicion
	}

	override method disparar() {
		if (!impactado) {
			const unLaser = new Laser(color=color, position = game.at(position.x(), position.y() + 1.5))
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
		//color = ""
		self.image("image/explosion-soldado.png")
	}

	method reiniciar() {
		//self.image("image/Main_Ship.png")
		self.image(if(color=="rojo")"image/Main_Ship_rojo.png" else if(color=="verde") "image/Main_Ship_verde.png" else if(color=="azul") "image/Main_Ship_azul.png" else  "image/Main_Ship.png")
		impactado = false
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
	// position = game.at(position.x() + 1, position.y())
	}

	method moverIzquierda() {
		self.position(self.position().left(1))
	// position = game.at(position.x() - 1, position.y())
	}

	method moverAlternado() {
		if (moverADerecha) self.moverDerecha() else self.moverIzquierda()
		moverADerecha = !moverADerecha
	}

	method moverNormal() {
		if (cuenta != limiteCuenta and moverADerecha) {
			self.moverDerecha()
			cuenta += 1
		} else if (cuenta != limiteCuenta and !moverADerecha) {
			self.moverIzquierda()
			cuenta += 1
		} else {
			cuenta = 0
			moverADerecha = !moverADerecha
		}
	// if ((cuenta!=4) and moverADerecha) {self.moverDerecha() cuenta+=1}
	// else if((cuenta!=4) and !moverADerecha){self.moverIzquierda()cuenta+=1} else
	// cuenta=0
	// moverADerecha = !moverADerecha
	}

	override method impactoLaser() {
		super()
		juego.sumarPunto()
	}

	override method disparar() {
		if (!impactado) {
			const unLaser = new Laser(color="", position = game.at(position.x(), position.y() - 1))
			game.addVisual(unLaser)
			unLaser.moverAbajo()
		}
	}

}

class Capitan inherits EnemyShip {

	var image = "image/captain.png"

	method image() {
		return if(color=="rojo")"image/captain_rojo.png" else if(color=="verde") "image/captain_verde.png" else if(color=="azul") "image/captain_azul.png" else image
	}

	method image(nuevaImagen) {
		image = nuevaImagen
	}

	override method explotar() {
		color = ""
		self.image("image/explosion-soldado.png")
	}

}

class Soldado inherits EnemyShip {

	var image = "image/soldier.png"

	method image() {
		return if(color=="rojo")"image/soldier_rojo.png" else if(color=="verde") "image/soldier_verde.png" else if(color=="azul") "image/soldier_azul.png" else image
	}

	method image(nuevaImagen) {
		image = nuevaImagen
	}

	override method explotar() {
		color = ""
		self.image("image/explosion-soldado.png")
	}

}

class MotherShip inherits EnemyShip {

	var image = "image/motherShip.png"

	method image() {
		return if(color=="rojo")"image/motherShip_rojo.png" else if(color=="verde") "image/motherShip_verde.png" else if(color=="azul") "image/motherShip_azul.png" else image
	}

	method image(nuevaImagen) {
		image = nuevaImagen
	}

	override method disparar() {
		if (!impactado) {
			const x = 0.randomUpTo(game.width()).truncate(0)
			const unLaser = new Laser(color="", position = game.at(x, position.y() - 1.5))
			//sonidoDisparos.play() quito sonido laser
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
		color = ""
		self.image("image/explosion-soldado.png")
		game.removeVisual(self)
	}

}

