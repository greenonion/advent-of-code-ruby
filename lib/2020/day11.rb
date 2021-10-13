# frozen_string_literal: true

require 'set'
require 'pry'

class Day11
  attr_reader :input

  def initialize(input = nil)
    input ||= File.read('inputs/2020/day11')
    @input = input.split("\n").map(&:chars)
    @neighbors = {}
  end

  def part1
    stabilize!
    occupied
  end

  def part2
    stabilize_visible!
    occupied
  end

  def stabilize!
    i = 0

    i += 1 while tick!

    i
  end

  def stabilize_visible!
    i = 0

    i += 1 while tick_visible!

    i
  end

  def tick!
    result = tick
    change = result[:change]
    @input = result[:next_frame]
    change
  end

  def tick_visible!
    result = tick_visible
    change = result[:change]
    @input = result[:next_frame]
    change
  end

  def tick
    next_frame = Array.new(height) { Array.new(width) }
    change = false

    (0...height).each do |x|
      (0...width).each do |y|
        next_frame[x][y] =
          if empty?([x, y]) && occupied_neighbors([x, y]).zero?
            change = true
            '#'
          elsif occupied?([x, y]) && occupied_neighbors([x, y]) > 3
            change = true
            'L'
          else
            elem([x, y])
          end
      end
    end

    { next_frame: next_frame, change: change }
  end

  def tick_visible
    next_frame = Array.new(height) { Array.new(width) }
    change = false

    (0...height).each do |x|
      (0...width).each do |y|
        next_frame[x][y] =
          if empty?([x, y]) && visible_occupied([x, y]).zero?
            change = true
            '#'
          elsif occupied?([x, y]) && visible_occupied([x, y]) > 4
            change = true
            'L'
          else
            elem([x, y])
          end
      end
    end

    { next_frame: next_frame, change: change }
  end

  def occupied
    input.flatten.count { |n| n == '#' }
  end

  def neighbors(square)
    @neighbors[square] ||= neighbors!(square)
  end

  def occupied_neighbors(square)
    neighbors(square).count { |n| occupied?(n) }
  end

  def empty?(square)
    elem(square) == 'L'
  end

  def occupied?(square)
    elem(square) == '#'
  end

  def seat?(square)
    empty?(square) || occupied?(square)
  end

  def elem(square)
    x, y = square
    input[x][y]
  end

  def neighbors!(square)
    x, y = square
    (x - 1..x + 1).flat_map do |i|
      (y - 1..y + 1).filter_map do |j|
        next if i == x && y == j
        next if i.negative? || i >= height
        next if j.negative? || j >= width

        [i, j]
      end
    end
  end

  def width
    input[0].length
  end

  def height
    input.length
  end

  def visible_occupied(pos)
    [:n, :ne, :e, :se, :s, :sw, :w, :nw].map do |direction|
      seat_towards(pos, direction) { |seat| occupied?(seat) } ? 1 : 0
    end.sum
  end

  def seat_towards(pos, direction)
    x, y = pos
    dx, dy = movement(direction)
    x += dx
    y += dy

    while x < height && x >= 0 && y < width && y >= 0
      if seat?([x, y])
        return yield [x, y] if block_given?
        return [x, y]
      end

      x += dx
      y += dy
    end
  end

  def movement(direction)
    {
      n: [-1, 0],
      ne: [-1, 1],
      e: [0, 1],
      se: [1, 1],
      s: [1, 0],
      sw: [1, -1],
      w: [0, -1],
      nw: [-1, -1]
    }[direction]
  end
end
