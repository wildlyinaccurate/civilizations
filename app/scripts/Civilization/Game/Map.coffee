class Civilization.Game.Map
  tiles: []

  constructor: (@xTiles, @yTiles) ->
    @resetTiles()

    @texture = new PIXI.RenderTexture(GAME_WIDTH, GAME_HEIGHT)
    @DO = new PIXI.Sprite(@texture)
    @DO.hitArea = new PIXI.Rectangle(0, 0, GAME_WIDTH, GAME_HEIGHT)
    @DO.interactive = true

  updateTile: (tile) ->
    tile.redraw()
    @texture.render(tile.getDisplayObject())

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

        neededForClaim = if tile.owner then 3 else 2
        adjacentTiles = {}

        for [x, y] in adjacentCoords
          adjacentTile = @getTile(x, y)

          continue unless adjacentTile and adjacentTile.owner

          adjacentTiles[adjacentTile.owner.id] ?= owner: adjacentTile.owner, count: 0
          adjacentTiles[adjacentTile.owner.id].count++

        for _, adjacentTile of adjacentTiles
          if adjacentTile.count >= neededForClaim
            tile.owner = adjacentTile.owner
            @updateTile(tile)

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
        tile.draw(x * TILE_SIZE, y * TILE_SIZE)
        @texture.render(tile.getDisplayObject())

  getDisplayObject: ->
    @DO
