class Coordinates 
  attr_reader(:x, :y)
  def initialize(x, y)
    @x = x
    @y = y
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
