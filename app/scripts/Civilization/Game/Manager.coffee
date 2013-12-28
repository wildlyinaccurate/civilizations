class Civilization.Game.Manager
  constructor: ->
    @stage = new PIXI.Stage(0xFFFFFF, interactive = true)
    @renderer = PIXI.autoDetectRenderer(GAME_WIDTH, GAME_HEIGHT)
    @map = new Civilization.Game.Map(X_TILES, Y_TILES)
    @statistics = new Civilization.Game.Statistics()

    @info = new Civilization.Game.Text('', {
      font: '10pt Monospace'
      fill: '#000000'
    })
    @info.anchor.x = 0.5
    @info.position.x = GAME_WIDTH / 2
    @info.position.y = GAME_HEIGHT - INFOBAR_SIZE + 5 # 5px padding

    @map.getDisplayObject().click = (data) =>
      @statistics.turns++
      @map.handleClick(data)
      @updateState()

  start: ->
    @updateState()

    @info.setText(Civilization.Language.START_INFO)

    @stage.addChild(@map.getDisplayObject())
    @stage.addChild(@statistics.getDisplayObject())
    @stage.addChild(@info)

    @map.draw()
    @updateState()

  updateState: ->
    @statistics.update()
    @renderer.render(@stage)
