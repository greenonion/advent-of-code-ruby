# frozen_string_literal: true

require 'pry'

class Day14
  attr_reader :memory, :input
  attr_accessor :mask

  def initialize(input = nil)
    input ||= File.read('inputs/2020/day14')
    @input = input
    @memory = Hash.new(0)
    @mask = 'X' * 36
  end

  def part1
    run_program!
    @memory.values.sum
  end

  def run_program!
    input.split("\n").each { |instruction| execute!(instruction) }
  end

  def execute!(instruction)
    key, value = instruction.split(/\s*=\s*/, 2)
    case key
    when 'mask'
      @mask = value
    when /mem\[(\d+)\]/
      addr = Regexp.last_match(1).to_i
      set(addr, value.to_i)
    end
  end

  # Applies the current mask to the value and then writes it to memory
  def set(address, value)
    memory[address] = masked(value, mask)
  end

  def masked(value, mask)
    # setting means OR with 1s at the right places
    ones = 0
    mask.chars.reverse.each_with_index do |n, i|
      next unless n == '1'

      ones += 2**i
    end

    value |= ones

    # unsetting means AND with 1s everywhere and 0s at the right places
    zeros = 0
    mask.chars.reverse.each_with_index do |n, i|
      next if n == '0'

      zeros += 2**i
    end

    value & zeros
  end
end
