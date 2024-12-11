require 'ruby-enum'
require '../lib/coordinates.rb'

class Guard
  attr_reader(:position, :direction)

  class Directions
    include(Ruby::Enum)

    define(:UP, 0)
    define(:RIGHT, 1)
    define(:DOWN, 2)
    define(:LEFT, 3)
  end

  def initialize(initial_position, direction = Directions.const_get(:UP))
    @direction = direction
    @position = Coordinates.new(initial_position.x, initial_position.y)
  end

  def forward
    @position = next_position
  end

  def change_position(new_position)
    @position = Coordinates.new(new_position.x, new_position.y)
  end

  def turn
    @direction = (@direction + 1)%4
  end

  def next_position
    case @direction
    when Directions.const_get(:UP)
      Coordinates.new(@position.x - 1, @position.y)
    when Directions.const_get(:RIGHT)
      Coordinates.new(@position.x, @position.y + 1)
    when Directions.const_get(:DOWN)
      Coordinates.new(@position.x + 1, @position.y)
    when Directions.const_get(:LEFT)
      Coordinates.new(@position.x, @position.y - 1)
    end
  end

  def ==(other)
    self.class == other.class && @direction == other.direction && @position == other.position
  end

  def hash
    [direction, position].hash
  end

  def eql?(other)
    self.class == other.class && @direction == other.direction && @position == other.position
  end
end
