# frozen_string_literal: true
#require 'spec_helper'
require 'rspec'

require '2020/day13'

describe 'Day 13' do
  let(:input) do
    <<~TXT
      939
      7,13,x,x,59,x,31,19
    TXT
  end

  describe '#part1' do
    let(:solver) { Day13.new(input) }
    it 'returns the correct answer' do
      expect(solver.part1).to eq(295)
    end
  end

  describe '#initalize' do
    let(:solver) { Day13.new(input) }
    it 'parses the input correctly' do
      expect(solver.timestamp).to eq(939)
      expect(solver.schedules).to eq('7,13,x,x,59,x,31,19')
    end
  end

  describe '#best_bus' do
    let(:solver) { Day13.new(input) }
    let(:timestamp) { 939 }
    let(:schedules) { [7, 13, 59, 31, 19] }

    it 'returns the number of the best bus' do
      expect(solver.best_bus(timestamp, schedules)).to eq(59)
    end
  end

  describe '#minutes_after' do
    let(:solver) { Day13.new }
    let(:timestamp) { 939 }

    it 'calculates number of minutes needed for the bus to get there' do
      expect(solver.minutes_after(timestamp, 7)).to eq(945 - timestamp)
      expect(solver.minutes_after(timestamp, 13)).to eq(949 - timestamp)
      expect(solver.minutes_after(timestamp, 59)).to eq(944 - timestamp)
      expect(solver.minutes_after(timestamp, 31)).to eq(961 - timestamp)
      expect(solver.minutes_after(timestamp, 19)).to eq(950 - timestamp)
    end
  end

  describe '#earliest_timestamp' do
    let(:solver) { Day13.new }

    it 'calculates the earliest timestamp of contiguous departures' do
      expect(solver.earliest_timestamp([7, 13, 'x', 'x', 59, 'x', 31, 19])).to eq(1_068_781)
      expect(solver.earliest_timestamp([17, 'x', 13, 19])).to eq(3_417)
      expect(solver.earliest_timestamp([67, 7, 59, 61])).to eq(754_018)
      expect(solver.earliest_timestamp([67, 'x', 7, 59, 61])).to eq(779_210)
      expect(solver.earliest_timestamp([67, 7, 'x', 59, 61])).to eq(1_261_476)
      expect(solver.earliest_timestamp([1789, 37, 47, 1889])).to eq(1_202_161_486)
    end
  end

  describe '#lcm' do
    let(:solver) { Day13.new}
    it 'calculates least common multiple' do
      expect(solver.lcm(21, 6)).to eq(42)
    end
  end
end
