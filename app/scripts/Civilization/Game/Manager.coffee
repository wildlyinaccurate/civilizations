class Civilization.Game.Manager
  constructor: (@player, @cpus) ->
    @renderer = PIXI.autoDetectRenderer(GAME_WIDTH, GAME_HEIGHT)
    @stage = new PIXI.Stage(0xFFFFFF, interactive = true)

    @statistics = new Civilization.Game.Statistics()
    @info = new Civilization.Game.InfoBar()

    @map = new Civilization.Game.Map(X_TILES, Y_TILES)
    @map.getDisplayObject().click = (data) =>
      return unless @state.is('idle')

      tile = @map.getTileAt(data.global.x, data.global.y)

      return if tile.owner

      tile.owner = @player
      @map.updateTile(tile)

      @statistics.turns++

      @state.turnOver()
      @updateState()

    @state = Civilization.Game.State.create()
    @state.oncpu = =>
      @info.setText(Civilization.Language.CPU_TURN)
      cpu.chooseTile(@map) for cpu in @cpus
      @state.cpuTurnOver()

    @state.onidle = =>
      @info.setText(Civilization.Language.PLAYER_TURN)

  start: ->
    @updateState()

    @info.setText(Civilization.Language.PLAYER_TURN)

    @stage.addChild(@map.getDisplayObject())
    @stage.addChild(@statistics.getDisplayObject())
    @stage.addChild(@info.getDisplayObject())

    @map.draw()
    @updateState()

  updateState: ->
    @statistics.update()
    @renderer.render(@stage)
