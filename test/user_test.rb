require "minitest/autorun"
require "minitest/pride"
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/computer'
require './lib/user'

class UserTest < Minitest::Test

  def test_it_exists_and_has_attributes
    user = User.new
    assert_instance_of User, user

    user.ships.each do |ship|
      assert Ship, ship.class
    end

    assert Board, user.board.class
  end

  def test_user_can_make_ships
    user = User.new
    user.ships.each do |ship|
      assert Ship, ship.class
    end
    assert_equal "Submarine", user.ships[1].name
    assert_equal "Cruiser", user.ships[0].name
  end
end
