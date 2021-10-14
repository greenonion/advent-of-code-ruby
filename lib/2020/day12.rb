# frozen_string_literal: true

require 'set'
require 'pry'

class Day12
  attr_reader :input, :direction, :pos, :waypoint

  def initialize(input = nil)
    input ||= File.read('inputs/2020/day12')
    @input = input.split("\n")
    @direction = :e
    @pos = [0, 0]
    @waypoint = [10, 1]
  end

  def part1
    execute_instructions!
    pos.map(&:abs).sum
  end

  def part2
    execute_waypoint!
    pos.map(&:abs).sum
  end

  def execute_instructions!
    input.each { |instruction| step!(instruction) }
  end

  def execute_waypoint!
    input.each { |instruction| step_waypoint!(instruction) }
  end

  def step!(instruction)
    state = { direction: direction, pos: pos }
    next_step= step(state, instruction)
    @direction = next_step[:direction]
    @pos = next_step[:pos]
  end

  def step(state, instruction)
    value = instruction[1..-1].to_i
    case instruction[0]
    when 'F'
      towards(state, state[:direction], value)
    when 'N'
      towards(state, :n, value)
    when 'S'
      towards(state, :s, value)
    when 'E'
      towards(state, :e, value)
    when 'W'
      towards(state, :w, value)
    when 'R'
      turn(state, :r, value)
    when 'L'
      turn(state, :l, value)
    end
  end

  def step_waypoint!(instruction)
    state = { waypoint: waypoint, pos: pos }
    next_step = step_waypoint(state, instruction)
    @waypoint = next_step[:waypoint]
    @pos = next_step[:pos]
  end

  def step_waypoint(state, instruction)
    value = instruction[1..-1].to_i
    case instruction[0]
    when 'F'
      towards_waypoint(state, value)
    when 'N'
      move_waypoint(state, :n, value)
    when 'S'
      move_waypoint(state, :s, value)
    when 'E'
      move_waypoint(state, :e, value)
    when 'W'
      move_waypoint(state, :w, value)
    when 'R'
      rotate_waypoint(state, :r, value)
    when 'L'
      rotate_waypoint(state, :l, value)
    end
  end

  def towards(state, direction, value)
    {
      direction: state[:direction],
      pos: move(state[:pos], direction, value)
    }
  end

  def towards_waypoint(state, value)
    x, y = state[:pos]
    xw, yw = state[:waypoint]
    dx = xw * value
    dy = yw * value
    {
      pos: [x + dx, y + dy],
      waypoint: state[:waypoint]
    }
  end

  def move_waypoint(state, direction, value)
    {
      pos: state[:pos],
      waypoint: move(state[:waypoint], direction, value)
    }
  end

  def rotate_waypoint(state, turn_direction, value)
    waypoint = state[:waypoint]

    case turn_direction
    when :r
      (value / 90).times { waypoint = rotate_right(waypoint) }
    when :l
      (value / 90).times { waypoint = rotate_left(waypoint) }
    end

  {
      pos: state[:pos],
      waypoint: waypoint
    }
  end

  def rotate_right(pos)
    xw, yw = pos
    [yw, -1 * xw]
  end

  def rotate_left(pos)
    xw, yw = pos
    [-1 * yw, xw]
  end

  def turn(state, turn_direction, value)
    direction = state[:direction]

    case turn_direction
    when :r
      (value / 90).times { direction = heading_right(direction) }
    when :l
      (value / 90).times { direction = heading_left(direction) }
    end

    {
      direction: direction,
      pos: state[:pos]
    }
  end

  def move(pos, direction, value)
    x, y = pos
    dx, dy = movement(direction, value)
    [x + dx, y + dy]
  end

  def heading_right(direction)
    {
      e: :s,
      s: :w,
      w: :n,
      n: :e
    }[direction]
  end

  def heading_left(direction)
    {
      e: :n,
      s: :e,
      w: :s,
      n: :w
    }[direction]
  end

  def movement(direction, value)
    {
      e: [value, 0],
      n: [0, value],
      w: [-value, 0],
      s: [0, -value]
    }[direction]
  end
end
