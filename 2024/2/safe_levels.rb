class Report
  MAX_DIFF = 3
  MIN_DIFF = 1

  def initialize(levels)
    @levels = levels
  end

  def safe?
    ordered? && safe_diff?
  end

  private

  def ordered?
    descending_order? || ascending_order?
  end

  def descending_order?
    @levels.each_cons(2).all? { |a, b| a > b }
  end

  def ascending_order?
    @levels.each_cons(2).all? { |a, b| a < b }
  end

  def safe_diff?
    @levels.each_cons(2).all? do |a, b|
      (a - b).abs >= MIN_DIFF && (a - b).abs <= MAX_DIFF
    end
  end
end

all_reports = []
File.foreach('input.txt') do |line|
  all_reports << line.strip.split.map(&:to_i)
end

safe_levels = 0
all_reports.each do |level|
  if Report.new(level).safe?
    safe_levels += 1
  else
    # Try out every combinaison
    level.length.times.map { |i| level[0...i] + level[i+1..-1] }.any? do |c|
      Report.new(c).safe?
    end.then { |result| safe_levels += 1 if result }
  end
end

puts safe_levels
