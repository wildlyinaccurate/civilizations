# A sort-of wrapper around a StateMachine object
class Civilization.Game.State
  @create: ->
    fsm = StateMachine.create({
      initial: 'idle'
      events: [
        {
          name: 'finishPlayerTurn'
          from: 'idle'
          to: 'cpu'
        },
        {
          name: 'finishCpuTurn'
          from: 'cpu'
          to: 'idle'
        }
      ]
    })

    fsm
