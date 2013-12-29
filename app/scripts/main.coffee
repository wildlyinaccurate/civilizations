INFOBAR_SIZE = 30
TILE_SIZE = 40
X_TILES = 16
Y_TILES = 12
GAME_WIDTH = TILE_SIZE * X_TILES
GAME_HEIGHT = TILE_SIZE * Y_TILES + INFOBAR_SIZE
# GAME_WIDTH = document.body.clientWidth
# GAME_HEIGHT = document.body.clientHeight

cpuColors = [
  0x5CB85C,
  0xF0AD4E,
  0xD9534F,
  0x5BC0DE
]

cpus = []
cpus.push(new Civilization.Entity.CPU("CPU #{i + 1}", cpuColors[i])) for i in [0..1]
player = new Civilization.Entity.Player('Player 1', 0x428BCA)

Manager = new Civilization.Game.Manager(player, cpus)

document.body.appendChild(Manager.renderer.view)

Manager.start()
