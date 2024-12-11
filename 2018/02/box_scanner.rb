require 'damerau-levenshtein'

class BoxScanner

  def initialize
    @list_of_box_ids = load_box_ids
  end

  def box_full_of_prototype_fabric
    distances = {}
    @list_of_box_ids.each do |box_id|
      @list_of_box_ids.each do |compare_with|
        distance = DamerauLevenshtein.distance(box_id, compare_with)
        print box_id, compare_with if distance == 1
        exit if distance == 1
      end
    end
  end

  def compute_checksum
    exactly_two_of_any_letter = 0
    exactly_three_of_any_letter = 0
    
    parse_list_of_boxes.each do |box|
      if box.has_value?(2)
        exactly_two_of_any_letter += 1
      end
      if box.has_value?(3)
        exactly_three_of_any_letter += 1
      end
    end

    exactly_two_of_any_letter * exactly_three_of_any_letter
  end

  def parse_list_of_boxes
    array_of_boxes = []
    @list_of_box_ids.each do |box|
      current_boxes = {}
      box.split('').each do |char|
        break if char == "\n"

        if current_boxes.has_key?(char)
          current_boxes[char] += 1
        else
          current_boxes[char] = 1
        end
      end
      array_of_boxes.push(current_boxes)
    end
    array_of_boxes
  end

  private

  def load_box_ids
    box_ids = []
    File.open('./input').each do |line|
      box_ids.push(line) 
    end

    box_ids
  end
end
