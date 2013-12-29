class Civilization.Game.Logger
  history: []

  _log: (level, args) ->
    console[level].apply(console, Array::slice.call(args))

    @history.push
      level: level
      arguments: args

  log: ->
    @_log 'log', arguments

  debug: ->
    @_log 'debug', arguments

  info: ->
    @_log 'info', arguments

  warn: ->
    @_log 'warn', arguments

  error: ->
    @_log 'error', arguments
