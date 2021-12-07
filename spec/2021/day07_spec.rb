# frozen_string_literal: true
require 'pry'
require '2021/day07'

describe 'Day 7' do
  let(:input) do
    <<~TXT
      16,1,2,0,4,2,7,1,2,14
    TXT
  end

  let(:solver) { Day07.new(input) }

  describe '#part1' do
    it 'returns the fuel to the best position' do
      expect(solver.part1).to eq(37)
    end
  end

  describe '#part2' do
    it 'returns the fuel to the best position' do
      expect(solver.part2).to eq(168)
    end
  end

  describe '#fuel_to' do
    it 'returns the total fuel needed to move to a position' do
      expect(solver.fuel_to(2)).to eq(37)
      expect(solver.fuel_to(1)).to eq(41)
      expect(solver.fuel_to(10)).to eq(71)
    end
  end

  describe '#crab_fuel_to' do
    it 'returns the fuel a crab needs to move to a position' do
      expect(solver.crab_fuel(16, 5)).to eq(66)
      expect(solver.crab_fuel(1, 5)).to eq(10)
      expect(solver.crab_fuel(2, 5)).to eq(6)
    end
  end
end
