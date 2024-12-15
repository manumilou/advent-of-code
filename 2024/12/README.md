# Algorithm

input = 2D Array

GardenPlots = [GardenPlot]
GardenPlot = one single array element
  - Plant (Letter)
  - Area = 1
  - Perimeter: number of edge not contiguous to the same type of plant (either another plant or exterior fence)
  - Price = Area * Perimeter

Calculate results by keying by the plant type (A, B, C) // Not necessary at the beginning
Then summing each garden plot's required price from the same type
