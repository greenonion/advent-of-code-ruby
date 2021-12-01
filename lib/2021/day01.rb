# frozen_string_literal: true

require 'pry'

class Day01
  attr_reader :input

  def initialize(input = nil)
    input ||= File.read('inputs/2021/day1')
    @input = input.split("\n").map(&:to_i)
  end

  def part1
    times_increased(input)
  end

  def part2
    times_increased_sliding(input)
  end

  def times_increased(measurements)
    (0...measurements.size - 1).zip((1...measurements.size)).reduce(0) do |total, (i1, i2)|
      measurements[i2] > measurements[i1] ? total + 1 : total
    end
  end

  def times_increased_sliding(measurements)
    in_threes(0, measurements.size - 1).zip(in_threes(1, measurements.size)).reduce(0) do |total, (w1, w2)|
      window_total(measurements, w2) > window_total(measurements, w1) ? total + 1 : total
    end
  end

  def window_total(measurements, window)
    window.sum { |i| measurements[i] }
  end

  def in_threes(from, to)
    i = from
    j = from + 1
    k = from + 2

    Enumerator.new do |y|
      while k < to
        y << [i, j, k]
        i += 1
        j += 1
        k += 1
      end
    end
  end
end
