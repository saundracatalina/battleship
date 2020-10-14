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

  def test_can_cell_place_a_ship
    cruiser = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")
    assert_equal nil, cell.ship
    assert cell.empty?
    cell.place_ship(cruiser)
    assert_equal cruiser, cell.ship
    refute cell.empty?
  end

  def test_cell_can_be_fired_upon_if_has_ship
    cruiser = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")
    cell.place_ship(cruiser)
    refute cell.fired_upon?
    cell.fire_upon
    assert_equal 2, cell.ship.health
    assert cell.fired_upon?
  end

  def test_unfired_upon_empty_cell_can_render
    cell_1 = Cell.new("B4")
    assert_equal ".", cell_1.render
  end

  def test_fired_upon_empty_cell_can_render
    cell_1 = Cell.new("B4")
    cell_1.fire_upon
    assert_equal "M", cell_1.render
  end

  def test_cell_can_show_ship
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell_2.place_ship(cruiser)
    assert_equal ".", cell_2.render
    assert_equal "S", cell_2.render(true)
  end
end
