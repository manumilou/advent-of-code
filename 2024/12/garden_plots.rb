require '../lib/coordinates'

class GardenPlots
  class GardenPlot
    attr_reader(:perimeter, :position, :plant, :marked)
    attr_writer(:marked, :perimeter)
    def initialize(coord, plant, perimeter, marked: false)
      @position = coord
      @plant = plant
      @perimeter = perimeter
      @marked = marked
    end
  end

  def initialize(map)
    @garden = map
    @garden_plots = []
  end

  def analyze
    @garden_plots = @garden.map.with_index do |row, i|
      row.map.with_index do |c, j|
        coord = Coordinates.new(i, j)
        GardenPlot.new(coord, c, 0)
      end
    end
  end


  def valid?(position)
    return false if position.x < 0 or position.x > @garden.length - 1
    return false if position.y < 0 or position.y > @garden.first.length - 1

    true
  end

  def has_different_neighbour?(plant, neighbour)
    return true unless neighbour
    return true unless valid?(neighbour)

    plant != @garden[neighbour.x][neighbour.y]
  end

  def calculate_perimeter(plant, position)
    [position.to_left, position.to_right, position.up, position.down]
      .select { |pos| has_different_neighbour?(plant, pos) }
      .length
  end

  def search_for_neighbours
    plots_by_region = []
    @garden_plots.each_with_index do |row, i|
      row.each_with_index do |plot, j|
        next if plot.marked

        plot.marked = true
        plot.perimeter = calculate_perimeter(plot.plant, plot.position)
        current_neighbours = [plot]

        plots_by_region << current_neighbours.concat(find_adjacents(plot.plant, plot))
      end
    end
    plots_by_region
  end

  def find_adjacents(plant, garden_plot)
    neighbours = []
    current_pos = garden_plot.position

    [current_pos.to_left, current_pos.to_right, current_pos.up, current_pos.down].each do |new_pos|
      next if has_different_neighbour?(plant, new_pos)

      new_plot = @garden_plots[new_pos.x][new_pos.y]
      next if new_plot.marked

      new_plot.marked = true
      new_plot.perimeter = calculate_perimeter(new_plot.plant, new_plot.position)
      neighbours << new_plot

      puts "Add #{new_plot.inspect} to #{garden_plot.plant}"
      neighbours.concat(find_adjacents(plant, new_plot))
    end

    neighbours
  end

  def fences_price
    total_price = 0
    search_for_neighbours.each do |region|
      puts "region plant=#{region.map(&:plant)}"
      puts "region area=#{region.size}"
      puts "perimeter=#{region.map(&:perimeter).sum.inspect}"
      total_price += region.map(&:perimeter).sum * region.size
    end

    total_price
  end
end
