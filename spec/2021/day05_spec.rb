# frozen_string_literal: true
require 'pry'
require '2021/day05'

describe 'Day 5' do
  let(:input) do
    <<~TXT
      0,9 -> 5,9
      8,0 -> 0,8
      9,4 -> 3,4
      2,2 -> 2,1
      7,0 -> 7,4
      6,4 -> 2,0
      0,9 -> 2,9
      3,4 -> 1,4
      0,0 -> 8,8
      5,5 -> 8,2
    TXT
  end

  let(:solver) { Day05.new(input) }

  describe '#part1' do
    it 'counts the number of overlapping points' do
      expect(solver.part1).to eq(5)
    end
  end

  describe '#part2' do
    it 'counts the number of overlapping points' do
      expect(solver.part2).to eq(12)
    end
  end

  describe '#draw_line!' do
    let(:points) do
      { [0, 9] => 1,
        [1, 9] => 1,
        [2, 9] => 1,
        [3, 9] => 1,
        [4, 9] => 1,
        [5, 9] => 1 }
    end

    it 'draws a line marking the points' do
      expect { solver.draw_line!([[0, 9], [5, 9]]) }.to change { solver.points }.from({}).to(points)
    end
  end

  describe '#horizontal_points' do
    let(:points) do
      [[0, 9], [1, 9], [2, 9], [3, 9], [4, 9], [5, 9]]
    end

    it 'returns the points of a horizontal line' do
      expect(solver.horizontal_points([[0, 9], [5, 9]]).to_a).to eq(points)
    end
  end

  describe '#vertical_points' do
    let(:points) do
      [[2, 1], [2, 2]]
    end

    let(:points2) do
      [[7, 0], [7, 1], [7, 2], [7, 3], [7, 4]]
    end

    it 'returns the points of a vertical line' do
      expect(solver.vertical_points([[2, 2], [2, 1]]).to_a).to eq(points)
      expect(solver.vertical_points([[7, 0], [7, 4]]).to_a).to eq(points2)
    end
  end

  describe '#diagonal_points' do
    let(:points) do
      [[1, 1], [2, 2], [3, 3]]
    end

    let(:points2) do
      [[9, 7], [8, 8], [7, 9]]
    end

    it 'returns the points of a diagonal line' do
      expect(solver.diagonal_points([[1, 1], [3, 3]]).to_a).to eq(points)
      expect(solver.diagonal_points([[9, 7], [7, 9]]).to_a).to eq(points2)
    end
  end

  describe '#lines' do
    let(:lines) do
      [[[0, 9], [5, 9]],
       [[8, 0], [0, 8]],
       [[9, 4], [3, 4]],
       [[2, 2], [2, 1]]]
    end

    it 'returns an array of lines' do
      expect(solver.lines[0...4]).to eq(lines)
    end
  end

  describe '#horizontal_or_vertical_lines' do
    let(:lines) do
      [[[0, 9], [5, 9]],
       [[9, 4], [3, 4]],
       [[2, 2], [2, 1]],
       [[7, 0], [7, 4]],
       [[0, 9], [2, 9]],
       [[3, 4], [1, 4]]]
    end

    it 'only returns horizontal or vertical lines' do
      expect(solver.horizontal_or_vertical_lines).to eq(lines)
    end
  end
end
