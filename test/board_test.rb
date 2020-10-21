require "minitest/autorun"
require "minitest/pride"
require './lib/ship'
require './lib/cell'
require './lib/board'

class BoardTest < Minitest::Test
  def test_it_exist
    board = Board.new
    assert_instance_of Board, board
  end

  def test_baord_has_attribute
    board = Board.new

    assert board.cell_coordinates.all? {|cell_coord| assert Cell == Cell.new(cell_coord).class}
    assert_equal 16, board.cells.keys.count
    assert_equal 16, board.cells.values.count
  end

  def test_board_make_column_coordinates
    board = Board.new
    assert_equal [1, 2, 3, 4], board.columns
  end

  def test_board_make_rows_coordinates
    board = Board.new
    assert_equal ["A", "B", "C", "D"], board.rows
  end

  def test_board_can_make_call_coordinates
    board = Board.new
    expected = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    assert_equal expected , board.cell_coordinates
  end

  def test_if_board_coordinates_are_valid
    board = Board.new
    assert board.valid_coordinate?("A1")
    assert board.valid_coordinate?("D4")
    refute board.valid_coordinate?("A5")
    refute board.valid_coordinate?("E1")
    refute board.valid_coordinate?("A22")
  end

  def test_valid_length
    board = Board.new
    placement_range = ["A1", "A2", "A3", "A4"]
    ship = Ship.new("Dragon Boat", 4)

    assert board.valid_length?(ship, placement_range)

    placement_range = ["A1", "A2", "A3"]
    ship = Ship.new("Dragon Boat", 4)

    refute board.valid_length?(ship, placement_range)
  end

  def test_all_coordinates_valid
    board = Board.new
    ship = ship
    placement_range = ["A1", "A2", "A3", "A4"]
    assert board.all_coordinates_valid?(ship, placement_range)

    placement_range = ["A1", "B2", "A3", "A7"]
    refute board.all_coordinates_valid?(ship, placement_range)
  end

  def test_valid_coordinate
    board = Board.new
    coord = "Z22"
    refute board.valid_coordinate?(coord)

    coord = "D1"
    assert board.valid_coordinate?(coord)
  end

  def test_user_range
    board = Board.new
    assert_equal [1, 2, 3], board.user_range([1, 3])
    assert_equal [1, 2], board.user_range([1, 1, 2])
  end

  def test_placement_coordinates_and_ship_length_equal
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    refute board.valid_placement?(cruiser, ["A1", "A2"])
    refute board.valid_placement?(submarine, ["A2", "A3", "A4"])
  end

  def test_placement_numbers_are_consec
    cruiser = Ship.new("Cruiser", 3)
    board = Board.new

    refute board.num_consec?(cruiser, ["A1", "A2", "A4"])
    refute board.num_consec?(cruiser, ["A3", "A2", "A1"])
  end

  def test_user_numbers
    board = Board.new
    ship = ship
    placement_range = ["A1", "A2", "A6"]

    assert_equal ["1", "2", "6"], board.user_numbers(ship, placement_range)
  end

  def test_placement_letters_are_consec
    submarine = Ship.new("Submarine", 2)
    board = Board.new

    refute board.letter_consec?(submarine, ["A1", "C1"])
    refute board.letter_consec?(submarine, ["C1", "B1"])
  end

  def test_letters_to_num
    board = Board.new
    placement_range = ["A", "B", "C"]
    ship = ship

    assert_equal [65, 66, 67], board.letters_to_num(ship, placement_range)
  end

  def test_user_letters
    board = Board.new
    placement_range = ["A4", "B4", "C4"]
    ship = ship

    assert_equal ["A", "B", "C"], board.user_letters(ship, placement_range)
  end

  def test_identical_num
    board = Board.new
    ship = ship
    placement_range = ["A4", "B4", "C4"]

    assert board.identical_num(ship, placement_range)
  end

  def test_identical_letter
    board = Board.new
    ship = ship
    placement_range = ["A1", "A2", "A3"]
    assert board.identical_letter(ship, placement_range)
  end

  def test_not_diagonal
    board = Board.new
    ship = ship
    placement_range = ["A1", "A2", "A3"]

    assert board.not_diagonal?(ship, placement_range)

    placement_range = ["A1", "B2", "C3"]
    refute board.not_diagonal?(ship, placement_range)
  end

  def test_vertical_placement
    board = Board.new
    ship = ship
    placement_range = ["A1", "B1", "C2"]
    assert_equal false, board.vertical_placement(ship, placement_range)

    placement_range = ["A1", "B1", "C1"]
    assert_equal true, board.vertical_placement(ship, placement_range)
  end

  def test_horizontal_placement
    board = Board.new
    ship = ship
    placement_range = ["A1", "A2", "C3"]

    assert_equal false, board.horizontal_placement(ship, placement_range)

    placement_range = ["A1", "A2", "A3"]
    assert_equal true, board.horizontal_placement(ship, placement_range)
  end

  def test_board_can_place_ships
    board = Board.new
    ship = Ship.new("Tri Ship", 3)
    placement_range = ["A1", "A2", "A3"]
    board.place(ship, placement_range)

    assert_equal ship ,board.cells["A1"].ship
    assert_equal ship ,board.cells["A2"].ship
    assert_equal ship ,board.cells["A3"].ship
  end

  def test_board_will_not_place_diagonal_placements
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board = Board.new
    refute board.identical_letter(submarine, ["C3", "D3"])
    refute board.not_diagonal?(cruiser, ["A1", "B2", "C3"])
    refute board.not_diagonal?(submarine, ["C2", "D3"])
  end

  def test_baord_can_validate_placements
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board = Board.new

    refute board.valid_placement?(cruiser, ["A1", "A2"])
    refute board.valid_placement?(submarine, ["A2", "A3", "A4"])
    refute board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    refute board.valid_placement?(submarine, ["A1", "C1"])
    refute board.valid_placement?(cruiser, ["A3", "A2", "A1"])
    refute board.valid_placement?(submarine, ["C1", "B1"])
    refute board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    refute board.valid_placement?(submarine, ["C2", "D3"])
    assert board.valid_placement?(submarine, ["A1", "A2"])
    assert board.valid_placement?(cruiser, ["B1", "C1", "D1"])
    refute board.valid_placement?(submarine, ["A2", "A5"])
    refute board.valid_placement?(submarine, ["Z2", "E2"])
    refute board.valid_placement?(cruiser, ["A3", "A4", "A5"])
    refute board.valid_placement?(cruiser, ["C2", "D2", "E2"])
    refute board.valid_placement?(cruiser, ["C2", "C2", "C3"])
  end

  def test_board_can_place_ship
    cruiser = Ship.new("Cruiser", 3)
    board = Board.new

    board.place(cruiser, ["A1", "A2", "A3"])
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]
    assert_equal cruiser, cell_1.ship
    assert_equal cruiser, cell_2.ship
    assert_equal cruiser, cell_3.ship
    assert cell_3.ship == cell_2.ship
  end

  def test_board_will_not_place_over_lapping_ships
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(submarine, ["A1", "B1"])
  end

  def test_cell_empty?
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    assert_equal true, board.cell_empty?(cruiser, ["A1", "A2", "A3"])
    board.place(cruiser, ["A1", "A2", "A3"])
    assert_equal false, board.cell_empty?(cruiser, ["A1", "A2", "A3"])
  end

  # def test_board_render
  #   board = Board.new
  #   cruiser = Ship.new("Cruiser", 3)
  #   board.place(cruiser, ["A1", "A2", "A3"])
  #
  #   expected = "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
  #   assert_equal expected, board.render
  # end

  def test_cells_not_fired_upon
    board = Board.new
    assert_equal 16, board.verify_cells_not_fired_upon.count
    board.cells["A1"].fire_upon
    assert_equal 15, board.verify_cells_not_fired_upon.count
  end

  def test_shot_impact
    board = Board.new
    coord = "A1"
    board.cells["A1"].fire_upon

    assert_equal "was a miss!", board.shot_impact(coord)
  end

  def test_already_shot
    board = Board.new
    coord = "A1"

    assert_equal false, board.already_shot?(coord)

    board.cells["A1"].fire_upon
    assert_equal true, board.already_shot?(coord)
  end
  
end
