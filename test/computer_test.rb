require "minitest/autorun"
require "minitest/pride"
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/computer'

class ComputerTest < Minitest::Test
  def test_it_exists_and_has_attributes
    computer = Computer.new
    assert_instance_of Computer, computer
    computer.ships.each do |ship|
      assert Ship, ship.class
    end
    assert Board, computer.board.class
  end

  def computer_can_make_ships
    computer = Computer.new
    computer.ships.each do |ship|
      assert Ship, ship.class
    end
    assert_equal "Submarine", ships[1].name
    assert_equal "Cruiser", ships[0].name
  end

  def test_computer_can_generate_possible_horizontal_ship_placement
    computer = Computer.new
    ship1 = Ship.new("Cruiser", 3)

    expected = [["A1", "A2", "A3"], ["B1", "B2", "B3"], ["C1", "C2", "C3"],
    ["D1", "D2", "D3"], ["A2", "A3", "A4"], ["B2", "B3", "B4"],
    ["C2", "C3", "C4"], ["D2", "D3", "D4"]]
    assert_equal expected, computer.generate_ship_coordinate_placement_horizontal(ship1)

    ship2 = Ship.new("Submarine",2)
    expected = [["A1", "A2"], ["B1", "B2"], ["C1", "C2"], ["D1", "D2"],
    ["A2", "A3"], ["B2", "B3"], ["C2", "C3"], ["D2", "D3"], ["A3", "A4"],
    ["B3", "B4"], ["C3", "C4"], ["D3", "D4"]]
    assert_equal expected, computer.generate_ship_coordinate_placement_horizontal(ship2)
  end

  def test_computer_can_generate_possible_vertical_ship_placement
    computer = Computer.new
    ship1 = Ship.new("Cruiser", 3)

    expected = [["A1", "B1", "C1"], ["A2", "B2", "C2"], ["A3", "B3", "C3"],
    ["A4", "B4", "C4"], ["B1", "C1", "D1"], ["B2", "C2", "D2"],
    ["B3", "C3", "D3"], ["B4", "C4", "D4"]]
    assert_equal expected, computer.generate_ship_coordinate_placement_vertical(ship1)
    ship2 = Ship.new("Submarine",2)

    expected = [["A1", "B1"], ["A2", "B2"], ["A3", "B3"], ["A4", "B4"],
    ["B1", "C1"], ["B2", "C2"], ["B3", "C3"], ["B4", "C4"], ["C1", "D1"],
    ["C2", "D2"], ["C3", "D3"], ["C4", "D4"]]
    assert_equal expected, computer.generate_ship_coordinate_placement_vertical(ship2)
  end

  def test_computer_can_generate_possible_and_horizontal_vertical_ship_placement
    computer = Computer.new
    ship1 = Ship.new("Cruiser", 3)

    expected = [["A1", "A2", "A3"], ["B1", "B2", "B3"], ["C1", "C2", "C3"],
    ["D1", "D2", "D3"], ["A2", "A3", "A4"], ["B2", "B3", "B4"],
    ["C2", "C3", "C4"], ["D2", "D3", "D4"], ["A1", "B1", "C1"],
    ["A2", "B2", "C2"], ["A3", "B3", "C3"], ["A4", "B4", "C4"],
    ["B1", "C1", "D1"], ["B2", "C2", "D2"], ["B3", "C3", "D3"],
    ["B4", "C4", "D4"]]
    assert_equal expected , computer.horizontal_and_vertical_placements(ship1)
  end

  def test_computer_can_generate_random_ship_placement
    computer = Computer.new
    ship1 = Ship.new("Cruiser", 3)

    expected = [["A1", "A2", "A3"], ["B1", "B2", "B3"], ["C1", "C2", "C3"],
    ["D1", "D2", "D3"], ["A2", "A3", "A4"], ["B2", "B3", "B4"],
    ["C2", "C3", "C4"], ["D2", "D3", "D4"], ["A1", "B1", "C1"],
    ["A2", "B2", "C2"], ["A3", "B3", "C3"], ["A4", "B4", "C4"],
    ["B1", "C1", "D1"], ["B2", "C2", "D2"], ["B3", "C3", "D3"],
    ["B4", "C4", "D4"]]
    
    assert expected.include?(computer.random_placement(ship1))
  end

end
