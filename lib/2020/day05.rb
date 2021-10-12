class Day05
  attr_reader :input

  def initialize(input = nil)
    input ||= File.read('inputs/2020/day5')
    @input = input
  end

  def part1
    input.split.map { |i| seat_id(i) }.max
  end

  def part2
    seat_ids = input.split.map { |i| seat_id(i) }
    missing_seat_id(seat_ids)
  end

  def missing_seat_id(seat_ids)
    i = 0
    j = 1
    sorted_seats = seat_ids.sort

    while j < sorted_seats.length
      return sorted_seats[i] + 1 if sorted_seats[j] - sorted_seats[i] == 2
      i += 1
      j += 1
    end
  end

  def seat_id(identifier)
    row(identifier[0...7]) * 8 + column(identifier[-3..-1])
  end

  def row(identifier)
    min = 0
    max = 128

    identifier.chars.each do |i|
      distance = max - min
      if i == 'F'
        max -= distance / 2
      elsif i == 'B'
        min += distance / 2
      end
    end

    min
  end

  def column(identifier)
    min = 0
    max = 8

    identifier.chars.each do |i|
      distance = max - min
      if i == 'L'
        max -= distance / 2
      elsif i == 'R'
        min += distance / 2
      end
    end

    min
  end
end
