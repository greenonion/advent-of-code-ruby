# frozen_string_literal: true

require 'rspec'
require '2020/day15'

describe 'Day 15' do
  describe '#say!' do
    let(:solver) { Day15.new('0,3,6') }

    it 'says the next number' do
      expect(solver.say!).to eq(0)
      expect(solver.say!).to eq(3)
      expect(solver.say!).to eq(3)
      expect(solver.say!).to eq(1)
      expect(solver.say!).to eq(0)
      expect(solver.say!).to eq(4)
      expect(solver.say!).to eq(0)
    end
  end

  describe '#thirtymillth' do
    context 'first solver' do
      let(:solver) { Day15.new('0,3,6') }

      it 'returns the 30mth number' do
        expect(solver.thirtymillth).to eq(175594)
      end
    end
  end

  describe '#twentytwentyth' do
    context 'first solver' do
      let(:solver) { Day15.new('0,3,6') }

      it 'returns the 2020th number' do
        expect(solver.twentytwentyth).to eq(436)
      end
    end

    context 'second solver' do
      let(:solver) { Day15.new('1,3,2') }

      it 'returns the 2020th number' do
        expect(solver.twentytwentyth).to eq(1)
      end
    end

    context 'third solver' do
      let(:solver) { Day15.new('2,1,3') }

      it 'returns the 2020th number' do
        expect(solver.twentytwentyth).to eq(10)
      end
    end

    context 'fourth solver' do
      let(:solver) { Day15.new('1,2,3') }

      it 'returns the 2020th number' do
        expect(solver.twentytwentyth).to eq(27)
      end
    end

    context 'fifth solver' do
      let(:solver) { Day15.new('2,3,1') }

      it 'returns the 2020th number' do
        expect(solver.twentytwentyth).to eq(78)
      end
    end

    context 'sixth solver' do
      let(:solver) { Day15.new('3,2,1') }

      it 'returns the 2020th number' do
        expect(solver.twentytwentyth).to eq(438)
      end
    end

    context 'seventh solver' do
      let(:solver) { Day15.new('3,1,2') }

      it 'returns the 2020th number' do
        expect(solver.twentytwentyth).to eq(1836)
      end
    end
  end
end
