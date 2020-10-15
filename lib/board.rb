require './lib/cell'

class Board

  def initialize
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


end
