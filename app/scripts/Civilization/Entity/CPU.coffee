class Civilization.Entity.CPU extends Civilization.Entity.Player
  chooseTile: (map) ->
    tile = map.getRandomTile() until tile && !tile.owner

    LOGGER.log("#{@name} placed tile at [#{tile.coords.x}, #{tile.coords.y}]")
    map.setTileOwner(tile, @)
