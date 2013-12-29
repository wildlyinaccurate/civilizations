INFOBAR_SIZE = 30
TILE_SIZE = 40
X_TILES = 16
Y_TILES = 12
GAME_WIDTH = TILE_SIZE * X_TILES
GAME_HEIGHT = TILE_SIZE * Y_TILES + INFOBAR_SIZE

LOGGER = new Civilization.Game.Logger()

loadGame = ->
  cpuCount = 2
  cpuColors = [
    0x5CB85C,
    0xF0AD4E,
    0xD9534F,
    0x5BC0DE
  ]

  cpus = []
  cpus.push(new Civilization.Entity.CPU("CPU #{i}", cpuColors[i - 1])) for i in [1..cpuCount]
  player = new Civilization.Entity.Player('Player 1', 0x428BCA)

  LOGGER.log("#{cpus.length} CPU players have joined the game")
  LOGGER.log("#{player.name} has joined the game")

  Manager = new Civilization.Game.Manager(player, cpus)
  document.body.appendChild(Manager.renderer.view)
  Manager.start()
