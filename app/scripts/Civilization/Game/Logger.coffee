class Civilization.Game.Logger
  history: []

  _log: (level, args) ->
    console[level](Array::slice.call(args))

    @history.push
      level: level
      arguments: args

  log: ->
    @_log 'log', arguments

  info: ->
    @_log 'info', arguments

  warn: ->
    @_log 'warn', arguments

  error: ->
    @_log 'error', arguments
