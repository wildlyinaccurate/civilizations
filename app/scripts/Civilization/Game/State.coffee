# A sort-of wrapper around a StateMachine object
class Civilization.Game.State
  @create: ->
    fsm = StateMachine.create({
      initial: 'init'
      events: [
        {
          name: 'firstTurn'
          from: 'init'
          to: 'idle'
        },
        {
          name: 'turnOver'
          from: ['idle', 'init']
          to: 'cpu'
        }
      ]
    })

    fsm
