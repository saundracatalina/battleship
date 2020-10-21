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

  def test_cell_with_ship_can_be_hit
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell_2.place_ship(cruiser)
    cell_2.fire_upon
    assert_equal "H", cell_2.render
    refute cruiser.sunk?
    cruiser.hit
    cruiser.hit
    assert cruiser.sunk?
    assert_equal "X", cell_2.render
  end

  def test_cell_empty?
    cell = Cell.new("A1")
    ship = Ship.new("Cruiser", 3)
    assert cell.empty?
    cell.place_ship(ship)
    assert_equal false, cell.empty?
  end

  def test_cell_can_place_ship
    cell = Cell.new("A1")
    ship = Ship.new("Titanic", 3)
    cell.place_ship(ship)
    assert_equal ship, cell.ship
  end

  def test_fired_upon?
    cell = Cell.new("A1")
    refute cell.fired_upon?
    cell.fire_upon
    assert cell.fired_upon?
  end

  def test_report_returns_reports
    cell1 = Cell.new("A1")
    ship1 = Ship.new("Tugboat", 1)
    cell1.place_ship(ship1)
    cell1.fire_upon
    assert_equal "X", cell1.render

    cell2 = Cell.new("A1")
    ship2 = Ship.new("Tugboat", 2)
    cell2.place_ship(ship2)
    cell2.fire_upon
    assert_equal "H", cell2.render
    cell3 = Cell.new("A1")
    cell3.fire_upon
    assert_equal "M", cell3.render
  end

end
