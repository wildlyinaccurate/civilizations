class Civilization.Game.Manager
  constructor: ->
    @stage = new PIXI.Stage(0xFFFFFF, interactive = true)
    @renderer = PIXI.autoDetectRenderer(GAME_WIDTH, GAME_HEIGHT)
    @map = new Civilization.Game.Map(X_TILES, Y_TILES)

  start: ->
    @updateState()
    @stage.addChild(@map.getDisplayObject())
    @map.draw()
    @updateState()

  updateState: ->
    @renderer.render(@stage)
