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

  def test_baord_has_attribute
      board = Board.new

      board.cell_coordinates.each do |cell_coord|
        Cell == Cell.new(cell_coord).class
      end
      assert_equal 16, board.cells.keys.count
      assert_equal 16, board.cells.values.count
  end

  def test_if_board_coordinates_are_valid
    board = Board.new
    assert board.valid_coordinate?("A1")
    assert board.valid_coordinate?("D4")
    refute board.valid_coordinate?("A5")
    refute board.valid_coordinate?("E1")
    refute board.valid_coordinate?("A22")
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

  def test_placement_letters_are_consec
    submarine = Ship.new("Submarine", 2)
    board = Board.new

    refute board.letter_consec?(submarine, ["A1", "C1"])
    refute board.letter_consec?(submarine, ["C1", "B1"])
  end

  def test_board_will_not_place_diagonal_placements
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board = Board.new
    # refute board.identical_letter(submarine, ["C3", "D3"])
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
  end
end
