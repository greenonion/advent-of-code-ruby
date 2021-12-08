# frozen_string_literal: true
require 'pry'
require '2021/day08'

describe 'Day 8' do
  let(:input) do
    <<~TXT
      be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
      edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
      fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
      fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
      aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
      fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
      dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
      bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
      egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
      gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
    TXT
  end

  let(:solver) { Day08.new(input) }

  describe '#part1' do
    it 'returns unique output count for all notes' do
      expect(solver.part1).to eq(26)
    end
  end

  describe '#part2' do
    it 'sums all outputs' do
      expect(solver.part2).to eq(61_229)
    end
  end
end

describe 'Note' do
  let(:positions) do
    {
      t: Set.new(['a', 'b', 'c', 'd', 'e', 'f', 'g']),
      tl: Set.new(['a', 'b', 'c', 'd', 'e', 'f', 'g']),
      tr: Set.new(['a', 'b', 'c', 'd', 'e', 'f', 'g']),
      m: Set.new(['a', 'b', 'c', 'd', 'e', 'f', 'g']),
      bl: Set.new(['a', 'b', 'c', 'd', 'e', 'f', 'g']),
      br: Set.new(['a', 'b', 'c', 'd', 'e', 'f', 'g']),
      b: Set.new(['a', 'b', 'c', 'd', 'e', 'f', 'g'])
    }
  end

  let(:note1_input) do
    'be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe'
  end

  let(:note1) { Note.new(note1_input) }

  describe 'output_number' do
    let(:note_input) do
      'acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf'
    end

    let(:note) { Note.new(note_input) }

    it 'works' do
      expect(note.output_number).to eq(5353)
    end
  end

  describe '#unique_output_segment_count' do
    let(:note2_input) do
      'edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc'
    end

    let(:note2) { Note.new(note2_input) }

    let(:note3_input) do
      'fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg'
    end

    let(:note3) { Note.new(note3_input) }

    let(:note4_input) do
      'fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb'
    end

    let(:note4) { Note.new(note4_input) }

    it 'counts the output segments for 1, 4, 7, and 8' do
      expect(note1.unique_output_segment_count).to eq(2)
      expect(note2.unique_output_segment_count).to eq(3)
      expect(note3.unique_output_segment_count).to eq(3)
      expect(note4.unique_output_segment_count).to eq(1)
    end
  end
end
