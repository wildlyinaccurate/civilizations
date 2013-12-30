class Civilization.Game.Map
  tiles: []
  ownedTiles: 0

  constructor: (@xTiles, @yTiles) ->
    @resetTiles()

    @texture = new PIXI.RenderTexture(GAME_WIDTH, GAME_HEIGHT)
    @DO = new PIXI.Sprite(@texture)
    @DO.hitArea = new PIXI.Rectangle(0, 0, GAME_WIDTH, GAME_HEIGHT)
    @DO.interactive = true

  drawTile: (tile, x, y) ->
    tile.draw(x, y)
    @texture.render(tile.getDisplayObject())

  setTileOwner: (tile, owner) ->
    @ownedTiles++ unless tile.owner

    tile.owner = owner
    @drawTile(tile)
    @expandTiles()

  # Gets the tile at indexes x and y
  getTile: (x, y) ->
    @tiles[y]?[x]

  # Gets the tiles at 2D (pixel) co-ordinates x and y
  getTileAtCoords: (x, y) ->
    absX = Math.floor(x / TILE_SIZE) * TILE_SIZE
    absY = Math.floor(y / TILE_SIZE) * TILE_SIZE

    xIndex = absX / TILE_SIZE
    yIndex = absY / TILE_SIZE

    @getTile(xIndex, yIndex)

  getRandomTile: ->
    x = Civilization.Util.Math.randomIntBetween(0, @xTiles - 1)
    y = Civilization.Util.Math.randomIntBetween(0, @yTiles - 1)

    @getTile(x, y)

  # Unowned tiles which are touched by 2 or more tiles owned by a player wuill
  # become that player's.
  #
  # Owned tiles can be taken by another player if they are touched by 3 or more
  # tiles owned by that player.
  expandTiles: ->
    for rowTiles, y in @tiles
      for tile, x in rowTiles
        adjacentCoords = [
          [x, y - 1],
          [x, y + 1],
          [x - 1, y],
          [x + 1, y]
        ]

        neededForClaim = 3
        aTiles = {}

        for [ax, ay] in adjacentCoords
          aTile = @getTile(ax, ay)

          continue unless aTile and aTile.owner

          aTiles[aTile.owner.id] ?= owner: aTile.owner, count: 0
          aTiles[aTile.owner.id].count++

        for _, aTile of aTiles
          if aTile.count >= neededForClaim and aTile.owner isnt tile.owner
            LOGGER.log("Tile at [#{ax}, #{ay}] taken by #{aTile.owner.name}")
            @setTileOwner(tile, aTile.owner)

            break

  resetTiles: ->
    rows = @yTiles

    while rows--
      rowTiles = []
      rowCols = @xTiles

      while rowCols--
        rowTiles.push(new Civilization.Entity.Tile())

      @tiles.push(rowTiles)

  draw: ->
    for rowTiles, y in @tiles
      for tile, x in rowTiles
        @drawTile(tile, x * TILE_SIZE, y * TILE_SIZE)

  getDisplayObject: ->
    @DO
