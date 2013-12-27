TILE_SIZE = 40
X_TILES = 16
Y_TILES = 12
GAME_WIDTH = TILE_SIZE * X_TILES
GAME_HEIGHT = TILE_SIZE * Y_TILES
# GAME_WIDTH = document.body.clientWidth
# GAME_HEIGHT = document.body.clientHeight

Manager = new Civilization.Game.Manager()

document.body.appendChild(Manager.renderer.view)

Manager.start()
