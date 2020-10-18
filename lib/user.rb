require './lib/ship'
require './lib/board'

class User
  attr_reader :ships, :board
  def initialize
    @ships = make_ships
    @board = Board.new
  end



end
