require 'spec_helper'
require_relative '../../lib/2020/day03'

RSpec.describe 'Day 3' do
  let(:input) do
    <<~TXT
       ..##.......
       #...#...#..
       .#....#..#.
       ..#.#...#.#
       .#...##..#.
       ..#.##.....
       .#.#.#....#
       .#........#
       #.##...#...
       #...##....#
       .#..#...#.#
    TXT
  end

  context 'Part One' do
    describe '#tree?' do
      let(:solver) { Day03.new(input) }

      it 'determines whether there is a tree in the current position' do
        expect(solver.tree?([0, 0])).to be(false)
        expect(solver.tree?([0, 3])).to be(true)
        expect(solver.tree?([4, 1])).to be(true)

        expect(solver.tree?([0, 13])).to be(true)
        expect(solver.tree?([4, 12])).to be(true)
      end
    end

    describe '#move' do
      let(:solver) { Day03.new(input) }

      it 'returns a new position after moving right and down' do
        expect(solver.move([0, 0], 3, 1)).to eq([1, 3])
      end
    end

    describe '#part1' do
      it 'counts the number of trees' do
        expect(Day03.new(input).part1).to eq(7)
      end
    end
  end

  context 'Part Two' do
    describe '#part2' do
      it 'multiplies trees in all slopes' do
        expect(Day03.new(input).part2).to eq(336)
      end
    end
  end
end
