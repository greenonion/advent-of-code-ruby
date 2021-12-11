# frozen_string_literal: true
require 'pry'
require '2021/day11'

def string_to_map(input)
  input.split("\n").map { |line| line.split('').map(&:to_i) }
end

describe 'Day 11' do
  let(:input) do
    <<~TXT
      5483143223
      2745854711
      5264556173
      6141336146
      6357385478
      4167524645
      2176841721
      6882881134
      4846848554
      5283751526
      TXT
  end

  let(:solver) { Day11.new(input) }

  describe '#synced_after' do
    it 'returns the number of steps needed for a synced flash' do
      expect(solver.synced_after).to eq(195)
    end
  end

  describe '#flashes_after' do
    it 'returns the number of flashes after a number of steps' do
      expect(solver.flashes_after(10)).to eq(204)
    end

    it 'returns the number of flashes after a number of steps' do
      expect(solver.flashes_after(100)).to eq(1_656)
    end
  end

  describe '#step' do
    context 'when map is large' do
      let(:solver) { Day11.new(large_map) }

      let(:large_map) do
        <<~TXT
          5483143223
          2745854711
          5264556173
          6141336146
          6357385478
          4167524645
          2176841721
          6882881134
          4846848554
          5283751526
        TXT
      end

      let(:large_map2) do
        <<~TXT
          6594254334
          3856965822
          6375667284
          7252447257
          7468496589
          5278635756
          3287952832
          7993992245
          5957959665
          6394862637
        TXT
      end

      let(:large_map3) do
        <<~TXT
          8807476555
          5089087054
          8597889608
          8485769600
          8700908800
          6600088989
          6800005943
          0000007456
          9000000876
          8700006848
        TXT
      end

      it 'produces the next step' do
        map1 = string_to_map(large_map)
        map2 = string_to_map(large_map2)
        map3 = string_to_map(large_map3)

        expect(solver.step(map1)[:map]).to eq(map2)
        expect(solver.step(map2)[:map]).to eq(map3)
      end
    end

    context 'when map is small' do
      let(:solver) { Day11.new(small_map) }

      let(:small_map) do
        <<~TXT
          11111
          19991
          19191
          19991
          11111
        TXT
      end

      let(:small_map2) do
        <<~TXT
          34543
          40004
          50005
          40004
          34543
        TXT
      end

      let(:small_map3) do
        <<~TXT
          45654
          51115
          61116
          51115
          45654
        TXT
      end

      it 'produces the next step' do
        map1 = string_to_map(small_map)
        map2 = string_to_map(small_map2)
        map3 = string_to_map(small_map3)

        expect(solver.step(map1)[:map]).to eq(map2)
        expect(solver.step(map2)[:map]).to eq(map3)
      end
    end
  end
end
