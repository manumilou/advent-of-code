require 'benchmark'

class MagicStones
  def initialize(initial_state)
    @stones = initial_state
  end

  def blink(n = 1)
    arrangement = @stones
    n.times do |i|
      time = Benchmark.measure do
        arrangement = arrange(arrangement)
      end
      puts "Processed blink=#{i}/75 (size=#{arrangement.size}) in #{time.real} seconds"
    end

    arrangement
  end

  def arrange(arrangement)
    new_stones = []
    arrangement.each do |stone|
      if stone == 0
        new_stones << 1
      elsif stone.to_s.length.even?
        left, right = split_integer(stone)
        new_stones.push(left, right)
      else
        new_stones << stone * 2024
      end

    end

    new_stones
  end

  def split_integer(num)
    num_str = num.to_s
    mid = num_str.length / 2
    left_part = num_str[0...mid].to_i
    right_part = num_str[mid..-1].to_i
    [left_part, right_part]
  end
end
