# frozen_string_literal: true
require 'pry'
require '2021/day04'

describe 'Day 4' do
  let(:input) do
    <<~TXT
      7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

      22 13 17 11  0
      8  2 23  4 24
      21  9 14 16  7
      6 10  3 18  5
      1 12 20 15 19

      3 15  0  2 22
      9 18 13 17  5
      19  8  7 25 23
      20 11 10 24  4
      14 21 16 12  6

      14 21 17 24  4
      10 16 15  9 19
      18  8 23 26 20
      22 11 13  6  5
      2  0 12  3  7
    TXT
  end

  let(:solver) { Day04.new(input) }

  describe '#part1' do
    it 'works' do
      expect(solver.part1).to eq(4512)
    end
  end

  describe '#part2' do
    it 'works' do
      expect(solver.part2).to eq(1924)
    end
  end
end

describe 'Board' do
  let(:input) do
    <<~TXT
      3 15  0  2 22
      9 18 13 17  5
      19  8  7 25 23
      20 11 10 24  4
      14 21 16 12  6
    TXT
  end

  describe '.initialize' do
    it 'creates a new board' do
      board = Board.new(input)
      expect(board.marks).to eq(Array.new(5) { Array.new(5, false) })
      expect(board.positions[3]).to eq([0, 0])
      expect(board.positions[0]).to eq([0, 2])
      expect(board.positions[24]).to eq([3, 3])
    end
  end

  describe '#score' do
    let(:input) do
      <<~TXT
        14 21 17 24  4
        10 16 15  9 19
        18  8 23 26 20
        22 11 13  6  5
        2  0 12  3  7
      TXT
    end

    let(:board) { Board.new(input) }

    let(:marks) do
      [[true, true, true, true, true],
       [false, false, false, true, false],
       [false, false, true, false, false],
       [false, true, false, false, true],
       [true, true, false, false, true]]
    end

    it 'returns the sum of all unmarked numbers' do
      allow(board).to receive(:marks).and_return(marks)
      expect(board.score).to eq(188)
    end
  end

  describe '#mark!' do
    let(:board) { Board.new(input) }

    let(:initial_positions) do
      [[false, false, false, false, false],
       [false, false, false, false, false],
       [false, false, false, false, false],
       [false, false, false, false, false],
       [false, false, false, false, false]]
    end

    let(:marked_three) do
      [[true, false, false, false, false],
       [false, false, false, false, false],
       [false, false, false, false, false],
       [false, false, false, false, false],
       [false, false, false, false, false]]
    end

    it 'marks the number called' do
      expect { board.mark!(3) }.to change { board.marks }.from(initial_positions).to(marked_three)
    end

    it 'does not mark if number does not exist' do
      expect { board.mark!(100) }.not_to change { board.marks }
    end
  end

  describe '#bingo?' do
    let(:board) { Board.new(input) }

    let(:no_bingo) do
      [[true, false, false, false, true],
       [true, false, true, true, true],
       [false, false, false, false, false],
       [false, false, false, false, false],
       [false, false, false, false, false]]
    end

    let(:row_bingo) do
      [[true, false, false, false, true],
       [true, true, true, true, true],
       [false, false, false, false, false],
       [false, false, false, false, false],
       [false, false, false, false, false]]
    end

    let(:column_bingo) do
      [[true, false, false, false, true],
       [true, false, true, true, true],
       [true, false, false, false, false],
       [true, false, false, false, false],
       [true, false, false, false, false]]
    end

    it 'does not find if no bingo' do
      allow(board).to receive(:marks).and_return(no_bingo)
      expect(board.bingo?).to be(false)
    end

    it 'finds row bingos' do
      allow(board).to receive(:marks).and_return(row_bingo)
      expect(board.bingo?).to be(true)
    end

    it 'finds column bingos' do
      allow(board).to receive(:marks).and_return(column_bingo)
      expect(board.bingo?).to be(true)
    end
  end
end
