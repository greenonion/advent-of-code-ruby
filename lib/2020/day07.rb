# frozen_string_literal: true

require 'set'
require 'pry'

class Day07
  attr_reader :input

  def initialize(input = nil)
    input ||= File.read('inputs/2020/day7')
    @input = input
  end

  def part1
    carry('shiny gold')
  end

  def part2
    bags_nested('shiny gold')
  end

  def bags_nested(bag_type)
    internal = rules[bag_type]
    return 0 if internal.empty?

    internal.reduce(0) do |total, (bt, c)|
      total + c + c * bags_nested(bt)
    end
  end

  def carry(bag_type)
    result = Set.new([])

    candidates = [bag_type]

    until candidates.empty?
      candidate = candidates.shift
      cont = containers[candidate]
      next if cont.nil?

      result.merge(cont)
      candidates.concat(cont)
    end

    result.length
  end

  def containers
    @containers ||= rules.each_with_object({}) do |(k, v), coll|
      v.each_key do |key|
        if coll[key]
          coll[key] << k
        else
          coll[key] = [k]
        end
      end
    end
  end

  def rules
    @rules ||= input.split("\n").map { |r| rule_from_str(r) }.reduce(&:merge)
  end

  def rule_from_str(str_rule)
    container, contained = str_rule.split(' bags contain ')
    return { container => {} } if contained == 'no other bags.'

    contained_map = contained.split(', ').map do |c|
      parts = /^(\d+) (.+) bag/.match(c)

      { parts[2] => parts[1].to_i }
    end.reduce(&:merge)

    { container => contained_map }
  end
end
