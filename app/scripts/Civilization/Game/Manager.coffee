class Civilization.Game.Manager
  # Aliases
  Map = Civilization.Game.Map

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

        tile = cpu.chooseTile(@map)

        LOGGER.log("#{cpu.name} placed tile at [#{tile.coords.x}, #{tile.coords.y}]")
        @map.setTileOwner(tile, cpu)
        @map.expandTiles()
        @updateState()

        @state.finishTurn(cpu)

      @state.finishRound() unless @state.is('finished')

    @state.onfinishTurn = (event, from, to, player) =>
      @state.finishGame() if @map.ownedTiles == X_TILES * Y_TILES

    @state.onenterfinished = =>
      scores = {}

      for rowTiles in @map.tiles
        for tile in rowTiles
          scores[tile.owner.id] ?= owner: tile.owner, score: 0
          scores[tile.owner.id].score += 10

      ordered = []

      for _, score of scores
        LOGGER.log("#{score.owner.name} scored #{score.score}")
        ordered.push(score)


      ordered.sort (a, b) ->
        return -1 if a.score < b.score
        return 1 if a.score > b.score
        return 0

      @info.setText(Civilization.Language.GAME_FINISHED.format(ordered[0].owner.name, ordered[0].score))
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
