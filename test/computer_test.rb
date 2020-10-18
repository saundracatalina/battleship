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

  
end
