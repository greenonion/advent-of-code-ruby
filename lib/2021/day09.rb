# frozen_string_literal: true

require 'pry'

class Day09
  attr_reader :grid

  def initialize(input = nil)
    input ||= File.read('inputs/2021/day9')
    @grid = input.split("\n").map { |line| line.split('').map(&:to_i) }
  end

  def part1
    risk_level_total
  end

  def part2
    basin_sizes.sort.last(3).reduce(:*)
  end

  def basin_sizes
    low_points.map do |point|
      basin_from(point).length
    end
  end

  def basin_from(location)
    # we need to do a bfs while we're not finding 9s
    basin = [location]
    queue = [location]
    until queue.empty?
      # visit location
      current = queue.shift
      next if height_at(current) == 9

      basin << current unless basin.include?(current)

      adjacent_to(current).each do |neighbor|
        queue << neighbor unless basin.include?(neighbor)
      end
    end

    basin
  end

  def risk_level_total
    low_points.sum { |low_point| risk_level_at(low_point) }
  end

  def low_points
    (0...@grid.length).each_with_object([]) do |row, coll|
      (0...@grid.first.length).each do |col|
        coll << [row, col] if low_point?([row, col])
      end
    end
  end

  def low_point?(location)
    adjacent_to(location).all? do |neighbor|
      height_at(location) < height_at(neighbor)
    end
  end

  def adjacent_to(location)
    row, col = location
    # generate all, filter out invalid
    [[row, col - 1], [row - 1, col], [row, col + 1], [row + 1, col]].select do |c_row, c_col|
      c_row > -1 && c_row < grid.length && c_col > -1 && c_col < grid.first.length
    end
  end

  def risk_level_at(location)
    height_at(location) + 1
  end

  def height_at(location)
    row, col = location
    @grid[row][col]
  end
end
