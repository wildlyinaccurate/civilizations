# A sort-of wrapper around a StateMachine object
class Civilization.Game.State
  @create: ->
    fsm = StateMachine.create({
      initial: 'player'
      events: [
        {
          name: 'finishTurn'
          from: 'player'
          to: 'cpu'
        },
        {
          name: 'finishTurn'
          from: 'cpu'
          to: 'cpu'
        },
        {
          name: 'finishRound'
          from: ['cpu', 'player']
          to: 'player'
        },
        {
          name: 'finishGame'
          from: '*'
          to: 'finished'
        }
      ]
    })

    fsm
