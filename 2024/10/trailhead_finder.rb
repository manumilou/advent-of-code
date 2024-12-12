require '../lib/coordinates.rb'
require 'set'

class TrailheadFinder
  class TrailHead
    attr_reader(:score, :summits, :coord)
    def initialize(coord)
      @score = 0
      @coord = coord
      @summits = []
    end
  end

  def initialize(map)
    @map = map
    @trailheads = []
  end

  def locate_trailheads
    @map.each_with_index do |row, i|
      row.each_with_index do |c, j|
        if c == 0
          @trailheads << TrailHead.new(Coordinates.new(i, j))
        end
      end
    end
    # puts @trailheads.inspect
  end

  def height(position)
    return unless position
    return if position.x > @map.size - 1 || position.x < 0

    @map[position.x][position.y]
  end

  def valid?(height, position)
    return false unless position
    return false if position.x < 0 or position.x > @map.length - 1
    return false if position.y < 0 or position.y > @map.first.length - 1

    height(position) == height + 1
  end

  def dead_end?(positions)
    positions.empty?
  end

  def find_next_positions(position)
    current_height = height(position)
    [position.to_left, position.to_right, position.up, position.down].select { |pos| valid?(current_height, pos) }
  end

  def follow_paths
    @trailheads.each do |trailhead|
      follow_path(trailhead.coord, trailhead)
    end
  end

  def follow_path(position, trailhead)
    if height(position) == 9
      trailhead.summits.push(position)
    end

    next_positions = find_next_positions(position)
    return false unless next_positions
    return false if dead_end?(next_positions)

    next_positions.each { |pos| follow_path(pos, trailhead) }
  end

  def score
    @trailheads.map(&:summits).map(&:to_set).map(&:size).sum
  end

  def rating
    @trailheads.map(&:summits).map(&:size).sum
  end

  def start
    locate_trailheads
    follow_paths
  end

end
