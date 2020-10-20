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

  def random_placement(ship)
    horizontal_and_vertical_placements(ship).sample
  end

  def horizontal_and_vertical_placements(ship)
    generate_ship_coordinate_placement_horizontal(ship) +
    generate_ship_coordinate_placement_vertical(ship)
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

  def generate_ship_coordinate_placement_vertical(ship)
    possible_letter_placements  = Array.new
    (1..4).each_cons(ship.length) do |consec_nums|
      consec_letter_placement = consec_nums.map do |num|
        (num + 64).chr
      end
      possible_letter_placements << consec_letter_placement
      # possible_letter_placements = [["A", "B", "C"], ["B", "C", "D"]]
    end

    possible_vertical_placements = Array.new
    possible_letter_placements.each do |letter_placement|
      (1..4).each do |num|
        possible_vertical_placements  << letter_placement.map do |cap_letter|
          cap_letter + num.to_s
        end
      end
    end
    possible_vertical_placements
  end

  def place_ships
    @ships.each do |ship|
      valid_placement = false
      until valid_placement == true
        proposed_placement = random_placement(ship)
        if @board.valid_placement?(ship, proposed_placement)
          valid_placement =  true
          @board.place(ship, proposed_placement)
        end
      end
    end
  end

  def fire_shot(opponent)
    cells_not_fired_upon = opponent.verify_cells_not_fired_upon
    shot_coord = random_shot_selection(cells_not_fired_upon)
    puts "My shot on #{shot_coord} #{opponent.board.shot_inpact(shot_coord)}"
  end

  def random_shot_selection(cells_not_fired_upon)
    cells_not_fired_upon.sample
  end
end
