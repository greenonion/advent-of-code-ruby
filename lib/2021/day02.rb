# frozen_string_literal: true

class Day02
  attr_reader :commands, :position

  def initialize(input = nil)
    input ||= File.read('inputs/2021/day2')
    @commands = commands!(input)
    @position = { horizontal: 0, depth: 0, aim: 0 }
  end

  def part1
    follow_commands!
    position[:horizontal] * position[:depth]
  end

  def part2
    follow_commands_with_aim!
    position[:horizontal] * position[:depth]
  end

  def follow_commands!
    commands.each do |command|
      @position = updated_position(position, command)
    end
  end

  def follow_commands_with_aim!
    commands.each do |command|
      @position = updated_position_with_aim(position, command)
    end
  end

  def updated_position(position, command)
    direction, value = command
    horizontal = position[:horizontal]
    depth = position[:depth]

    case direction
    when 'forward'
      horizontal += value
    when 'down'
      depth += value
    when 'up'
      depth -= value
    end

    { horizontal: horizontal, depth: depth }
  end

  def updated_position_with_aim(position, command)
    direction, value = command
    horizontal = position[:horizontal]
    depth = position[:depth]
    aim = position[:aim]

    case direction
    when 'forward'
      horizontal += value
      depth += value * aim
    when 'down'
      aim += value
    when 'up'
      aim -= value
    end

    { horizontal: horizontal, depth: depth, aim: aim }
  end

  def commands!(input)
    input.split("\n").map do |command|
      direction, value = command.split(' ')
      [direction, value.to_i]
    end
  end
end
