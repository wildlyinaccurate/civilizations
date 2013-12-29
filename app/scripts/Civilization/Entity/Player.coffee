class Civilization.Entity.Player
  constructor: (@name, @mainColor) ->
    @id = @mainColor
    @fillColor = @mainColor

    # Convert the long int color to a hex string for TinyColor
    @borderColor = tinycolor.darken(@mainColor.toString(16), 1)
