# frozen_string_literal: true

require 'set'
require 'pry'

class Day10
  attr_reader :input

  def initialize(input = nil)
    input ||= File.read('inputs/2020/day10')
    @input = input.split("\n").map(&:to_i).sort.unshift(0)

    @ways_to_reach = { 0 => 1 }
  end

  def part1
    differences[1] * differences[3]
  end

  def part2
    arrangements
  end

  # This calls for standard dynamic programming methodologies.
  # - The number of ways to reach i from 0 is the number of ways to reach
  #   i-1 from 0 plus the number of ways to reach i from i-1
  def arrangements
    ways_to_reach(input.length - 1)
  end

  def ways_to_reach(i)
    @ways_to_reach[i] ||= ways_to_reach!(i)
  end

  def ways_to_reach!(i)
    prev1 = 0
    prev2 = 0
    prev3 = 0

    # There are at most three ways to reach a certain element in a single step
    prev1 = ways_to_reach(i - 1) if i - 1 >= 0 && input[i] - input[i - 1] < 4
    prev2 = ways_to_reach(i - 2) if i - 2 >= 0 && input[i] - input[i - 2] < 4
    prev3 = ways_to_reach(i - 3) if i - 3 >= 0 && input[i] - input[i - 3] < 4

    prev1 + prev2 + prev3
  end

  def differences
    @differences ||= differences!
  end

  def differences!
    input.unshift(0)
    input << input[-1] + 3

    diffs = {}
    i = 1
    while i < input.length
      diff = input[i] - input[i-1]
      if diffs[diff]
        diffs[diff] += 1
      else
        diffs[diff] = 1
      end

      i += 1
    end

    diffs
  end
end
