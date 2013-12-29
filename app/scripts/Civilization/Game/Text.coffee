class Civilization.Game.Text extends PIXI.Text

  constructor: (text = '', extraStyles = {}) ->
    styles = {
      font: '16px Monospace'
      align: 'left'
      fill: 'rgba(80, 80, 80, 0.65)'
      stroke: 'rgba(0, 0, 0, 0.4)'
      strokeThickness: 1
    }

    styles[key] = value for key, value of extraStyles

    super(text, styles)
