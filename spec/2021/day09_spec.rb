# frozen_string_literal: true
require 'pry'
require '2021/day09'

describe 'Day 9' do
  let(:input) do
    <<~TXT
      2199943210
      3987894921
      9856789892
      8767896789
      9899965678
    TXT
  end

  let(:solver) { Day09.new(input) }

  describe '#part2' do
    it 'multiplies the sizes of the three largest basins' do
      expect(solver.part2).to eq(1134)
    end
  end

  describe '#basin_sizes' do
    it 'returns the sizes of all basins' do
      expect(solver.basin_sizes).to match_array([3, 9, 14, 9])
    end
  end

  describe '#basin_from' do
    it 'returns locations belonging to the basin starting from that location' do
      expect(solver.basin_from([0, 1])).to match_array([[0, 0], [0, 1], [1, 0]])
      expect(solver.basin_from([0, 9])).to match_array([[0, 5], [0, 6], [0, 7], [0, 8], [0, 9], [1, 6], [1, 8], [1, 9], [2, 9]])
    end
  end

  describe '#low_points' do
    it 'returns all low points' do
      expect(solver.low_points).to match_array([[0, 1], [0, 9], [2, 2], [4, 6]])
    end
  end

  describe '#risk_level_total' do
    it 'sums the risk level of low points' do
      expect(solver.risk_level_total).to eq(15)
    end
  end

  describe '#low_point?' do
    it 'checks whether a location is a low point' do
      expect(solver.low_point?([0, 0])).to be(false)
      expect(solver.low_point?([0, 1])).to be(true)
      expect(solver.low_point?([2, 2])).to be(true)
      expect(solver.low_point?([0, 9])).to be(true)
      expect(solver.low_point?([2, 3])).to be(false)
      expect(solver.low_point?([4, 6])).to be(true)
    end
  end

  describe '#adjacent_to' do
    it 'returns the locations of the adjacent locations' do
      expect(solver.adjacent_to([0, 0])).to match_array([[1, 0], [0, 1]])
      expect(solver.adjacent_to([2, 4])).to match_array([[2, 3], [2, 5], [1, 4], [3, 4]])
      expect(solver.adjacent_to([1, 9])).to match_array([[1, 8], [0, 9], [2, 9]])
      expect(solver.adjacent_to([4, 5])).to match_array([[4, 4], [3, 5], [4, 6]])
    end
  end
end
