class Civilization.Game.Map
  ownedTiles: 0

  constructor: (@xTiles, @yTiles) ->
    @tiles = ndarray([], [@xTiles, @yTiles])
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
    @expandTilesFrom(tile)

  # Gets the tile at indexes x and y
  getTile: (x, y) ->
    @tiles.get(x, y)

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

  getAdjacentTiles: (tile) ->
    x = tile.coords.x
    y = tile.coords.y

    [
      @tiles.get(x, y - 1),
      @tiles.get(x, y + 1),
      @tiles.get(x + 1, y),
      @tiles.get(x - 1, y)
    ]

  # Tiles which are touched by 3 or more tiles owned by a player will become
  # that player's.
  #
  # @param {Tile} refTile The tile from which to expand
  expandTilesFrom: (refTile) ->
    neededForClaim = 3
    x = refTile.coords.x
    y = refTile.coords.y

    for tile in @getAdjacentTiles(refTile)
      continue unless tile

      aTiles = {}

      for aTile in @getAdjacentTiles(tile)
        continue unless aTile and aTile.owner

        aTiles[aTile.owner.id] ?= owner: aTile.owner, count: 0
        aTiles[aTile.owner.id].count++

      for _, aTile of aTiles
        ax = tile.coords.x
        ay = tile.coords.y

        if aTile.count >= neededForClaim and aTile.owner isnt tile.owner
          LOGGER.log("Tile at [#{ax}, #{ay}] taken by #{aTile.owner.name}")
          @setTileOwner(tile, aTile.owner)

          break

  # Run the specified function on each tile
  eachTile: (cb) ->
    for x in [0..@tiles.shape[0] - 1]
      for y in [0..@tiles.shape[1] - 1]
        cb(@tiles.get(x, y), x, y)

  resetTiles: ->
    @eachTile (_, x, y) =>
      @tiles.set(x, y, new Civilization.Entity.Tile())

  draw: ->
    @eachTile (tile, x, y) =>
      @drawTile(tile, x * TILE_SIZE, y * TILE_SIZE)

  getDisplayObject: ->
    @DO
