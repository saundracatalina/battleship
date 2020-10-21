require './lib/cell'

class Board
  attr_reader :cells

  def initialize
    @cells = generate_cells
  end
# Start: Generate board
  def generate_cells
    hash = {}
    cell_coordinates.each do |cell_coord|
      hash[cell_coord] = Cell.new(cell_coord)
    end
    hash
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

  def columns
    (1..4).to_a
  end

  def rows
    ("A".."D").to_a
  end

  def valid_placement?(ship, placement_range)
    valid_length?(ship, placement_range) &&
    not_diagonal?(ship, placement_range) &&
    all_coordinates_valid?(ship, placement_range) &&
    cell_empty?(ship, placement_range)
  end

  def valid_length?(ship, placement_range)
    ship.length == placement_range.length
  end

  def all_coordinates_valid?(ship, placement_range)
    placement_range.all? do |coord|
      @cells.keys.include?(coord)
    end
  end
# to go in valid_placement?(ship, placement_range) ?
  def valid_coordinate?(coord)
    @cells.keys.include?(coord)
  end
# defines range array to compare original to.
  def user_range(set)
    (set.min..set.max).to_a
  end
# validates num's are consec
  def num_consec?(ship, placement_range)
    user_range(user_numbers(ship, placement_range)) == user_numbers(ship, placement_range)
  end
# pulls user num's from coordinates
  def user_numbers(ship, placement_range)
    placement_range.map do |coordinate|
      coordinate[1]
    end
  end
# validates letters are consec
  def letter_consec?(ship, placement_range)
    user_range(letters_to_num(ship, placement_range)) == letters_to_num(ship, placement_range)
  end
# letter.ord to num array
  def letters_to_num(ship, placement_range)
    user_letters(ship, placement_range).map do |letter|
      letter.ord
    end
  end
# pulls user letters from coordinates
  def user_letters(ship, placement_range)
    placement_range.map do |coordinate|
      coordinate[0]
    end
  end
# all num's are equal in user num array
  def identical_num(ship, placement_range)
    user_numbers(ship, placement_range).all?(user_numbers(ship, placement_range)[0])
  end
  # all letters are equal in user letter array
  def identical_letter(ship, placement_range)
    user_letters(ship, placement_range).all?(user_letters(ship, placement_range)[0])
  end

  def not_diagonal?(ship, placement_range)
    horizontal_placement(ship, placement_range) || vertical_placement(ship, placement_range)
  end

  def vertical_placement(ship, placement_range)
    identical_num(ship, placement_range) && letter_consec?(ship, placement_range)
  end

  def horizontal_placement(ship, placement_range)
    identical_letter(ship, placement_range) && num_consec?(ship, placement_range)
  end

  def place(ship, placement_range)
    placement_range.each do |coord|
      @cells[coord].place_ship(ship)
    end
  end

  def cell_empty?(ship, placement_range)
    placement_range.all? do |coord|
      @cells[coord].empty?
    end
  end

  def render(show_ship = false)
    "  1 2 3 4 \n" +
    "A #{@cells["A1"].render(show_ship)} #{@cells["A2"].render(show_ship)} #{@cells["A3"].render(show_ship)} #{@cells["A4"].render(show_ship)}\n" +
    "B #{@cells["B1"].render(show_ship)} #{@cells["B2"].render(show_ship)} #{@cells["B3"].render(show_ship)} #{@cells["B4"].render(show_ship)}\n" +
    "C #{@cells["C1"].render(show_ship)} #{@cells["C2"].render(show_ship)} #{@cells["C3"].render(show_ship)} #{@cells["C4"].render(show_ship)}\n" +
    "D #{@cells["D1"].render(show_ship)} #{@cells["D2"].render(show_ship)} #{@cells["D3"].render(show_ship)} #{@cells["D4"].render(show_ship)}\n"
  end

  def verify_cells_not_fired_upon
    untargeted = []
    @cells.each do |coord, cell_obj|
      untargeted << coord if cell_obj.fired_upon? == false
    end
    untargeted
  end

  def shot_impact(coord)
    @cells[coord].report
  end

  def already_shot?(coord)
    @cells[coord].fired_upon?
  end
end
