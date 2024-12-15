require 'minitest/autorun'
require './garden_plots.rb'

class TestGardenPlots < Minitest::Test
  def test_garden_plots_4x4
    plots = load_file("garden_plots_4x4.txt")

    garden_plots = GardenPlots.new(plots)
    r = garden_plots.analyze
    assert_equal(140, garden_plots.fences_price)
  end

  def test_garden_plots_5x5
    plots = load_file("garden_plots_5x5.txt")

    garden_plots = GardenPlots.new(plots)
    r = garden_plots.analyze
    assert_equal(772, garden_plots.fences_price)
  end

  def test_garden_plots_140x140
    plots = load_file("garden_plots_140x140.txt")

    garden_plots = GardenPlots.new(plots)
    r = garden_plots.analyze
    assert_equal(1381056, garden_plots.fences_price)
  end

  private

  def load_file(name)
    File.readlines("./#{name}").map do |line|
      line.chomp.chars
    end
  end
end
