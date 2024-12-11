require 'minitest/autorun'
require './multiply.rb'

class TestMultiply < Minitest::Test
  def test_parse_simple_string
    input = "some text mul(123,456) some more text"
    m = Multiply.new(input).parse
    assert_equal([["123", "456"]], m.numbers_to_multiply)
  end

  def test_parse_multiple_hit
    input = "some text mul(123,456) some more text mul(789,101)"
    m = Multiply.new(input).parse
    assert_equal([["123", "456"], ["789", "101"]], m.numbers_to_multiply)
  end

  def test_execute_single_pair
    input = "mul(3,4)"
    m = Multiply.new(input).parse
    assert_equal([["3", "4"]], m.numbers_to_multiply)
    assert_equal(12, m.execute)
  end

  def test_execute_multiple_pair
    input = "mul(526,20)why()*mul(288,311)@who(173,446)]"
    m = Multiply.new(input).parse
    assert_equal([["526", "20"], ["288", "311"]], m.numbers_to_multiply)
    assert_equal(100088, m.execute)
  end

  def test_execute_example
    input = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))" 
    m = Multiply.new(input).parse
    assert_equal(161, m.execute)
  end

  def test_execute_with_white_space
    input = "mul(4 , 6)"
    m = Multiply.new(input).parse
    assert_equal(0, m.execute)
  end

  def test_parse_with_dont_and_do
    input = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))" 
    m = Multiply.new(input).parse
    assert_equal([["2", "4"],["8", "5"]], m.numbers_to_multiply)
  end

  def test_run_problem_a
    input = File.read('./input.txt').strip
    m = Multiply.new(input).parse
    puts m.execute
  end
end
