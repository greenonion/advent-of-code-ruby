# frozen_string_literal: true

require 'pry'

class Day11
  attr_reader :grid

  def initialize(input = nil)
    input ||= File.read('inputs/2021/day11')
    @grid = input.split("\n").map { |line| line.split('').map(&:to_i) }
  end

  def part1
    flashes_after(100)
  end

  def part2
    synced_after
  end

  def synced_after
    map = grid

    (1..1000).each do |step|
      result = step(map)
      map = result[:map]

      return step if result[:flashes] == grid.length * grid.first.length
    end

    1000
  end

  def flashes_after(steps)
    flashes = 0
    map = grid

    steps.times do
      result = step(map)
      map = result[:map]
      flashes += result[:flashes]
    end

    flashes
  end

  def step(map)
    increment_result = increment(map)
    incremented_map = increment_result[:map]
    will_flash = increment_result[:will_flash]

    have_flashed = []

    until will_flash.empty? do
      octopus = will_flash.shift
      flashed = flash(map, octopus)
      map = flashed[:map]
      flashed[:will_flash].each do |octopus|
        will_flash << octopus unless have_flashed.include?(octopus)
      end
      have_flashed << octopus
    end

    have_flashed.each do |(row, col)|
      map[row][col] = 0
    end

    { map: map, flashes: have_flashed.length }
  end

  private

  def flash(map, octopus)
    will_flash = []

    adjacent_to(octopus).each do |(row, col)|
      will_flash << [row, col] if map[row][col] == 9
      map[row][col] += 1
    end

    { map: map, will_flash: will_flash }
  end

  def increment(map)
    will_flash = []
    (0...map.length).each do |row|
      (0...map.first.length).each do |col|
        will_flash << [row, col] if map[row][col] == 9
        map[row][col] += 1
      end
    end

    { map: map, will_flash: will_flash }
  end

  def adjacent_to(location)
    # generate all, filter out invalid
    possibly_adjacent_to(location).select do |c_row, c_col|
      c_row > -1 && c_row < grid.length && c_col > -1 && c_col < grid.first.length
    end
  end

  def possibly_adjacent_to(location)
    row, col = location

    [[row, col - 1], [row - 1, col - 1], [row - 1, col], [row - 1, col + 1],
     [row, col + 1], [row + 1, col + 1], [row + 1, col], [row + 1, col - 1]]
  end
end
