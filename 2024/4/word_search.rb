require 'ruby-enum'

class WordSearch
  class Directions
    include Ruby::Enum

    define :LEFT, :left
    define :RIGHT, :right
    define :TOP, :top
    define :BOTTOM, :bottom
    define :LEFT_TOP, :left_top
    define :LEFT_BOTTOM, :left_bottom
    define :RIGHT_TOP, :right_top
    define :RIGHT_BOTTOM, :right_bottom
  end

  Coordinate = Struct.new(:x, :y)

  def initialize(input, string)
    @grid = input
    @word = string
  end

  def run
    count = 0
    @grid.each_with_index do |row, coord_x|
      row.each_with_index do |element, coord_y|
        next unless element == @word[0]

        # count += search_for_word(Coordinate.new(coord_x, coord_y))
        count += search_for_xmas(Coordinate.new(coord_x, coord_y))
      end
    end
    count
  end

  def coordinates_out_of_bounds?(coordinates)
    return true if coordinates.x > @grid.length - 1
    return true if coordinates.y > @grid.first.length - 1
    return true if coordinates.x < 0
    return true if coordinates.y < 0

    false
  end

  def element_at(coordinates)
    return "L" if coordinates_out_of_bounds?(coordinates)

    @grid[coordinates.x][coordinates.y]
  end

  def search_for_word(position)
    count = 0

    word_to_the_right = element_at(position) +
      element_at(Coordinate.new(position.x, position.y + 1)) +
      element_at(Coordinate.new(position.x, position.y + 2)) +
      element_at(Coordinate.new(position.x, position.y + 3))
    count += 1 if word_to_the_right == @word

    word_to_the_left = element_at(position) +
      element_at(Coordinate.new(position.x, position.y - 1)) +
      element_at(Coordinate.new(position.x, position.y - 2)) +
      element_at(Coordinate.new(position.x, position.y - 3))
    count += 1 if word_to_the_left == @word

    word_to_the_top = element_at(position) +
      element_at(Coordinate.new(position.x - 1, position.y)) +
      element_at(Coordinate.new(position.x - 2, position.y)) +
      element_at(Coordinate.new(position.x - 3, position.y))
    count += 1 if word_to_the_top == @word

    word_to_the_bottom = element_at(position) +
      element_at(Coordinate.new(position.x + 1, position.y)) +
      element_at(Coordinate.new(position.x + 2, position.y)) +
      element_at(Coordinate.new(position.x + 3, position.y))
    count += 1 if word_to_the_bottom == @word

    word_to_the_right_top = element_at(position) +
      element_at(Coordinate.new(position.x + 1, position.y - 1)) +
      element_at(Coordinate.new(position.x + 2, position.y - 2)) +
      element_at(Coordinate.new(position.x + 3, position.y - 3))
    count += 1 if word_to_the_right_top == @word

    word_to_the_right_bottom = element_at(position) +
      element_at(Coordinate.new(position.x + 1, position.y + 1)) +
      element_at(Coordinate.new(position.x + 2, position.y + 2)) +
      element_at(Coordinate.new(position.x + 3, position.y + 3))
    count += 1 if word_to_the_right_bottom == @word

    word_to_the_left_top = element_at(position) +
      element_at(Coordinate.new(position.x - 1, position.y - 1)) +
      element_at(Coordinate.new(position.x - 2, position.y - 2)) +
      element_at(Coordinate.new(position.x - 3, position.y - 3))
    count += 1 if word_to_the_left_top == @word

    word_to_the_left_bottom = element_at(position) +
      element_at(Coordinate.new(position.x - 1, position.y + 1)) +
      element_at(Coordinate.new(position.x - 2, position.y + 2)) +
      element_at(Coordinate.new(position.x - 3, position.y + 3))
    count += 1 if word_to_the_left_bottom == @word

    count
  end

  def search_for_xmas(position)
    diag_1 = element_at(Coordinate.new(position.x + 1, position.y - 1)) +
      element_at(position) +
      element_at(Coordinate.new(position.x - 1, position.y + 1))
    return 0 unless diag_1 == "MAS" or diag_1 == "SAM"

    diag_2 = element_at(Coordinate.new(position.x - 1, position.y - 1)) +
      element_at(position) +
      element_at(Coordinate.new(position.x + 1, position.y + 1))
    return 0 unless diag_2 == "MAS" or diag_2 == "SAM"

    1
  end
end
