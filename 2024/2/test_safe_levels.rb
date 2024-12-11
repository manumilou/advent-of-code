require 'minitest/autorun'
require './safe_levels.rb'

class TestSafeLevels < Minitest::Test
  def test_simple_ascending_order_level
    level = [1, 3, 6, 7, 9]
    assert_predicate(Report.new(level), :safe?)
  end

  def test_ascending_order_level_with_removal
    level = [1, 3, 6, 4, 7, 9]
    report = Report.new(level)
    refute_predicate(report, :safe?)
    
    report.remove_faulty_level
    assert_predicate(report, :safe?)
  end

  def test_simple_descending_order_level
    level = [7, 6, 4, 2, 1]
    assert_predicate(Report.new(level), :safe?)
  end

  def test_descending_order_level_with_removal
    level = [7, 6, 4, 5, 2, 1]
    report = Report.new(level)
    refute_predicate(report, :safe?)

    report.remove_faulty_level
    assert_predicate(report, :safe?)
  end

  def test_diff_too_high
    level = [1, 2, 7, 8, 9]
    report = Report.new(level)
    refute_predicate(report, :safe?)

    report.remove_faulty_level
    refute_predicate(report, :safe?)
  end

  def test_diff_too_low
    level = [1, 4, 7, 7, 9]
    report = Report.new(level)
    refute_predicate(report, :safe?)

    report.remove_faulty_level
    assert_predicate(report, :safe?)
  end

  def test_diff_too_high_at_the_beginning
    level = [88, 81, 78, 75, 74, 71]
    report = Report.new(level)
    refute_predicate(report, :safe?)

    report.remove_faulty_level
    assert_predicate(report, :safe?)
  end
end
