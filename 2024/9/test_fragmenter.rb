require 'minitest/autorun'
require './fragmenter.rb'

class TestFragmenter < Minitest::Test
  def test_analyze_disk_map
    disk_map = File.readlines("./disk_map_small.txt").map do |line|
      line.chomp.chars
    end.flatten

    fragmenter = Fragmenter.new(disk_map)
    blocks = fragmenter.analyze_disk

    expected_blocks = "0..111....22222"
    assert_equal(expected_blocks, fragmenter.condensed_format(blocks))

    disk_map = File.readlines("./disk_map_medium.txt").map do |line|
      line.chomp.chars
    end.flatten

    fragmenter = Fragmenter.new(disk_map)
    blocks = fragmenter.analyze_disk

    expected_blocks = "00...111...2...333.44.5555.6666.777.888899"
    assert_equal(expected_blocks, fragmenter.condensed_format(blocks))
  end

  def test_move_file_blocks
    disk_map = File.readlines("./disk_map_small.txt").map do |line|
      line.chomp.chars
    end.flatten

    fragmenter = Fragmenter.new(disk_map)
    blocks = fragmenter.analyze_disk

    assert_equal("022111222......", fragmenter.condensed_format(fragmenter.move_file_blocks(blocks)))
  end

  def test_filesystem_checksum
    disk_map = File.readlines("./disk_map_large.txt").map do |line|
      line.chomp.chars
    end.flatten

    fragmenter = Fragmenter.new(disk_map)
    blocks = fragmenter.analyze_disk
    blocks = fragmenter.move_file_blocks(blocks)
    
    assert_equal(1928, fragmenter.filesystem_checksum(blocks))
  end
end
