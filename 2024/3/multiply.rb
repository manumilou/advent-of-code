class Multiply
  attr_reader(:numbers_to_multiply)
  def initialize(string)
    @input = string
    @numbers_to_multiply = []
  end

  def parse
    mul_enabled = true
    tokens = @input.scan(/mul\(\d+,\d+\)|do\(\)|don't\(\)/)
    tokens.each do |token|
      if token == "do()"   
        mul_enabled = true
      elsif token == "don't()"
        mul_enabled = false
      else
        if mul_enabled
          @numbers_to_multiply << token.scan(/mul\((\d+),\s*(\d+)\)/).first
        end
      end
    end
    
    self
  end

  def execute
    @numbers_to_multiply.map { |arr| arr.map(&:to_i).reduce(:*) }.sum
  end
end
