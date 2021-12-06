# frozen_string_literal: true

class Day05
  attr_reader :lines, :points

  def initialize(input = nil)
    input ||= File.read('inputs/2021/day5')
    parse_input!(input)
    @points = Hash.new(0)
  end

  def part1
    horizontal_or_vertical_lines.each { |line| draw_line!(line) }
    points.values.count { |v| v > 1 }
  end

  def part2
    lines.each { |line| draw_line!(line) }
    points.values.count { |v| v > 1 }
  end

  def draw_line!(line)
    (fx, fy), (tx, ty) = line
    line_points = if fx == tx
                    vertical_points(line)
                  elsif fy == ty
                    horizontal_points(line)
                  else
                    diagonal_points(line)
                  end

    line_points.each { |point| @points[point] += 1 }
  end

  def horizontal_or_vertical_lines
    lines.select do |(fx, fy), (tx, ty)|
      fx == tx || fy == ty
    end
  end

  def horizontal_points(line)
    (fx, fy), (tx, ty) = line
    start, finish = fx > tx ? [tx, fx] : [fx, tx]

    Enumerator.new do |y|
      while start <= finish
        y << [start, fy]
        start += 1
      end
    end
  end

  def vertical_points(line)
    (fx, fy), (tx, ty) = line
    start, finish = fy > ty ? [ty, fy] : [fy, ty]

    Enumerator.new do |y|
      while start <= finish
        y << [fx, start]
        start += 1
      end
    end
  end

  def diagonal_points(line)
    (x1, y1), (x2, y2) = line
    dx = x1 > x2 ? -1 : 1
    dy = y1 > y2 ? -1 : 1

    Enumerator.new do |y|
      while x1 != x2 || y1 != y2
        y << [x1, y1]
        x1 += dx
        y1 += dy
      end
      y << [x1, y1]
    end
  end

  private

  def parse_input!(input)
    @lines = input.split("\n").map do |line|
      from, to = line.split(' -> ').map { |points| points.split(',').map(&:to_i) }
      [from, to]
    end
  end
end
