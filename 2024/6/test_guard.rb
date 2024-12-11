require 'minitest/autorun'
require './guard.rb'

class TestGuard < Minitest::Test
  def setup
    @guard = Guard.new(Coordinates.new(12, 12))
  end

  def test_guard_starts_at_initial_position
    assert_equal(12, @guard.position.x)
    assert_equal(12, @guard.position.y)
    assert_equal(0, @guard.direction)
  end

  def test_forward_when_up
    new_coord = Coordinates.new(11, 12)
    @guard.forward
    assert_equal(new_coord, @guard.position)
  end

  def test_forward_when_right
    @guard = Guard.new(Coordinates.new(12, 12), 1)
    new_coord = Coordinates.new(12, 13)
    @guard.forward
    assert_equal(new_coord, @guard.position)
  end

  def test_forward_when_down
    @guard = Guard.new(Coordinates.new(12, 12), 2)
    new_coord = Coordinates.new(13, 12)
    @guard.forward
    assert_equal(new_coord, @guard.position)
  end

  def test_forward_when_left
    @guard = Guard.new(Coordinates.new(12, 12), 3)
    new_coord = Coordinates.new(12, 11)
    @guard.forward
    assert_equal(new_coord, @guard.position)
  end

  def test_turn_when_up
    @guard.turn
    assert_equal(1, @guard.direction)
  end

  def test_turn_when_right
    @guard = Guard.new(Coordinates.new(12, 12), 1)
    @guard.turn
    assert_equal(2, @guard.direction)
  end
  
  def test_turn_when_down
    @guard = Guard.new(Coordinates.new(12, 12), 2)
    @guard.turn
    assert_equal(3, @guard.direction)
  end

  def test_turn_when_left
    @guard = Guard.new(Coordinates.new(12, 12), 3)
    @guard.turn
    assert_equal(0, @guard.direction)
  end

  def test_same_guard_are_equal
    guard_1 = Guard.new(Coordinates.new(12, 12), 3)
    guard_2 = Guard.new(Coordinates.new(12, 12), 3)
    
    assert_equal(guard_1, guard_2)
  end
end
