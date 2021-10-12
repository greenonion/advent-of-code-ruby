require 'spec_helper'
require_relative '../../lib/2020/day05'

RSpec.describe 'Day 5' do

  describe '#row' do
    let(:solver) { Day05.new(nil) }
    it 'determines row from identifier' do
      expect(solver.row('FBFBBFF')).to eq(44)
      expect(solver.row('BFFFBBF')).to eq(70)
      expect(solver.row('FFFBBBF')).to eq(14)
      expect(solver.row('BBFFBBF')).to eq(102)
    end
  end

  describe '#column' do
    let(:solver) { Day05.new(nil) }
    it 'determines column from identifier' do
      expect(solver.column('RLR')).to eq(5)
      expect(solver.column('RRR')).to eq(7)
      expect(solver.column('RLL')).to eq(4)
    end
  end

  describe '#seat_id' do
    let(:solver) { Day05.new(nil) }
    it 'determines seat id from identifier' do
      expect(solver.seat_id('FBFBBFFRLR')).to eq(357)
      expect(solver.seat_id('BFFFBBFRRR')).to eq(567)
      expect(solver.seat_id('FFFBBBFRRR')).to eq(119)
      expect(solver.seat_id('BBFFBBFRLL')).to eq(820)
    end
  end

  describe '#part1' do
    let(:input) do
      <<~TXT
         FBFBBFFRLR
         BFFFBBFRRR
         FFFBBBFRRR
         BBFFBBFRLL
      TXT
    end
    let(:solver) { Day05.new(input) }

    it 'determines the max seat id' do
      expect(solver.part1).to eq(820)
    end
  end

  describe '#missing_seat_id' do
    let(:solver) { Day05.new(nil) }

    let(:seats) { [1, 4, 7, 23, 55, 87, 89, 100, 723, 82, 12, 667] }
    it 'determines the missing seat id' do
      expect(solver.missing_seat_id(seats)).to eq(88)
    end
  end
end
