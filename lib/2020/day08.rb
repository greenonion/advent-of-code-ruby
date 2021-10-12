# frozen_string_literal: true

require 'set'
require 'pry'

class Day08
  attr_reader :input
  attr_accessor :acc, :pc, :visited

  def initialize(input = nil)
    input ||= File.read('inputs/2020/day8')
    @input = input.split("\n")
    init!
  end

  def part1
    run_until_loop
    acc
  end

  def part2
    run_until_end
    acc
  end

  def run_until_end
    code = :ok
    alter = -1 # alter the ith command if applicable

    while code != :exited && alter < input.length
      init!
      alter += 1
      code = :ok
      code = execute(alter) while code == :ok
    end

    alter
  end

  def init!
    @acc = 0
    @pc = 0
    @visited = Set.new
  end

  def run_until_loop
    code = :ok

    code = execute while code == :ok
  end

  def alter(instruction)
    { 'nop' => 'jmp',
      'jmp' => 'nop',
      'acc' => 'acc' }[instruction]
  end

  # Execute the instruction of the pc or break if we've seen it again
  def execute(alter = nil)
    return :loop if visited.include?(pc)
    return :exited if pc == input.length

    visited.add(pc)
    instruction, value = input[pc].split
    instruction = alter(instruction) if pc == alter

    case instruction
    when 'nop'
      @pc += 1
    when 'acc'
      @acc += value.to_i
      @pc += 1
    when 'jmp'
      @pc += value.to_i
    end

    :ok
  end
end
