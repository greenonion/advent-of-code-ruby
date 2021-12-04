# frozen_string_literal: true

class Day04
  attr_reader :draws, :boards

  def initialize(input = nil)
    input ||= File.read('inputs/2021/day4')
    parse_input!(input)
  end

  def part1
    draws.each do |number|
      boards.each { |board| board.mark!(number) }
      winner = boards.find(&:bingo?)
      return winner.score * number if winner
    end
  end

  def part2
    candidates = boards.dup

    draws.each do |number|
      boards.each { |board| board.mark!(number) }
      return candidates.first.score * number if candidates.length == 1 && candidates.first.bingo?

      candidates.reject!(&:bingo?)
    end
  end

  private

  def parse_input!(input)
    rows = input.split("\n\n")
    parse_draws!(rows.first)
    parse_boards!(rows[1..])
  end

  def parse_draws!(input)
    @draws = input.split(',').map(&:to_i)
  end

  def parse_boards!(input)
    @boards = input.map { |b| Board.new(b) }
  end
end

class Board
  attr_reader :marks, :positions

  def initialize(input)
    @marks = Array.new(5) { Array.new(5, false) }
    numbers = input.split("\n").map { |row| row.split(' ').map(&:to_i) }
    @positions = numbers.each_with_index.each_with_object({}) do |(row_numbers, row), coll|
      row_numbers.each_with_index do |number, column|
        coll[number] = [row, column]
      end
    end
  end

  def score
    positions.reduce(0) do |score, (number, (row, coll))|
      if !marks[row][coll]
        score + number
      else
        score
      end
    end
  end

  def mark!(number)
    pos = positions[number]
    return unless pos

    row, col = pos
    @marks[row][col] = true
  end

  def bingo?
    row_bingo? || column_bingo?
  end

  def row_bingo?
    (0...5).any? do |row|
      (0...5).all? { |column| marks[row][column] == true }
    end
  end

  def column_bingo?
    (0...5).any? do |column|
      (0...5).all? { |row| marks[row][column] == true }
    end
  end
end
