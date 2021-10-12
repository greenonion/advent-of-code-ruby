# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/2020/day09'

RSpec.describe 'Day 9' do
  let(:input) do
    <<~TXT
      35
      20
      15
      25
      47
      40
      62
      55
      65
      95
      102
      117
      150
      182
      127
      219
      299
      277
      309
      576
    TXT
  end

  describe '#valid?' do
    let(:solver) { Day09.new(nil) }
    let(:preamble) { (1..25).to_a.shuffle }

    it 'checks whether number is sum of two different preamble numbers' do
      expect(solver.valid?(preamble, 26)).to be(true)
      expect(solver.valid?(preamble, 49)).to be(true)
      expect(solver.valid?(preamble, 100)).to be(false)
      expect(solver.valid?(preamble, 50)).to be(false)

      preamble2 = preamble.dup
      preamble2.delete(20)
      preamble2.push(45)

      expect(solver.valid?(preamble2, 26)).to be(true)
      expect(solver.valid?(preamble2, 65)).to be(false)
      expect(solver.valid?(preamble2, 64)).to be(true)
      expect(solver.valid?(preamble2, 66)).to be(true)
    end
  end

  describe '#first_invalid' do
    let(:solver) { Day09.new(input, 5) }

    it 'returns the first invalid number' do
      expect(solver.first_invalid).to eq(127)
    end
  end

  describe '#contiguous_range' do
    let(:solver) { Day09.new(input, 5) }

    it 'returns the range summing to the number' do
      expect(solver.contiguous_range(127)).to eq([15, 25, 47, 40])
    end
  end

  describe '#part2' do
    let(:solver) { Day09.new(input, 5) }

    it 'adds the smallest and the largest numbers in the range summing to the number' do
      expect(solver.part2).to eq(62)
    end
  end
end
