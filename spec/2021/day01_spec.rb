# frozen_string_literal: true

require '2021/day01'

describe 'Day 1' do
  let(:input) do
    <<~TXT
      199
      200
      208
      210
      200
      207
      240
      269
      260
      263
    TXT
  end

  let(:solver) { Day01.new(input) }

  describe '#times_increased' do
    let(:measurements) { [199, 200, 208, 210, 200, 207, 240, 269, 260, 263] }

    it 'counts the number of times the depth increased' do
      expect(solver.times_increased(measurements)).to eq(7)
    end
  end

  describe '#in_threes' do
    it 'creates a lazy enumerator in threes from starting index to the end' do
      expect(solver.in_threes(0, 5).to_a).to eq([[0, 1, 2], [1, 2, 3], [2, 3, 4]])
    end
  end

  describe '#times_increased_sliding' do
    let(:measurements) { [199, 200, 208, 210, 200, 207, 240, 269, 260, 263] }

    it 'counts the number of times the depth increased in a sliding window of three' do
      expect(solver.times_increased_sliding(measurements)).to eq(5)
    end
  end

  describe '#window_total' do
    let(:measurements) { [199, 200, 208, 210, 200, 207, 240, 269, 260, 263] }

    it 'sums the measurements of a window' do
      expect(solver.window_total(measurements, [0, 1, 2])).to eq(199 + 200 + 208)
    end
  end
end
