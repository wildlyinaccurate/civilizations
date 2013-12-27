class Civilization.Entity.Civilization

  constructor: (@name) ->
    @cities = []

  addCity: (city) ->
    @cities.push city
