class Civilization.Entity.CPU extends Civilization.Entity.Player
  chooseTile: (map) ->
    tile = map.getRandomTile() until tile && !tile.owner
    tile.owner = @
    map.updateTile(tile)
