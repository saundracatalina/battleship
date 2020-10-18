require './lib/ship'
require './lib/board'

class User
  attr_reader :ships, :board
  def initialize
    @ships = make_ships
    @board = Board.new
  end

  def make_ships
    ships = []
    ships << Ship.new("Cruiser", 3)
    ships << Ship.new("Submarine", 2)
    ships
  end

end
