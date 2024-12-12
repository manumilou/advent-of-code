class Coordinates
  attr_reader(:x, :y)
  def initialize(x, y)
    @x = x
    @y = y
  end

  def to_left
    Coordinates.new(@x - 1, @y)
  end

  def to_right
    Coordinates.new(@x + 1, @y)
  end

  def up
    Coordinates.new(@x, @y - 1)
  end

  def down
    Coordinates.new(@x, @y + 1)
  end

  def hash
    [x, y].hash
  end

  def eql?(other)
    self.class == other.class && @x == other.x && @y == other.y
  end

  def ==(other)
    return false unless Coordinates === other

    other.x == @x && other.y == @y
  end
end
