require 'spec_helper'
require_relative '../../lib/2020/day02'

RSpec.describe 'Day 2' do
  let(:list) do
    <<~TXT
        1-3 a: abcde
        1-3 b: cdefg
        2-9 c: ccccccccc
      TXT
  end

  context 'Part One' do
    describe '#valid?' do
      let(:solver) { Day02.new }

      it 'determines whether a password is valid' do
        expect(solver.valid?('1-3 a: abcde')).to be(true)
        expect(solver.valid?('1-3 b: cdefg')).to be(false)
        expect(solver.valid?('2-9 c: ccccccccc')).to be(true)
      end
    end

    describe '#part1' do
      it 'counts then number of valid passwords' do
        expect(Day02.new(list).part1).to eq(2)
      end
    end
  end

  context 'Part Two' do
    describe '#valid_new?' do
      let(:solver) { Day02.new }

      it 'determines whether a password is valid' do
        expect(solver.valid_new?('1-3 a: abcde')).to be(true)
        expect(solver.valid_new?('1-3 b: cdefg')).to be(false)
        expect(solver.valid_new?('2-9 c: ccccccccc')).to be(false)
      end
    end

    describe '#part2' do
      it 'counts then number of valid passwords' do
        expect(Day02.new(list).part2).to eq(1)
      end
    end
  end
end
