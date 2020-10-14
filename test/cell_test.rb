require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

require 'pry'

class CellTest < Minitest::Test

  def test_cell_exists
    cell = Cell.new("B4")
    assert_instance_of Cell, cell
    assert_equal "B4", cell.coordinate
  end
end
