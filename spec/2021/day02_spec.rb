# frozen_string_literal: true

require '2021/day02'

describe 'Day 2' do
  let(:input) do
    <<~TXT
      forward 5
      down 5
      forward 8
      up 3
      down 8
      forward 2
    TXT
  end

  let(:solver) { Day02.new(input) }

  describe '#part1' do
    it 'follows commands and multiplies horizontal and depth' do
      expect(solver.part1).to eq(150)
    end
  end

  describe '#part2' do
    it 'follows commands and multiplies horizontal and depth' do
      expect(solver.part2).to eq(900)
    end
  end

  describe '#follow_commands!' do
    let(:start) { { horizontal: 0, depth: 0, aim: 0 } }
    let(:finish) { { horizontal: 15, depth: 10 } }

    it 'updates the position accordingly' do
      expect { solver.follow_commands! }.to change { solver.position }.from(start).to(finish)
    end
  end

  describe '#follow_commands_with_aim!' do
    let(:start) { { horizontal: 0, depth: 0, aim: 0 } }
    let(:finish) { { horizontal: 15, depth: 60, aim: 10 } }

    it 'updates the position accordingly' do
      expect { solver.follow_commands_with_aim! }.to change { solver.position }.from(start).to(finish)
    end
  end

  describe '#updated_position' do
    let(:position) { { horizontal: 0, depth: 0 } }

    it 'updates the position according to the command' do
      expect(solver.updated_position(position, ['forward', 5])).to eq({ horizontal: 5, depth: 0 })
      expect(solver.updated_position(position, ['down', 5])).to eq({ horizontal: 0, depth: 5 })
      expect(solver.updated_position(position, ['up', 3])).to eq({ horizontal: 0, depth: -3 })
    end
  end

  describe '#updated_position_with_aim' do
    let(:position) { { horizontal: 0, depth: 0, aim: 0 } }
    let(:position2) { { horizontal: 5, depth: 0, aim: 5 } }

    it 'updates the position according to the command' do
      expect(solver.updated_position_with_aim(position, ['forward', 5])).to eq({ horizontal: 5, depth: 0, aim: 0 })
      expect(solver.updated_position_with_aim(position, ['down', 5])).to eq({ horizontal: 0, depth: 0, aim: 5 })
      expect(solver.updated_position_with_aim(position, ['up', 3])).to eq({ horizontal: 0, depth: 0, aim: -3 })
      expect(solver.updated_position_with_aim(position2, ['forward', 8])).to eq({ horizontal: 13, depth: 40, aim: 5 })
    end
  end
end
