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

  def test_can_make_column_coordiantes
    board = Board.new
    assert_equal [1, 2, 3, 4], board.columns
  end


end


# def test_coordinate_collection_has_4x4_coordinates
#   expected = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
#   assert_equal expected , board.cell_coordinates
# end
