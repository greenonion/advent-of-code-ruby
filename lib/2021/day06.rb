# frozen_string_literal: true

class Day06
  attr_reader :population

  def initialize(input = nil)
    input ||= File.read('inputs/2021/day6')
    parse_input!(input)
  end

  def part1
    days!(80)
    total_fish
  end

  def part2
    days!(256)
    total_fish
  end

  def days!(number_of_days)
    number_of_days.times { day! }
  end

  def day!
    @population = next_day(population)
  end

  def total_fish
    population.values.sum
  end

  def next_day(population)
    population.each_with_object(Hash.new(0)) do |(k, v), coll|
      if k.positive?
        coll[k - 1] += v
      elsif k.zero?
        coll[6] += v
        coll[8] += v
      end
    end
  end

  private

  def parse_input!(input)
    @population = input.rstrip.split(',').each_with_object(Hash.new(0)) do |age, coll|
      coll[age.to_i] += 1
    end
  end
end
