class Civilization.Game.Manager
  constructor: (@player, @cpus) ->
    @renderer = PIXI.autoDetectRenderer(GAME_WIDTH, GAME_HEIGHT)
    @stage = new PIXI.Stage(0xFFFFFF, interactive = true)

    @info = new Civilization.Game.InfoBar()

    @map = new Civilization.Game.Map(X_TILES, Y_TILES)
    @map.getDisplayObject().click = (data) =>
      return unless @state.is('player')

      tile = @map.getTileAtCoords(data.global.x, data.global.y)

      return if tile.owner

      LOGGER.log("#{@player.name} placed tile at [#{tile.coords.x}, #{tile.coords.y}]")
      @map.setTileOwner(tile, @player)

      @updateState()
      @state.finishTurn(player)

    @state = Civilization.Game.State.create()

    @state.onplayer = =>
      @info.setText(Civilization.Language.PLAYER_TURN)
      @updateState()

    @state.onentercpu = =>
      @info.setText(Civilization.Language.CPU_TURN)
      @updateState()

      for cpu in @cpus
        break if @state.is('finished')

        cpu.chooseTile(@map)
        @map.expandTiles()
        @updateState()

        @state.finishTurn(cpu)

      @state.finishRound() unless @state.is('finished')

    @state.onfinishTurn = (event, from, to, player) =>
      @state.finishGame() if @map.ownedTiles == X_TILES * Y_TILES

    @state.onenterfinished = =>
      @info.setText(Civilization.Language.GAME_FINISHED)
      @updateState()

  start: ->
    @updateState()

    @info.setText(Civilization.Language.PLAYER_TURN)

    @stage.addChild(@map.getDisplayObject())
    @stage.addChild(@info.getDisplayObject())

    @map.draw()
    @updateState()

  updateState: ->
    @renderer.render(@stage)
