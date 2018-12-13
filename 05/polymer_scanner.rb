require 'byebug'

class PolymerScanner
  def initialize
    @sequence = load_polymer_sequence
    @sequence.pop

    @polymer_length = []
    ("a".."z").each do |letter|
      current_seq = @sequence.dup
      # Flush the letter
      current_seq.delete(letter)
      current_seq.delete(letter.upcase)

      @polymer_length << compute_sequence(current_seq)
    end

    print @polymer_length.minmax
  end

  def compute_sequence(sequence = nil)
    return if sequence.nil?

    length = sequence.length
    current_index = 0
    loop do
      pointer = sequence[current_index]
      next_pointer = sequence[current_index +1]
      
      if pointer != next_pointer && (pointer.upcase == next_pointer || pointer.downcase == next_pointer)
        sequence.delete_at(current_index)
        sequence.delete_at(current_index)
        length -= 2
        current_index -= 1
      else
        current_index += 1
      end

      break if current_index >= length
    end
    sequence.length
  end

  private

  def load_polymer_sequence
    sequence = []
    File.open('./input').each do |line|
      sequence = line.split("") 
    end

    sequence
  end
end
