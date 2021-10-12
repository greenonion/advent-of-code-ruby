# frozen_string_literal: true

require 'set'

class Day06
  attr_reader :input

  def initialize(input = nil)
    input ||= File.read('inputs/2020/day6')
    @input = input
  end

  def part1
    input.split("\n\n").sum { |answers| group_yes(answers) }
  end

  def part2
    input.split("\n\n").sum { |answers| group_all_yes(answers) }
  end

  def group_yes(answers)
    answers.split("\n").map { |answer| person_yes(answer) }.reduce do |coll, s|
      coll | s
    end.length
  end

  def group_all_yes(answers)
    answers.split("\n").map { |answer| person_yes(answer) }.reduce do |coll, s|
      coll & s
    end.length
  end

  def person_yes(answer)
    Set.new(answer.chars)
  end
end
