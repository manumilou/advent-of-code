class Node
  attr_accessor :childs, :metadata
  attr_accessor :child_nodes, :metadata_entries

  def initialize(childs, metadata)
    @childs = childs
    @metadata = metadata
    @child_nodes = []
    @metadata_entries = []
  end
end


class LicenseNumber
  class << self
    def load_input
      input = []
      File.open('./input').each do |line|
        input <<  line.split(" ")
      end
      input.flatten
    end
  end

  def decypher(license)
    input_length = license.length
    counter = 0
    loop do
      node = Node.new(license[counter], license[counter + 1]) 
      counter += 2
      break if counter >= input_length
    end

    license.each do |data|
      Node.new(data)
    end
  end
end

license = LicenseNumber.load_input
LicenseNumber.new.decypher(license)

