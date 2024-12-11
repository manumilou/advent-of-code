#file: time_fixer.rb

require 'set'

class TimeFixer
  class RepeatedFrequency < RuntimeError; end

  attr_reader :frequency

  def initialize
    @frequency = 0
    @list_of_changes = []
    
    load_list_of_changes
  end

  def compute_frequency
    unique_frequency = Set.new
    @list_of_changes.cycle do |current_change|
      change = current_change.clone
      op = change.slice!(0)
      if op == "-"
        @frequency -= change.to_i
      else
        @frequency += change.to_i
      end
        
      raise RepeatedFrequency, @frequency if unique_frequency.add?(@frequency).nil?
    end
  end

  private

  def load_list_of_changes
    File.open('./input').each do |line|
      @list_of_changes.push(line) 
    end
  end
end
