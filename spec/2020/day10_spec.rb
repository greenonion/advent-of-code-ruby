# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/2020/day10'

RSpec.describe 'Day 10' do
  let(:input) do
    <<~TXT
      16
      10
      15
      5
      1
      11
      7
      19
      6
      12
      4
    TXT
  end

  let(:large_input) do
    <<~TXT
      28
      33
      18
      42
      31
      14
      46
      20
      48
      47
      24
      23
      49
      45
      19
      38
      39
      11
      1
      32
      25
      35
      8
      17
      7
      9
      4
      2
      34
      10
      3
    TXT
  end

  describe '#differences' do
    let(:solver) { Day10.new(input) }
    let(:solver2) { Day10.new(large_input) }

    it 'returns a map of the difference frequencies' do
      expect(solver.differences).to eq({ 1 => 7, 3 => 5 })
      expect(solver2.differences).to eq({ 1 => 22, 3 => 10 })
    end
  end

  describe '#arrangements' do
    let(:solver) { Day10.new(input) }
    let(:solver2) { Day10.new(large_input) }

    it 'returns the number of different arrangements' do
      expect(solver.arrangements).to eq(8)
      expect(solver2.arrangements).to eq(19_208)
    end
  end

  describe '#ways_to_reach' do
    let(:solver) { Day10.new(input) }
    let(:solver2) { Day10.new(large_input) }

    # 0, 1, 4, 5, 6, 7, 10, 11, 12, 15, 16, 19
    it 'returns the number of ways to reach ith element' do
      expect(solver.ways_to_reach(1)).to eq(1)
      expect(solver.ways_to_reach(2)).to eq(1)
      expect(solver.ways_to_reach(3)).to eq(1)
      expect(solver.ways_to_reach(4)).to eq(2)
      expect(solver.ways_to_reach(5)).to eq(4)
      expect(solver.ways_to_reach(6)).to eq(4)
    end

    # 0, 1, 2, 3, 4, 7, 8, 9, 10, 11, 14, 17, 18, 19
    # 0, 1, 2, 3, 4, 5, 6, 7,  8,  9, 10, 11, 11, 12
    it 'returns the number of ways to reach ith element for the large input' do
      expect(solver2.ways_to_reach(1)).to eq(1)
      expect(solver2.ways_to_reach(2)).to eq(2)
    end
  end
end
