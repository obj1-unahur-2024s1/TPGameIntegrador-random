import wollok.game.*
import ships.*

class Laser {
	
	var property color
	var property position
	const image = "image/laser.png"

	method position() = position

	method image() {
		return if(color=="rojo")"image/laser_rojo.png" else if(color=="verde") "image/laser_verde.png" else if(color=="azul") "image/laser_azul.png" else image
	}

	method moverArriba() {
		game.onTick(50, self.identity().toString(), { self.desplazarArriba()})
		game.onCollideDo(self, { algo =>
			if(algo.color()==color){
				algo.impactoLaser()
				self.impactoLaser()
			}
		})
	}

	method moverAbajo() {
		game.onTick(200, self.identity().toString(), { self.desplazarAbajo()})
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
		if (position.y() < 0) {
			self.impactoLaser()
		} else {
			position = position.down(2)
		}
	}

}

