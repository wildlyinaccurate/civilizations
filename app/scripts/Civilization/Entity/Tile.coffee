class Civilization.Entity.Tile
  fillColor: 0x22AA66
  borderColor: 0x99CCAA

  constructor: ->
    @graphics = new PIXI.Graphics()

  draw: (@x, @y) ->
    @graphics.beginFill(@fillColor)
    @graphics.lineStyle(1, @borderColor, 1)
    @graphics.drawRect(@x, @y, TILE_SIZE, TILE_SIZE)
    @graphics.endFill()

  # Clears and re-draws the tile at its last location
  redraw: ->
    @graphics.clear()
    @draw(@x, @y)

  getDisplayObject: ->
    @graphics
