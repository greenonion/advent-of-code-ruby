# frozen_string_literal: true

class Day07
  attr_reader :positions

  def initialize(input = nil)
    input ||= File.read('inputs/2021/day7')
    @positions = input.rstrip.split(',').map(&:to_i)
  end

  def part1
    search.first
  end

  def part2
    crab_search.first
  end

  def crab_search
    # start from the minimum and go to the max
    ((positions.min)..(positions.max)).each_with_object({}) do |target, costs|
      costs[crab_fuel_to(target)] = target
    end.min
  end

  def search
    # start from the minimum and go to the max
    ((positions.min)..(positions.max)).each_with_object({}) do |target, costs|
      costs[fuel_to(target)] = target
    end.min
  end

  def fuel_to(target)
    positions.reduce(0) do |cost, position|
      cost + (target - position).abs
    end
  end

  def crab_fuel_to(target)
    positions.reduce(0) do |cost, position|
      cost + crab_fuel(position, target)
    end
  end

  def crab_fuel(from, to)
    steps = (from - to).abs
    steps * (steps + 1) / 2
  end
end
