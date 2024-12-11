require 'minitest/autorun'
require './word_search.rb'

class TestWordSearch < Minitest::Test
  def test_coordinates_out_of_bounds
    input = [
      ['M', 'M', 'M', 'S', 'X', 'X', 'M', 'A', 'S', 'M'],
      ['M', 'S', 'A', 'M', 'X', 'M', 'S', 'M', 'S', 'A'],
      ['A', 'M', 'X', 'S', 'X', 'M', 'A', 'A', 'M', 'M'],
      ['M', 'S', 'A', 'M', 'A', 'S', 'M', 'S', 'M', 'X'],
    ]

    word_search = WordSearch.new(input, "XMAS")
    refute(word_search.coordinates_out_of_bounds?(WordSearch::Coordinate.new(0, 0)))
    refute(word_search.coordinates_out_of_bounds?(WordSearch::Coordinate.new(3, 0)))
    refute(word_search.coordinates_out_of_bounds?(WordSearch::Coordinate.new(0, 6)))

    assert(word_search.coordinates_out_of_bounds?(WordSearch::Coordinate.new(-1, 0)))
    assert(word_search.coordinates_out_of_bounds?(WordSearch::Coordinate.new(0, -1)))
    assert(word_search.coordinates_out_of_bounds?(WordSearch::Coordinate.new(4, 0)))
    assert(word_search.coordinates_out_of_bounds?(WordSearch::Coordinate.new(0, 10)))
  end

  def test_element_at
   input = [
      ['M', 'M', 'M', 'S', 'X', 'X', 'M', 'A', 'S', 'M'],
      ['M', 'S', 'A', 'M', 'X', 'M', 'S', 'M', 'S', 'A'],
      ['A', 'M', 'X', 'S', 'X', 'M', 'A', 'A', 'M', 'M'],
      ['M', 'S', 'A', 'M', 'A', 'S', 'M', 'S', 'M', 'X'],
    ]
    word_search = WordSearch.new(input, "XMAS")

    assert_equal("M", word_search.element_at(WordSearch::Coordinate.new(0,0)))
    assert_equal("S", word_search.element_at(WordSearch::Coordinate.new(0,3)))
    assert_equal("M", word_search.element_at(WordSearch::Coordinate.new(0,9)))
    assert_equal("A", word_search.element_at(WordSearch::Coordinate.new(2,0)))
    assert_equal("S", word_search.element_at(WordSearch::Coordinate.new(2,3)))
    assert_equal("L", word_search.element_at(WordSearch::Coordinate.new(4,3)))
  end

  def test_word_to_the_right
    input = [
      ['M', 'X', 'M', 'A', 'S', 'X', 'M', 'A', 'S', 'M'],
    ]
    word_search = WordSearch.new(input, "XMAS")
    assert_equal(2, word_search.run)
  end

  def test_word_to_the_left
    input = [
      ['M', 'X', 'S', 'A', 'M', 'X', 'M', 'A', 'S', 'M'],
    ]
    word_search = WordSearch.new(input, "XMAS")
    assert_equal(1, word_search.run)
  end

  def test_word_to_the_top
    input = [
      ['M', 'T', 'S', 'M', 'M', 'G', 'A', 'A', 'S', 'M'],
      ['M', 'B', 'S', 'A', 'M', 'M', 'M', 'A', 'S', 'M'],
      ['M', 'S', 'A', 'A', 'M', 'S', 'M', 'A', 'S', 'M'],
      ['M', 'M', 'M', 'A', 'M', 'Y', 'M', 'A', 'S', 'M'],
      ['M', 'F', 'X', 'A', 'M', 'A', 'M', 'A', 'S', 'M'],
      ['M', 'A', 'S', 'A', 'M', 'M', 'M', 'A', 'S', 'M'],
    ]
    word_search = WordSearch.new(input, "XMAS")
    assert_equal(1, word_search.run)
  end

  def test_word_to_the_bottom
    input = [
      ['M', 'T', 'S', 'M', 'M', 'G', 'X', 'A', 'S', 'M'],
      ['M', 'B', 'X', 'A', 'M', 'M', 'M', 'A', 'S', 'M'],
      ['M', 'S', 'M', 'A', 'M', 'S', 'A', 'A', 'S', 'X'],
      ['M', 'M', 'A', 'A', 'M', 'Y', 'S', 'A', 'S', 'M'],
      ['M', 'F', 'S', 'A', 'M', 'A', 'M', 'A', 'S', 'A'],
      ['M', 'A', 'S', 'A', 'M', 'M', 'M', 'A', 'S', 'S'],
    ]
    word_search = WordSearch.new(input, "XMAS")
    assert_equal(3, word_search.run)
  end

  def test_word_to_the_top_left
    input = [
      ['M', 'T', 'S', 'M', 'M', 'S', 'S', 'A', 'S', 'M'],
      ['M', 'X', 'T', 'A', 'M', 'M', 'A', 'A', 'S', 'M'],
      ['M', 'S', 'A', 'A', 'M', 'S', 'A', 'M', 'M', 'X'],
      ['M', 'M', 'A', 'M', 'M', 'Y', 'S', 'A', 'X', 'X'],
      ['M', 'F', 'S', 'A', 'X', 'A', 'M', 'A', 'S', 'A'],
      ['M', 'A', 'S', 'A', 'M', 'M', 'M', 'A', 'S', 'S'],
    ]
    word_search = WordSearch.new(input, "XMAS")
    assert_equal(3, word_search.run)
  end

  def test_word_to_the_top_right
    input = [
      ['M', 'T', 'S', 'M', 'M', 'S', 'S', 'A', 'S', 'M'],
      ['M', 'D', 'T', 'A', 'M', 'M', 'S', 'S', 'S', 'M'],
      ['M', 'S', 'A', 'S', 'M', 'A', 'A', 'M', 'M', 'X'],
      ['M', 'M', 'A', 'A', 'M', 'M', 'S', 'A', 'A', 'A'],
      ['M', 'M', 'S', 'X', 'X', 'A', 'M', 'A', 'S', 'A'],
      ['X', 'A', 'S', 'A', 'M', 'M', 'M', 'A', 'S', 'S'],
    ]
    word_search = WordSearch.new(input, "XMAS")
    assert_equal(3, word_search.run)
  end

  def test_word_search_small
    input = [
      ['M', 'M', 'M', 'S', 'X', 'X', 'M', 'A', 'S', 'M'],
      ['M', 'S', 'A', 'M', 'X', 'M', 'S', 'M', 'S', 'A'],
      ['A', 'M', 'X', 'S', 'X', 'M', 'A', 'A', 'M', 'M'],
      ['M', 'S', 'A', 'M', 'A', 'S', 'M', 'S', 'M', 'X'],
      ['X', 'M', 'A', 'S', 'A', 'M', 'X', 'A', 'M', 'M'],
      ['X', 'X', 'A', 'M', 'M', 'X', 'X', 'A', 'M', 'A'],
      ['S', 'M', 'S', 'M', 'S', 'A', 'S', 'X', 'S', 'S'],
      ['S', 'A', 'X', 'A', 'M', 'A', 'S', 'A', 'A', 'A'],
      ['M', 'A', 'M', 'M', 'M', 'X', 'M', 'M', 'M', 'M'],
      ['M', 'X', 'M', 'X', 'A', 'X', 'M', 'A', 'S', 'X'],
      ['M', 'M', 'M', 'S', 'X', 'X', 'M', 'A', 'S', 'M'],
      ['M', 'S', 'A', 'M', 'X', 'M', 'S', 'M', 'S', 'A'],
      ['A', 'M', 'X', 'S', 'X', 'M', 'A', 'A', 'M', 'M'],
      ['M', 'S', 'A', 'M', 'A', 'S', 'M', 'S', 'M', 'X'],
      ['X', 'M', 'A', 'S', 'A', 'M', 'X', 'A', 'M', 'M'],
      ['X', 'X', 'A', 'M', 'M', 'X', 'X', 'A', 'M', 'A'],
      ['S', 'M', 'S', 'M', 'S', 'A', 'S', 'X', 'S', 'S'],
      ['S', 'A', 'X', 'A', 'M', 'A', 'S', 'A', 'A', 'A'],
      ['M', 'A', 'M', 'M', 'M', 'X', 'M', 'M', 'M', 'M'],
      ['M', 'X', 'M', 'X', 'A', 'X', 'M', 'A', 'S', 'X'],
    ]

    word_search = WordSearch.new(input, 'XMAS')
    assert_equal(18, word_search.run)
  end

  def test_exercice
    input = File.readlines("./input.txt").map do |line|
      line.chomp.chars
    end

    word_search = WordSearch.new(input, 'A')
    assert_equal(18, word_search.run)
  end
end
