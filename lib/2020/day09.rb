# frozen_string_literal: true

require 'set'
require 'pry'

class Day09
  attr_reader :input, :preamble_size

  def initialize(input = nil, preamble_size = 25)
    input ||= File.read('inputs/2020/day9')
    @input = input.split("\n").map(&:to_i)
    @preamble_size = preamble_size
  end

  def part1
    first_invalid
  end

  def part2
    cr = contiguous_range(first_invalid)
    cr.min + cr.max
  end

  def contiguous_range(number)
    i = 0
    j = 0
    current_sum = 0

    while j < input.length
      next_sum = current_sum + input[j]
      return input[i..j] if next_sum == number

      if next_sum < number
        current_sum = next_sum
        j += 1
      else
        current_sum -= input[i]
        i += 1
      end
    end
  end

  def first_invalid
    i = preamble_size

    while i < input.length
      start = i - preamble_size

      return input[i] unless valid?(input[start...i], input[i])

      i += 1
    end
  end

  def valid?(preamble, number)
    preamble.combination(2).any? { |(a, b)| a + b == number }
  end
end
