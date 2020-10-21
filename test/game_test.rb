require "minitest/autorun"
require "minitest/pride"
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/computer'
require './lib/user'
require './lib/game'

class GameTest < Minitest::Test

  def test_it_exists
    game = Game.new

    assert_instance_of Game, game
  end

# remove puts in method and add new line
# and + to run test
  def test_main_menu_message
    skip
    game = Game.new
    expected = "Welcome to BATTLESHIP\nEnter p to play. Enter q to quit."
    
    assert_equal expected, game.main_menu_message
  end
end
