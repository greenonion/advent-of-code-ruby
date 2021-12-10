# frozen_string_literal: true

require 'pry'

class Day10
  attr_reader :subsystem

  def initialize(input = nil)
    input ||= File.read('inputs/2021/day10')
    @subsystem = input.split("\n")
  end

  def part1
    syntax_error_score
  end

  def part2
    autocomplete_score
  end

  def autocomplete_score
    incomplete_scores.sort[incomplete_scores.length / 2]
  end

  def incomplete_scores
    @subsystem.each_with_object([]) do |chunk, coll|
      missing = missing_chunk(chunk)
      coll << missing_score(missing) if missing
    end
  end

  def missing_score(missing)
    missing.chars.reduce(0) do |total, char|
      total * 5 + closing_score(char)
    end
  end

  def syntax_error_score
    @subsystem.reduce(0) do |total, chunk|
      illegal_char = first_illegal(chunk)
      illegal_char.nil? ? total : total + score(illegal_char)
    end
  end

  def legal?(chunk)
    first_illegal(chunk).nil?
  end

  def first_illegal(chunk)
    process(chunk)[:illegal]
  end

  def missing_chunk(chunk)
    process(chunk)[:missing]
  end

  def process(chunk)
    # while things are opening add them to the stack
    # while things are closing, pop them from the stack if matching
    stack = []
    chunk.chars.each do |char|
      if ['(', '[', '<', '{'].include?(char)
        stack << char
      elsif [')', ']', '>', '}'].include?(char)
        return { illegal: char } unless pair?(stack.pop, char)
      end
    end

    return { valid: true } if stack.empty?

    missing = stack.reverse.each_with_object([]) do |char, coll|
      coll << { '(' => ')', '[' => ']', '{' => '}', '<' => '>' }[char]
    end.join

    { missing: missing}
  end

  def incomplete_count
    subsystem.count { |chunk| !missing_chunk(chunk).nil? }
  end

  def corrupted_count
    subsystem.count { |chunk| !legal?(chunk) }
  end

  private

  def closing_score(character)
    {
      ')' => 1,
      ']' => 2,
      '}' => 3,
      '>' => 4
    }[character]
  end

  def score(character)
    {
      ')' => 3,
      ']' => 57,
      '}' => 1197,
      '>' => 25_137
    }[character]
  end

  def pair?(opening, closing)
    {
      '(' => ')',
      '[' => ']',
      '<' => '>',
      '{' => '}'
    }[opening] == closing
  end
end
