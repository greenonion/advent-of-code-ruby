# frozen_string_literal: true
require 'pry'
class Day03
  attr_reader :report

  def initialize(input = nil)
    input ||= File.read('inputs/2021/day3')
    @report = input.split("\n").map { |s| s.split('') }
  end

  def part1
    gamma_rate(report) * epsilon_rate(report)
  end

  def part2
    oxygen_generator_rating(report) * co2_scrubber_rating(report)
  end

  def oxygen_generator_rating(report)
    candidates = report.dup
    i = 0

    while candidates.length > 1
      most_common_bits = most_common(candidates)
      candidates.select! { |c| c[i] == most_common_bits[i] }
      i += 1
    end

    candidates.first.join.to_i(2)
  end

  def co2_scrubber_rating(report)
    candidates = report
    i = 0

    while candidates.length > 1
      least_common_bits = least_common(candidates)
      candidates.select! { |c| c[i] == least_common_bits[i] }
      i += 1
    end

    candidates.first.join.to_i(2)
  end

  def gamma_rate(report)
    most_common(report).join.to_i(2)
  end

  def epsilon_rate(report)
    least_common(report).join.to_i(2)
  end

  def most_common(report)
    report.transpose.map do |position|
      zeros_length = position.count { |i| i == '0' }
      zeros_length > position.length / 2 ? '0' : '1'
    end
  end

  def least_common(report)
    report.transpose.map do |position|
      zeros_length = position.count { |i| i == '0' }
      zeros_length > position.length / 2 ? '1' : '0'
    end
  end
end
