# A sort-of wrapper around a StateMachine object
class Civilization.Game.State
  @create: ->
    fsm = StateMachine.create({
      initial: 'idle'
      events: [
        {
          name: 'turnOver'
          from: 'idle'
          to: 'cpu'
        },
        {
          name: 'cpuTurnOver'
          from: 'cpu'
          to: 'idle'
        }
      ]
    })

    fsm
