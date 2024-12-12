require 'minitest/autorun'
require './trailhead_finder.rb'

class TestTrailheadFinder < Minitest::Test
  def test_start_map_1
    map = load_file("map_1.txt")
    tf = TrailheadFinder.new(map)
    tf.start
    assert_equal(2, tf.score)
  end

  def test_start_map_2
    map = load_file("map_2.txt")
    tf = TrailheadFinder.new(map)
    tf.start
    assert_equal(4, tf.score)
    assert_equal(13, tf.rating)
  end

  def test_start_map_3
    map = load_file("map_3.txt")
    tf = TrailheadFinder.new(map)
    tf.start
    assert_equal(3, tf.score)
  end

  def test_start_map_4
    map = load_file("map_4.txt")
    tf = TrailheadFinder.new(map)
    tf.start
    assert_equal(36, tf.score)
    assert_equal(81, tf.rating)
  end

  def test_start_map_5
    map = load_file("map_5.txt")
    tf = TrailheadFinder.new(map)
    tf.start
    assert_equal(796, tf.score)
    assert_equal(1942, tf.rating)
  end

  private

  def load_file(name)
    File.readlines("./#{name}").map do |line|
      line.chomp.chars.map do |c|
        if c == "." then c
        else c.to_i
        end
      end
    end
  end

end
