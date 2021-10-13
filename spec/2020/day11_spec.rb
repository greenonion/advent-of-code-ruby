# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/2020/day11'

RSpec.describe 'Day 11' do
  let(:input) do
    <<~TXT
      L.LL.LL.LL
      LLLLLLL.LL
      L.L.L..L..
      LLLL.LL.LL
      L.LL.LL.LL
      L.LLLLL.LL
      ..L.L.....
      LLLLLLLLLL
      L.LLLLLL.L
      L.LLLLL.LL
    TXT
  end

  let(:round1) do
    <<~TXT
      #.##.##.##
      #######.##
      #.#.#..#..
      ####.##.##
      #.##.##.##
      #.#####.##
      ..#.#.....
      ##########
      #.######.#
      #.#####.##
    TXT
  end

  let(:round2) do
    <<~TXT
      #.LL.L#.##
      #LLLLLL.L#
      L.L.L..L..
      #LLL.LL.L#
      #.LL.LL.LL
      #.LLLL#.##
      ..L.L.....
      #LLLLLLLL#
      #.LLLLLL.L
      #.#LLLL.##
    TXT
  end

  let(:round3) do
    <<~TXT
      #.##.L#.##
      #L###LL.L#
      L.#.#..#..
      #L##.##.L#
      #.##.LL.LL
      #.###L#.##
      ..#.#.....
      #L######L#
      #.LL###L.L
      #.#L###.##
    TXT
  end

  describe '#part!' do
    let(:solver) { Day11.new(input) }

    it 'stabilizes and counts occupied seats' do
      expect(solver.part1).to eq(37)
    end
  end

  describe '#stabilize!' do
    let(:solver) { Day11.new(input) }

    it 'ticks until stable' do
      expect(solver.stabilize!).to eq(5)
    end
  end

  describe '#tick' do
    it 'iterates the layout once' do
      solver = Day11.new(input)
      out = round1.split("\n").map(&:chars)
      expect(solver.tick[:next_frame]).to eq(out)

      solver = Day11.new(round1)
      out = round2.split("\n").map(&:chars)
      expect(solver.tick[:next_frame]).to eq(out)

      solver = Day11.new(round2)
      out = round3.split("\n").map(&:chars)
      expect(solver.tick[:next_frame]).to eq(out)
    end
  end

  describe '#occupied_neighbors' do
    let(:solver) { Day11.new(round1) }

    it 'returns the number of occupied neighbors' do
      expect(solver.occupied_neighbors([0, 0])).to eq(2)
      expect(solver.occupied_neighbors([0, 1])).to eq(5)
      expect(solver.occupied_neighbors([3, 3])).to eq(5)
    end
  end

  describe '#empty?' do
    let(:solver) { Day11.new(input) }

    it 'checks whether a square is empty' do
      expect(solver.empty?([0, 0])).to be(true)
      expect(solver.empty?([0, 1])).to be(false)
      expect(solver.empty?([3, 3])).to be(true)
    end
  end

  describe '#occupied?' do
    let(:solver) { Day11.new(round1) }

    it 'checks whether a square is empty' do
      expect(solver.occupied?([0, 0])).to be(true)
      expect(solver.occupied?([0, 1])).to be(false)
      expect(solver.occupied?([3, 3])).to be(true)
    end
  end

  describe '#neighbors' do
    let(:solver) { Day11.new(input) }

    it 'returns the locations of the neighbors' do
      expect(solver.neighbors([0, 0])).to match_array([[0, 1], [1, 0], [1, 1]])
      expect(solver.neighbors([0, 3])).to match_array([[0, 2], [1, 2], [1, 3], [1, 4], [0, 4]])
      expect(solver.neighbors([2, 2])).to match_array([[1, 1], [1, 2], [1, 3], [2, 1], [2, 3], [3, 1], [3, 2], [3, 3]])
      expect(solver.neighbors([9, 3])).to match_array([[9, 2], [8, 2], [8, 3], [8, 4], [9, 4]])
      expect(solver.neighbors([9, 9])).to match_array([[9, 8], [8, 8], [8, 9]])
    end
  end

  context 'example 1' do
    let(:solver) { Day11.new(input) }

    let(:input) do
      <<~TXT
          .......#.
          ...#.....
          .#.......
          .........
          ..#L....#
          ....#....
          .........
          #........
          ...#.....
        TXT
    end

    let(:pos) { [4, 3] }

    describe '#seat_towards' do
      it 'returns the first seat towards a direction' do
        expect(solver.seat_towards(pos, :n)).to eq([1, 3])
        expect(solver.seat_towards(pos, :ne)).to eq([0, 7])
        expect(solver.seat_towards(pos, :e)).to eq([4, 8])
        expect(solver.seat_towards(pos, :se)).to eq([5, 4])
        expect(solver.seat_towards(pos, :s)).to eq([8, 3])
        expect(solver.seat_towards(pos, :sw)).to eq([7, 0])
        expect(solver.seat_towards(pos, :w)).to eq([4, 2])
        expect(solver.seat_towards(pos, :nw)).to eq([2, 1])
      end
    end

    describe '#visible_occupied' do
      it 'returns the number of visible occupied seats' do
        expect(solver.visible_occupied(pos)).to eq(8)
      end
    end
  end

  context 'example 2' do
    let(:input) do
      <<~TXT
        .............
        .L.L.#.#.#.#.
        .............
      TXT
    end

    let(:solver) { Day11.new(input) }

    let(:pos) { [1, 1] }

    describe '#seat_towards' do
      it 'returns the first seat towards a direction' do
        expect(solver.seat_towards(pos, :n)).to be_nil
        expect(solver.seat_towards(pos, :ne)).to be_nil
        expect(solver.seat_towards(pos, :e)).to eq([1, 3])
        expect(solver.seat_towards(pos, :se)).to be_nil
        expect(solver.seat_towards(pos, :s)).to be_nil
        expect(solver.seat_towards(pos, :sw)).to be_nil
        expect(solver.seat_towards(pos, :w)).to be_nil
        expect(solver.seat_towards(pos, :nw)).to be_nil
      end
    end

    describe '#visible_occupied' do
      it 'returns the number of visible occupied seats' do
        expect(solver.visible_occupied(pos)).to eq(0)
      end
    end
  end

  context 'example 3' do
    let(:input) do
      <<~TXT
        .##.##.
        #.#.#.#
        ##...##
        ...L...
        ##...##
        #.#.#.#
        .##.##.
      TXT
    end

    let(:solver) { Day11.new(input) }

    let(:pos) { [3, 3] }

    describe '#seat_towards' do
      it 'returns the first seat towards a direction' do
        expect(solver.seat_towards(pos, :n)).to be_nil
        expect(solver.seat_towards(pos, :ne)).to be_nil
        expect(solver.seat_towards(pos, :e)).to be_nil
        expect(solver.seat_towards(pos, :se)).to be_nil
        expect(solver.seat_towards(pos, :s)).to be_nil
        expect(solver.seat_towards(pos, :sw)).to be_nil
        expect(solver.seat_towards(pos, :w)).to be_nil
        expect(solver.seat_towards(pos, :nw)).to be_nil
      end
    end

    describe '#visible_occupied' do
      it 'returns the number of visible occupied seats' do
        expect(solver.visible_occupied(pos)).to eq(0)
      end
    end
  end

  describe '#stabilize_visible!' do
    let(:solver) { Day11.new(input) }

    it 'ticks until stable' do
      expect(solver.stabilize_visible!).to eq(6)
    end
  end

  describe '#part2' do
    let(:solver) { Day11.new(input) }

    it 'stabilizes and counts occupied seats' do
      expect(solver.part2).to eq(26)
    end
  end
end
