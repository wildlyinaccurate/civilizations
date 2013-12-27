TILE_SIZE = 40
X_TILES = 16
Y_TILES = 12
GAME_WIDTH = TILE_SIZE * X_TILES
GAME_HEIGHT = TILE_SIZE * Y_TILES
# GAME_WIDTH = document.body.clientWidth
# GAME_HEIGHT = document.body.clientHeight

stage = new PIXI.Stage(0xFFFFFF, interactive = true)
renderer = PIXI.autoDetectRenderer(GAME_WIDTH, GAME_HEIGHT)

document.body.appendChild(renderer.view)

map = new Civilization.Game.Map(X_TILES, Y_TILES)
map.draw()

stage.addChild(map.getDisplayObject())

animate = ->
  renderer.render(stage)
  requestAnimFrame(animate)

requestAnimFrame(animate)
