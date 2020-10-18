require "minitest/autorun"
require "minitest/pride"
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/computer'

class UserTest < Minitest::Test

  def test_it_exists_and_has_attributes
    user = User.new
    assert_instance_of User, user

    user.ships.each do |ship|
      assert Ship, ship.class
    end

    assert Board, user.board.class
  end
end
