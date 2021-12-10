# frozen_string_literal: true
require 'pry'
require '2021/day10'

describe 'Day 10' do
  let(:input) do
    <<~TXT
      [({(<(())[]>[[{[]{<()<>>
      [(()[<>])]({[<{<<[]>>(
      {([(<{}[<>[]}>{[]{[(<()>
      (((({<>}<{<{<>}{[]{[]{}
      [[<[([]))<([[{}[[()]]]
      [{[{({}]{}}([{[{{{}}([]
      {<[[]]>}<{[{[{[]{()[[[]
      [<(<(<(<{}))><([]([]()
      <{([([[(<>()){}]>(<<{{
      <{([{{}}[<[[[<>{}]]]>[]]
    TXT
  end

  let(:solver) { Day10.new(input) }

  describe '#missing_chunk' do
    let(:chunk1) { '[({(<(())[]>[[{[]{<()<>>' }
    let(:chunk2) { '[(()[<>])]({[<{<<[]>>(' }
    let(:chunk3) { '(((({<>}<{<{<>}{[]{[]{}' }
    let(:chunk4) { '{<[[]]>}<{[{[{[]{()[[[]' }
    let(:chunk5) { '<{([{{}}[<[[[<>{}]]]>[]]' }

    it 'returns the missing part of the chunk' do
      expect(solver.missing_chunk(chunk1)).to eq('}}]])})]')
      expect(solver.missing_chunk(chunk2)).to eq(')}>]})')
      expect(solver.missing_chunk(chunk3)).to eq('}}>}>))))')
      expect(solver.missing_chunk(chunk4)).to eq(']]}}]}]}>')
      expect(solver.missing_chunk(chunk5)).to eq('])}>')
    end
  end

  describe '#autocomplete_score' do
    it 'works' do
      expect(solver.autocomplete_score).to eq(288_957)
    end
  end

  describe '#missing_score' do
    it 'works' do
      expect(solver.missing_score('}}]])})]')).to eq(288_957)
      expect(solver.missing_score(')}>]})')).to eq(5_566)
      expect(solver.missing_score('}}>}>))))')).to eq(1_480_781)
      expect(solver.missing_score(']]}}]}]}>')).to eq(995_444)
      expect(solver.missing_score('])}>')).to eq(294)
    end
  end

  describe '#syntax_error_score' do
    it 'works' do
      expect(solver.syntax_error_score).to eq(26_397)
    end
  end

  describe '#incomplete_count' do
    it 'counts incomplete inputs' do
      expect(solver.incomplete_count).to eq(5)
    end
  end

  describe '#corrupted_count' do
    it 'counts corrupted inputs' do
      expect(solver.corrupted_count).to eq(5)
    end
  end

  describe '#first_illegal' do
    let(:chunk1) { '{([(<{}[<>[]}>{[]{[(<()>' }
    let(:chunk2) { '[[<[([]))<([[{}[[()]]]' }
    let(:chunk3) { '[{[{({}]{}}([{[{{{}}([]' }
    let(:chunk4) { '[<(<(<(<{}))><([]([]()' }
    let(:chunk5) { '<{([([[(<>()){}]>(<<{{' }

    it 'returns the first illegal character in a chunk' do
      expect(solver.first_illegal(chunk1)).to eq('}')
      expect(solver.first_illegal(chunk2)).to eq(')')
      expect(solver.first_illegal(chunk3)).to eq(']')
      expect(solver.first_illegal(chunk4)).to eq(')')
      expect(solver.first_illegal(chunk5)).to eq('>')
    end
  end

  describe '#legal?' do
    context 'when chunks are legal' do
      let(:chunk1) { '()' }
      let(:chunk2) { '[]' }
      let(:chunk3) { '([])' }
      let(:chunk4) { '{()()()}' }
      let(:chunk5) { '<([{}])>' }
      let(:chunk6) { '[<>({}){}[([])<>]]' }
      let(:chunk7) { '(((((((((())))))))))' }

      it 'returns true if a chunks is legal' do
        expect(solver.legal?(chunk1)).to be(true)
        expect(solver.legal?(chunk2)).to be(true)
        expect(solver.legal?(chunk3)).to be(true)
        expect(solver.legal?(chunk4)).to be(true)
        expect(solver.legal?(chunk5)).to be(true)
        expect(solver.legal?(chunk6)).to be(true)
        expect(solver.legal?(chunk7)).to be(true)
      end
    end

    context 'when chunks are corrupted' do
      let(:corrupted1) { '(]' }
      let(:corrupted2) { '{()()()>' }
      let(:corrupted3) { '(((()))}' }
      let(:corrupted4) { '<([]){()}[{}])' }

      it 'returns false if a chunk is corrupted' do
        expect(solver.legal?(corrupted1)).to be(false)
        expect(solver.legal?(corrupted2)).to be(false)
        expect(solver.legal?(corrupted3)).to be(false)
        expect(solver.legal?(corrupted4)).to be(false)
      end
    end
  end
end
