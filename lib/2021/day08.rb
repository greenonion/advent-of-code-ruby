# frozen_string_literal: true

require 'set'
require 'pry'

class Day08
  attr_reader :notes

  def initialize(input = nil)
    input ||= File.read('inputs/2021/day8')
    @notes = input.split("\n").map { |n| Note.new(n) }
  end

  def part1
    notes.reduce(0) { |total, note| total + note.unique_output_segment_count }
  end

  def part2
    notes.reduce(0) { |total, note| total + note.output_number }
  end
end

class Note
  attr_reader :input_segments, :output_segments, :positions

  def initialize(input)
    parse_input!(input)
    @positions = {
      t: Set.new(['a', 'b', 'c', 'd', 'e', 'f', 'g']),
      tl: Set.new(['a', 'b', 'c', 'd', 'e', 'f', 'g']),
      tr: Set.new(['a', 'b', 'c', 'd', 'e', 'f', 'g']),
      m: Set.new(['a', 'b', 'c', 'd', 'e', 'f', 'g']),
      bl: Set.new(['a', 'b', 'c', 'd', 'e', 'f', 'g']),
      br: Set.new(['a', 'b', 'c', 'd', 'e', 'f', 'g']),
      b: Set.new(['a', 'b', 'c', 'd', 'e', 'f', 'g'])
    }
  end

  def output_number
    solve!
    @output_segments.map do |segment|
      segment_to_number(segment)
    end.join.to_i
  end

  def segment_to_number(segment)
    case segment.length
    when 2
      '1'
    when 3
      '7'
    when 4
      '4'
    when 5
    # 2, 3, or 5?
      positions = Set.new(segment.split('').each_with_object([]) { |s, coll| coll << @positions[s] })
      if positions == Set.new([:t, :tr, :m, :bl, :b])
        '2'
      elsif positions == Set.new([:t, :tl, :m, :br, :b])
        '5'
      else
        '3'
      end
    when 6
      # 0, 6, or 9?
      positions = Set.new(segment.split('').each_with_object([]) { |s, coll| coll << @positions[s] })
      if !positions.include?(:m)
        '0'
      elsif !positions.include?(:tr)
        '6'
      else
        '9'
      end
    when 7
      '8'
    end
  end

  def solve!
    @input_segments.each { |segment| update_positions!(segment) }
    utilize_sixes!
    @positions = @positions.each_with_object({}) do |(k, v), coll|
      coll[v.first] = k
    end
  end

  def utilize_sixes!
    a, b, c = @input_segments.select { |s| s.length == 6 }
    # by substituting one from another we can find the only missing
    possible = (a - b) | (a - c) | (b - a)

    intersect_wire_mappings!([:tr, :m, :bl], possible)
    remove_wire_mappings!([:t, :tl, :br, :b], possible)
  end

  # two needs 5 segments
  # three needs 5 segments
  # five needs 5 segments
  # zero needs 6 segments
  # six needs 6 segments
  # nine needs 6 segments
  def update_positions!(segments)
    case segments.length
    when 2 # one
      intersect_wire_mappings!([:tr, :br], segments)
      remove_wire_mappings!([:t, :tl, :m, :bl, :b], segments)
    when 3 # seven
      intersect_wire_mappings!([:t, :tr, :br], segments)
      remove_wire_mappings!([:tl, :m, :bl, :b], segments)
    when 4 # four
      intersect_wire_mappings!([:tl, :tr, :m, :br], segments)
      remove_wire_mappings!([:t, :bl, :b], segments)
    end
  end

  def intersect_wire_mappings!(wires, segments)
    wires.each do |wire|
      @positions[wire] = @positions[wire] & segments
    end
  end

  def remove_wire_mappings!(wires, segments)
    wires.each do |wire|
      @positions[wire] = @positions[wire] - segments
    end
  end

  def unique_output_segment_count
    @output_segments.count { |seg| [2, 3, 4, 7].include?(seg.length) }
  end

  private

  def parse_input!(input)
    input, output = input.split(' | ')
    @input_segments = input.split(' ').map { |s| Set.new(s.split('')) }.sort_by(&:length) # so we apply most constraints first
    @output_segments = output.split(' ')
  end
end
