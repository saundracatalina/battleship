require './lib/ship'
require './lib/board'

class Computer
  attr_reader :ships, :board
  def initialize
    @ships = make_ships
    @board = Board.new
  end
# #makes and assigs ships
  def make_ships
    ships = []
    ships << Ship.new("Cruiser", 3)
    ships << Ship.new("Submarine", 2)
    ships
  end

  def generate_ship_coordinate_placement_horizontal(ship)
    possible_number_placements  = []
    (1..4).each_cons(ship.length) do |consec_nums|
      possible_number_placements << consec_nums
    end
    # possible_number_placements = [[1, 2, 3], [2, 3, 4]]
    possible_horizontal_placements = Array.new
    possible_number_placements.each do |num_placement|
      (1..4).each do |num|
        possible_horizontal_placements  << num_placement.map do |column_num|
          (num + 64).chr + column_num.to_s
        end
      end
    end
    possible_horizontal_placements
  end

end
