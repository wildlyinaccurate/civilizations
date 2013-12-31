INFOBAR_SIZE = 30
TILE_SIZE = 40

# User-configured values
CPU_COUNT = 0
X_TILES = 0
Y_TILES = 0
GAME_WIDTH = 0
GAME_HEIGHT = 0

LOGGER = new Civilization.Game.Logger()

$ = (id) ->
  document.getElementById(id)

loadGame = ->
  X_TILES = parseInt($('x-tiles').value, 10)
  Y_TILES = parseInt($('y-tiles').value, 10)
  GAME_WIDTH = TILE_SIZE * X_TILES
  GAME_HEIGHT = TILE_SIZE * Y_TILES + INFOBAR_SIZE

  CPU_COUNT = parseInt($('cpu-count').value, 10)
  cpuColors = [
    0x5CB85C,
    0xF0AD4E,
    0xD9534F,
    0x5BC0DE
  ]

  cpus = []
  cpus.push(new Civilization.Entity.CPU("CPU #{i}", cpuColors[i - 1])) for i in [1..CPU_COUNT]
  player = new Civilization.Entity.Player('Player 1', 0x428BCA)

  LOGGER.log("#{cpus.length} CPU players have joined the game")
  LOGGER.log("#{player.name} has joined the game")

  Manager = new Civilization.Game.Manager(player, cpus)
  document.body.appendChild(Manager.renderer.view)
  Manager.start()

$('game-parameters').addEventListener('submit', (e) ->
  $('start-screen').style.display = 'none'
  loadGame()
  e.preventDefault()
, false)
