require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test
  def test_it_exists_and_has_attributes
    cruiser = Ship.new("Cruiser", 3)
    assert_instance_of Ship, cruiser
    assert_equal "Cruiser", cruiser.name
    assert_equal 3, cruiser.length
  end

  def test_ship_has_health
    cruiser = Ship.new("Cruiser", 3)
    assert_equal 3, cruiser.health
    assert_equal true, cruiser.length == cruiser.health
  end

  def test_ship_can_sink
    cruiser = Ship.new("Cruiser", 3)
    refute cruiser.sunk?
    cruiser.hit
    assert_equal 2, cruiser.health
    cruiser.hit
    assert_equal 1, cruiser.health
    cruiser.hit
    assert cruiser.sunk?
  end
end
