class Civilization.Game.Text extends PIXI.Text

  constructor: (text = '', extraStyles = {}) ->
    styles = {
      font: '16px Monospace'
      align: 'left'
      fill: 'rgba(255, 255, 255, 1)'
      stroke: 'rgba(200, 200, 200, 0.5)'
      strokeThickness: 1
    }

    styles[key] = value for key, value of extraStyles

    super(text, styles)
