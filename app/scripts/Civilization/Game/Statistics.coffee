class Civilization.Game.Statistics
  turns: 0

  constructor: ->
    textPadding = x: 10, y: 10
    textWidth = 140

    @text = new Civilization.Game.Text('', {
      wordWrap: true
      wordWrapWidth: textWidth
    })

    @text.anchor.x = 1
    @text.position.x = GAME_WIDTH - textPadding.x
    @text.position.y = textPadding.y

    @update()

  update: ->
    @text.setText """
    Turns: #{@turns}
    """

  getDisplayObject: ->
    @text
