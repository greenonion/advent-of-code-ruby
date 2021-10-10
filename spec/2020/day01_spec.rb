require_relative '../../lib/2020/day01'

RSpec.describe 'Day 1' do
  let(:entries) do
    <<~TXT
        1721
        979
        366
        299
        675
        1456
      TXT
  end

  context 'Part One' do
    it 'finds and multiplies two entries that sum to 2020' do
      expect(Day01.new(entries).part1).to eq(514579)
    end
  end

  context 'Part Two' do
    it 'finds and multiplies three entries that sum to 2020' do
      expect(Day01.new(entries).part2).to eq(241861950)
    end
  end
end
