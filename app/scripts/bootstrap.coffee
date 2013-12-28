# Need to figure out a better way to do this...
Civilization =
  Entity: {}
  Game: {}

# This could go somewhere meaningful too...
Function::property = (prop, desc) ->
  Object.defineProperty @prototype, prop, desc
