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

end
