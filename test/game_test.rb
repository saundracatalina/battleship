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
    # require "pry"; binding.pry
  end
end
