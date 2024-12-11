require "./guard.rb"
require "set"

class GuardSimulator
  C_GUARD_UP = "^"
  C_OBSTACLE = "#"

  attr_reader(:guard, :guard_positions)
  def initialize(map, guard = nil)
    @map = map
    @guard = guard
    @guard_positions = []
  end

  def look_for_obstruction
    
  end

  def locate_guard
    found_index = nil
    @map.each_with_index do |row, i|
      j = row.index(C_GUARD_UP)
      if j
        found_index = [i, j]
        break
      end
    end

    @guard = Guard.new(Coordinates.new(found_index.first, found_index.last), 0)
  end

  def has_guard_position?
    return true unless @guard.nil?

    false
  end

  def unique_positions
    uniq = Set.new
    @guard_positions.each { |pos| uniq.add(pos.position) }

    uniq
  end

  def loopholes
    new_g = @guard_positions.map do |guard|
      g = guard.dup
      g.turn
      g
    end

    intersect = Set.new
    new_g.each do |pos|
      tmp = @guard_positions.select do |g_pos|
        ((pos.direction == 0 or pos.direction == 2) && pos.direction == g_pos.direction && pos.position.y == g_pos.position.y) ||
          ((pos.direction == 1 or pos.direction == 3) && pos.direction == g_pos.direction && pos.position.x == g_pos.position.x)
      end
      tmp.each { |arr| intersect.add(arr) }
    end
      puts intersect.inspect

    intersect.size 
  end

  def max_width
    @map.first.length - 1
  end

  def max_height
    @map.length - 1 
  end

  def has_guard_left?
    position_out_of_bounds?(@guard.position)
  end

  def obstacle_in_front?
    next_position = @guard.next_position
    raise if position_out_of_bounds?(next_position)

    @map[next_position.x][next_position.y] == C_OBSTACLE
  end

  def start
    while !has_guard_left?
      if obstacle_in_front? 
        @guard.turn
      else 
        @guard_positions.push(@guard.dup)
        @guard.forward
      end
    end
  rescue Exception 
    @guard_positions.push(@guard)
    puts "Guard has left and visited #{unique_positions.size} distinct positions"
  end

  def position_out_of_bounds?(coord)
    coord.x > max_height || coord.x < 0 || coord.y > max_width || coord.y < 0
  end
end
