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

  def part2
    run_floating_program!
    @memory.values.sum
  end

  def run_floating_program!
    input.split("\n").each { |instruction| execute_floating!(instruction) }
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

  def execute_floating!(instruction)
    key, value = instruction.split(/\s*=\s*/, 2)
    case key
    when 'mask'
      @mask = value
    when /mem\[(\d+)\]/
      addr = Regexp.last_match(1).to_i
      masked_addr = memory_masked(addr, mask)
      unfloat_address(masked_addr).each { |addr| @memory[addr] = value.to_i }
    end
  end

  # Applies the current mask to the value and then writes it to memory
  def set(address, value)
    memory[address] = masked(value, mask)
  end

  def memory_masked(address, mask)
    mask_chars = mask.chars
    nth_bit = 1 << mask.length # ensure padding
    address_string = (address | nth_bit).to_s(2)[1..-1]
    address_string.chars.each_with_index.reduce([]) do |coll, (c, i)|
      coll << case mask_chars[i]
              when 'X'
                'X'
              when '0'
                c
              when '1'
                '1'
              end
    end.join
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

  def unfloat_address(address)
    base = address.tr('X', '0').to_i(2)
    floating = floating_bits(address)
    perms = 2**floating.length

    # Trick so we always have 0 padding!
    nth_bit = 1 << floating.length
    (0...perms).map do |perm|
      bitmap = (perm | nth_bit).to_s(2)[1..-1]
      num = base
      bitmap.chars.each_with_index do |c, i|
        next if c == '0'

        num += 2**floating[i]
      end
      num
    end
  end

  def floating_bits(address)
    address.chars.reverse.each_with_index.reduce([]) do |coll, (bit, idx)|
      bit == 'X' ? coll.append(idx) : coll
    end
  end
end
