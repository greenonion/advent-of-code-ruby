# frozen_string_literal: true

require '2021/day03'

describe 'Day 3' do
  let(:input) do
    <<~TXT
      00100
      11110
      10110
      10111
      10101
      01111
      00111
      11100
      10000
      11001
      00010
      01010
    TXT
  end

  let(:solver) { Day03.new(input) }

  describe '#part2' do
    it 'multiplies oxygen and co2' do
      expect(solver.part2).to eq(230)
    end
  end

  describe '#oxygen_generator_rating' do
    let(:report) do
      input.split("\n").map { |s| s.split('') }
    end

    it 'uses the most common bit criteron' do
      expect(solver.oxygen_generator_rating(report)).to eq(23)
    end
  end

  describe '#co2_scrubber_rating' do
    let(:report) do
      input.split("\n").map { |s| s.split('') }
    end

    it 'uses the least common bit criteron' do
      expect(solver.co2_scrubber_rating(report)).to eq(10)
    end
  end

  describe '#gamma_rate' do
    let(:report) do
      input.split("\n").map { |s| s.split('') }
    end

    it 'keeps the most common bit in each position' do
      expect(solver.gamma_rate(report)).to eq(22)
    end
  end

  describe '#epsilon_rate' do
    let(:report) do
      input.split("\n").map { |s| s.split('') }
    end

    it 'keeps the least common bit in each position' do
      expect(solver.epsilon_rate(report)).to eq(9)
    end
  end

  describe '#most_common' do
    let(:report) do
      input.split("\n").map { |s| s.split('') }
    end

    it 'calculates the most common bit in each position' do
      expect(solver.most_common(report)).to eq(['1', '0', '1', '1', '0'])
    end
  end

  describe '#least_common' do
    let(:report) do
      input.split("\n").map { |s| s.split('') }
    end

    it 'calculates the least common bit in each position' do
      expect(solver.least_common(report)).to eq(['0', '1', '0', '0', '1'])
    end
  end
end
