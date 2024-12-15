require "minitest/autorun"
require "./magic_stones.rb"

class TestMagicStones < Minitest::Test
  def test_one_blink
    magic_stones = MagicStones.new([0, 1, 10, 99, 999])
    assert_equal([1, 2024, 1, 0, 9, 9, 2021976], magic_stones.blink)
  end

  def test_blink_multiple
    magic_stones = MagicStones.new([125, 17])
    result = [2097446912, 14168, 4048, 2, 0, 2, 4, 40, 48, 2024, 40, 48, 80, 96, 2, 8, 6, 7, 6, 0, 3, 2]
    assert_equal(result, magic_stones.blink(6))
    assert_equal(22, result.size)

    magic_stones = MagicStones.new([125, 17])
    assert_equal(55312, magic_stones.blink(25).size)
  end

  def test_input
    magic_stones = MagicStones.new([773, 79858, 0, 71, 213357, 2937, 1, 3998391])
    assert_equal(199982, magic_stones.blink(75).size)
  end
end
