class Fragmenter
  class BlockFree
    def to_s
      "."
    end
  end

  class BlockFile
    attr_reader(:id)
    def initialize(id)
      @id = id
    end

    def to_s
      @id.to_s
    end
  end

  def initialize(disk_map)
    @disk_map_dense_format = disk_map
    @disk_map = []
  end

  def analyze_disk
    arr = []
    @disk_map_dense_format.map.with_index do |data, index|
      if index.even?
        data.to_i.times do
          arr << BlockFile.new(index / 2)
        end
      else 
        data.to_i.times do
          arr << BlockFree.new
        end
      end
    end  
    arr
  end

  def condensed_format(disk_map)
    disk_map.map(&:to_s).join
  end

  def move_file_blocks(c_disk_map)
    # left_most_free_block = c_disk_map.find { |block| BlockFree === block }
    # last_block_file = c_disk_map.reverse.find { |block| BlockFile === block }

    # index_of_left_most_free_block = c_disk_map.index(left_most_free_block)
    # index_of_last_block_file = c_disk_map.index(last_block_file)
    
    # return c_disk_map if index_of_left_most_free_block > index_of_last_block_file
    
    # puts c_disk_map.index(left_most_free_block)
    # puts c_disk_map.index(last_block_file).inspect

    # c_disk_map[index_of_left_most_free_block] = last_block_file
    # c_disk_map[index_of_last_block_file] = left_most_free_block

    # move_file_blocks(c_disk_map)

    c_disk_map.each_with_index do |block, index|
      next unless BlockFree === block

      last_block_file = c_disk_map.reverse.find { |block| BlockFile === block }
      index_of_last_block_file = c_disk_map.index(last_block_file)
      next if index > index_of_last_block_file

      c_disk_map[index] = last_block_file
      c_disk_map[index_of_last_block_file] = block
    end

    c_disk_map
  end

  def filesystem_checksum(c_disk_map)
    checksum = 0

    c_disk_map.each_with_index do |block, index|
      next if BlockFree === block

      checksum += index * block.id
    end

    checksum
  end
end
