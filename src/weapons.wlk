import wollok.game.*
import ships.*

class Laser {

	var property position
	const image = "image/laser.png"

	method position() = position

	method image() = image

	method moverArriba() {
		game.onTick(50, self.identity().toString(), { self.desplazarArriba()})
		game.onCollideDo(self, { algo =>
			algo.impactoLaser()
			self.impactoLaser()
		})
	}

	method moverAbajo() {
		game.onTick(75, self.identity().toString(), { self.desplazarAbajo()})
		game.onCollideDo(self, { algo =>
			algo.impactoLaser()
			self.impactoLaser()
		})
	}

	method impactoLaser() {
		game.removeTickEvent(self.identity().toString())
		game.removeVisual(self)
	}

	method desplazarArriba() {
		if (position.y() >= game.height()) {
			self.impactoLaser()
		} else position = position.up(1)
	}

	method desplazarAbajo() {
		position = position.down(1)
		if (position.y() < 0) {
			self.impactoLaser()
		}
	}

}

