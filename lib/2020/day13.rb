# frozen_string_literal: true
require 'pry'
class Day13
  attr_reader :schedules, :timestamp

  def initialize(input = nil)
    input ||= File.read('inputs/2020/day13')
    @input = input
    timestamp, schedules = input.split("\n")
    @timestamp = timestamp.to_i
    @schedules = schedules.split(',').map { |s| s == 'x' ? s : s.to_i }
  end

  def part1
    bus = best_bus(timestamp, schedules.reject { |c| c == 'x' })
    bus * minutes_after(timestamp, bus)
  end

  def part2
    earliest_timestamp(schedules)
  end

  def best_bus(timestamp, schedules)
    schedules.min_by { |schedule| minutes_after(timestamp, schedule) }
  end

  def minutes_after(timestamp, schedule)
    schedule - (timestamp % schedule)
  end

  # let's say we have schedules a, b, c
  # we want to find a number x that satisfies:
  # x mod a = 0
  # (x + 1) mod b = 0
  # (x + 2) mod c = 0
  def earliest_timestamp(buses)
    first_bus = buses[0]
    ts = first_bus

    last_good_idx = 0
    step = buses[last_good_idx]

    loop do
      best_idx = contiguous_until(ts, buses)
      break if best_idx == buses.length

      if best_idx > last_good_idx
        # In practice this is not needed because all numbers are primes but ok
        step *= lcm(buses[best_idx], buses[last_good_idx])
        step /= buses[last_good_idx]
        last_good_idx = best_idx
      end
      ts += step
    end

    ts
  end

  def contiguous_until(ts, buses)
    last_good = 0

    buses.each_with_index do |bus, index|
      next if bus == 'x'

      return last_good unless ((ts + index) % bus).zero?

      last_good = index
    end

    buses.length
  end

  def lcm(a, b)
    a * b / gcd(a, b)
  end

  def gcd(a, b)
    while b != 0
      t = b
      b = a % b
      a = t
    end
    a
  end
end
