class Civilization.Entity.Tile
  fillColor: 0xF2EDE4
  borderColor: 0xD9D1C7

  @property 'coords',
    get: ->
      x: @x / TILE_SIZE
      y: @y / TILE_SIZE

  @property 'owner',
    get: -> @_owner
    set: (@_owner) ->
      @fillColor = @_owner.fillColor
      @borderColor = @_owner.borderColor

  constructor: ->
    @graphics = new PIXI.Graphics()

  draw: (x, y) ->
    if x? and y?
      @x = x
      @y = y
    else
      @graphics.clear()

    @graphics.beginFill(@fillColor)
    @graphics.lineStyle(1, @borderColor, 1)
    @graphics.drawRect(@x, @y, TILE_SIZE, TILE_SIZE)
    @graphics.endFill()

  getDisplayObject: ->
    @graphics
