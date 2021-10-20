# frozen_string_literal: true

require 'pry'

class Day15
  attr_reader :turns, :last_seen, :turn_count

  def initialize(input = nil)
    input ||= File.read('inputs/2020/day15')
    @input = input
    starting_nums = input.split(',').map(&:to_i)

    @turn_count = starting_nums.length
    @turns = starting_nums.each_with_index.each_with_object({}) do |(num, idx), coll|
      coll[num] = idx + 1
    end

    @last_seen = 0
  end

  def part1
    twentytwentyth
  end

  def part2
    thirtymillth
  end

  def thirtymillth
    num = say! until @turn_count == 30_000_000
    num
  end

  def twentytwentyth
    num = say! until @turn_count == 2020
    num
  end

  def say!
    @turn_count += 1
    next_number = if last_seen.positive?
                    turn_count - 1 - last_seen
                  else
                    0
                  end

    @last_seen = @turns[next_number] || 0
    @turns[next_number] = turn_count

    next_number
  end
end
