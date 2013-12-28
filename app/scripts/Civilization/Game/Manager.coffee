class Civilization.Game.Manager
  constructor: (@player) ->
    @stage = new PIXI.Stage(0xFFFFFF, interactive = true)
    @renderer = PIXI.autoDetectRenderer(GAME_WIDTH, GAME_HEIGHT)
    @map = new Civilization.Game.Map(X_TILES, Y_TILES)
    @statistics = new Civilization.Game.Statistics()
    @info = new Civilization.Game.InfoBar()

    @map.getDisplayObject().click = (data) =>
      tile = @map.getTileAt(data.global.x, data.global.y)
      tile.setOwner(@player)
      @map.updateTile(tile)

      @statistics.turns++

      @updateState()

  start: ->
    @updateState()

    @info.setText(Civilization.Language.START_INFO)

    @stage.addChild(@map.getDisplayObject())
    @stage.addChild(@statistics.getDisplayObject())
    @stage.addChild(@info.getDisplayObject())

    @map.draw()
    @updateState()

  updateState: ->
    @statistics.update()
    @renderer.render(@stage)
