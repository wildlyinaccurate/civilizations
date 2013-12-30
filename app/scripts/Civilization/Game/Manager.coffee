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
      @state.finishTurn()

    @state = Civilization.Game.State.create()

    @state.onplayer = =>
      @info.setText(Civilization.Language.PLAYER_TURN)
      @updateState()

    @state.oncpu = =>
      @info.setText(Civilization.Language.CPU_TURN)
      @updateState()

      for cpu in @cpus
        break if @state.is('finished')

        tile = cpu.chooseTile(@map)

        LOGGER.log("#{cpu.name} placed tile at [#{tile.coords.x}, #{tile.coords.y}]")
        @map.setTileOwner(tile, cpu)
        @updateState()

        @state.finishTurn()

      @state.finishRound() unless @state.is('finished')

    @state.onbeforefinishTurn = =>
      if @map.ownedTiles == X_TILES * Y_TILES
        @state.finishGame()

        return false

    @state.onfinished = =>
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
      .reverse()

      LOGGER.log("Winner is #{ordered[0].owner.name} with #{ordered[0].score} points")
      @info.setText(Civilization.Language.GAME_FINISHED.format(
        ordered[0].owner.name,
        ordered[0].score
      ))
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
