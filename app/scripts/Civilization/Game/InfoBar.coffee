class Civilization.Game.InfoBar
  constructor: ->
    @text = new Civilization.Game.Text('', {
      font: '10pt Monospace'
      fill: '#000000'
    })
    @text.anchor.x = 0.5
    @text.position.x = GAME_WIDTH / 2
    @text.position.y = GAME_HEIGHT - INFOBAR_SIZE + 5 # 5px padding

  setText: (text) ->
    @text.setText(text)

  getDisplayObject: ->
    @text
