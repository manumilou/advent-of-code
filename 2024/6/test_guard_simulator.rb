require "minitest/autorun"
require "./guard_simulator.rb"

class TestGuardSimulator < Minitest::Test
  def setup
    @map = File.readlines("./map_small.txt").map do |line|
      line.chomp.chars
    end
    # @map is 10x10
    @sim = GuardSimulator.new(@map)
  end

  def test_locate_guard
    @sim.locate_guard
    assert(@sim.has_guard_position?)
    assert_equal(Coordinates.new(6, 4), @sim.guard.position)
    assert_equal(0, @sim.guard.direction)
  end

  def test_has_guard_left
    @sim.locate_guard
    refute(@sim.has_guard_left?)
    @sim.guard.change_position(Coordinates.new(-1, 0))
    assert(@sim.has_guard_left?)

    @sim.guard.change_position(Coordinates.new(0, -1))
    assert(@sim.has_guard_left?)

    @sim.guard.change_position(Coordinates.new(@sim.max_height + 1, 0))
    assert(@sim.has_guard_left?)

    @sim.guard.change_position(Coordinates.new(0, @sim.max_width + 1))
    assert(@sim.has_guard_left?)
  end

  def test_obstacle_in_front
    @sim.locate_guard
    @sim.guard.change_position(Coordinates.new(1, 4))
    assert(@sim.obstacle_in_front?)
  end

  def test_obstacle_to_the_right
    guard = Guard.new(Coordinates.new(1, 8), 1)
    @sim = GuardSimulator.new(@map, guard)
    assert(@sim.obstacle_in_front?)
  end

  def test_position_out_of_bounds
    coord = Coordinates.new(1, 8)
    @sim = GuardSimulator.new(@map)
    refute(@sim.position_out_of_bounds?(coord))
    assert(@sim.position_out_of_bounds?(Coordinates.new(10, 8)))
    assert(@sim.position_out_of_bounds?(Coordinates.new(8, 10)))
    assert(@sim.position_out_of_bounds?(Coordinates.new(-1, 8)))
    assert(@sim.position_out_of_bounds?(Coordinates.new(1, -8)))
  end

  def test_start_simulation
    @sim.locate_guard
    @sim.start

    assert_equal(41, @sim.unique_positions.size)
    assert_equal(6, @sim.loopholes)
  end

  def test_starts_simulation_large
    map = File.readlines("./map_large.txt").map do |line|
      line.chomp.chars
    end
    # @map is 130x130
    sim = GuardSimulator.new(map)
    sim.locate_guard
    sim.start

    assert_equal(4973, sim.unique_positions.size)
  end

end
