class Civilization.Entity.Tile
  fillAlpha: 1
  fillColor: 0x22AA66
  borderColor: 0xDDDDDD

  constructor: ->
    @graphics = new PIXI.Graphics()

  draw: (@x, @y) ->
    @graphics.beginFill(@fillColor, @fillAlpha)
    @graphics.lineStyle(1, @borderColor, 1)
    @graphics.drawRect(@x, @y, TILE_SIZE, TILE_SIZE)
    @graphics.endFill()

  # Clears and re-draws the tile at its last location
  redraw: ->
    @graphics.clear()
    @draw(@x, @y)

  getDisplayObject: ->
    @graphics
