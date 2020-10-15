require './lib/cell'

class Board
  attr_reader :cells

  def initialize
    @cells = generate_cells
  end

  def generate_cells
    hash = {}
    cell_coordinates.each do |cell_coord|
      hash[cell_coord] = Cell.new(cell_coord)
    end
    hash
  end

  def columns
    (1..4).to_a
  end

  def rows
    ("A".."D").to_a
  end

  def cell_coordinates
    cell_coord = []
    rows.each do |row|
      columns.each do |column|
      cell_coord << "#{row}#{column.to_s}"
      end
    end
    cell_coord
  end

  def valid_coordinate?(coord)
    @cells.keys.include?(coord)
  end

  def valid_placement(ship, placement_range)
    #1. could then make a && with all helper methods. (2)
    helper_method1?
    helper_method2?
    helper_method3?
    helper_method4?
    #2.
    helper_method1? && helper_method2? && helper_method3? && helper_method4?
  end
  def helper_method1?
    conditionA
  end
  def helper_method2?
    conditionB
  end
  def helper_method3?
    conditionC
  end
  def helper_method4?
    conditionD
  end


end
