require 'minitest/autorun'
require './check_updates.rb'

class TestCheckUpdates < Minitest::Test
  def test_check_order_with_few_rules
    file_content = <<-DATA
47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13
    DATA
    ruleset = file_content.split("\n").map do |line| 
      rule = line.split('|').map(&:to_i)
      CheckUpdates::Rules.new(rule.first, rule.last)
    end

    updates = [
      [75,47,61,53,29],
      [97,61,53,29,13],
      [75,29,13],
      [75,97,47,61,53],
      [61,13,29],
      [97,13,75,29,47],
    ]

    # 97,13,75,29,47 becomes 97,75,47,29,13
    # <CheckUpdates::Rules:0x000000011081f5b8 @first=29, @second=13>
    # [97, 29, 75, 13, 47]
    # <CheckUpdates::Rules:0x000000011081ef78 @first=47, @second=13>
    # [97, 29, 75, 47, 13]
    # <CheckUpdates::Rules:0x000000011081ea50 @first=47, @second=29>
    # [97, 47, 75, 29, 13]
    
    service = CheckUpdates.new(ruleset, updates)
    assert_equal(3, service.run.size)
    assert_equal(143, service.middle_page_number)

    assert_equal(3, service.fix_incorrect_order.size)
    assert_equal(123, service.middle_page_number_incorrect)
  end

  def test_exercise
    # Path to your file
    file_path = 'rules.txt'
    delimiter = '|'
    ruleset = File.readlines(file_path).map do |line|
      rule = line.chomp.split(delimiter).map(&:to_i)
      CheckUpdates::Rules.new(rule.first, rule.last)
    end

    updates = File.readlines('./updates.txt').map { |line| line.chomp.split(',').map(&:to_i) }

    service = CheckUpdates.new(ruleset, updates)
    assert_equal(120, service.run.size)
    assert_equal(7307, service.middle_page_number)

    assert_equal(82, service.fix_incorrect_order.size)
    assert_equal(4713, service.middle_page_number_incorrect)
  end
end
