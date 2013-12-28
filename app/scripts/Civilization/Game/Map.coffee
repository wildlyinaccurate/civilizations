class Civilization.Game.Map
  tiles: []

  constructor: (@xTiles, @yTiles) ->
    @resetTiles()

    @texture = new PIXI.RenderTexture(GAME_WIDTH, GAME_HEIGHT)
    @DO = new PIXI.Sprite(@texture)
    @DO.hitArea = new PIXI.Rectangle(0, 0, GAME_WIDTH, GAME_HEIGHT)
    @DO.setInteractive(true)
    @DO.click = @changeTileOnEvent(0xDD0000, 1)
    @DO.mouseover = @changeTileOnEvent(0xDD0000, 0.5)

  changeTileOnEvent: (color, alpha) ->
    (data) =>
      tile = @getTileAt(data.global.x, data.global.y)
      tile.fillColor = color
      tile.fillAlpha = alpha
      tile.redraw()

      @texture.render(tile.getDisplayObject())

      Manager.updateState()

  getTileAt: (x, y) ->
    absX = Math.floor(x / TILE_SIZE) * TILE_SIZE
    absY = Math.floor(y / TILE_SIZE) * TILE_SIZE

    xIndex = absX / TILE_SIZE
    yIndex = absY / TILE_SIZE

    @tiles[yIndex][xIndex]

  resetTiles: ->
    rows = @yTiles

    while rows--
      rowTiles = []
      rowCols = @xTiles

      while rowCols--
        rowTiles.push(new Civilization.Entity.Tile())

      @tiles.push(rowTiles)

  draw: ->
    x = 0
    y = 0

    for rowTiles in @tiles
      for tile in rowTiles
        tile.draw(x, y)
        @texture.render(tile.getDisplayObject())

        x += TILE_SIZE

      x = 0
      y += TILE_SIZE

  getDisplayObject: ->
    @DO
