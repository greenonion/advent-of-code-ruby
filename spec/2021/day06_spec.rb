# frozen_string_literal: true
require 'pry'
require '2021/day06'

describe 'Day 6' do
  let(:input) do
    <<~TXT
      3,4,3,1,2
    TXT
  end

  let(:solver) { Day06.new(input) }

  describe '#part1' do
    it 'calculates number of fish after 80 days' do
      expect(solver.part1).to eq(5934)
    end
  end

  describe '#days!' do
    let(:population) do
      { 3 => 2, 4 => 1, 1 => 1, 2 => 1 }
    end

    it 'updates the population for a number of days' do
      solver.days!(18)
      expect(solver.total_fish).to eq(26)
    end

    it 'updates the population for a number of more days' do
      solver.days!(80)
      expect(solver.total_fish).to eq(5934)
    end

    it 'updates the population for a number of even more days' do
      solver.days!(256)
      expect(solver.total_fish).to eq(26_984_457_539)
    end
  end

  describe '#day!' do
    let(:population) do
      { 3 => 2, 4 => 1, 1 => 1, 2 => 1 }
    end

    let(:population_day2) do
      { 2 => 2, 3 => 1, 0 => 1, 1 => 1 }
    end

    it 'updates the population for the next day' do
      expect { solver.day! }.to change { solver.population }.from(population).to(population_day2)
    end
  end

  describe '#next_day' do
    let(:population) do
      { 3 => 2, 4 => 1, 1 => 1, 2 => 1 }
    end

    let(:population_day2) do
      { 2 => 2, 3 => 1, 0 => 1, 1 => 1 }
    end

    let(:population_day3) do
      { 1 => 2, 2 => 1, 6 => 1, 8 => 1, 0 => 1 }
    end

    it 'returns the population one day later' do
      expect(solver.next_day(population)).to eq(population_day2)
      expect(solver.next_day(population_day2)).to eq(population_day3)
    end
  end

  describe '#population' do
    it 'returns a hash with the lanternfish population' do
      expect(solver.population).to eq({ 3 => 2, 4 => 1, 1 => 1, 2 => 1 })
    end
  end
end
