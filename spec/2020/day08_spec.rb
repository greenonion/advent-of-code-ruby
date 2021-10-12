# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/2020/day08'

RSpec.describe 'Day 8' do
  let(:input) do
    <<~TXT
      nop +0
      acc +1
      jmp +4
      acc +3
      jmp -3
      acc -99
      acc +1
      jmp -4
      acc +6
    TXT
  end

  describe '#part1' do
    let(:solver) { Day08.new(input) }

    it 'returns the value in the accumulator before starting the loop' do
      expect(solver.part1).to eq(5)
    end
  end

  describe '#run_until_end' do
    let(:solver) { Day08.new(input) }

    it 'returns the pc of the instruction needed to change' do
      expect(solver.run_until_end).to eq(7)
    end
  end

  describe '#part2' do
    let(:solver) { Day08.new(input) }

    it 'returns the value in the accumulator after exiting' do
      expect(solver.part2).to eq(8)
    end
  end
end
