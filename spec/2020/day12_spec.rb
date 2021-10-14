# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/2020/day12'

RSpec.describe 'Day 12' do
  let(:input) do
    <<~TXT
      F10
      N3
      F7
      R90
      F11
    TXT
  end

  describe '#part1' do
    let(:solver) { Day12.new(input) }

    it 'moves and calculates manhattan distance' do
      expect(solver.part1).to eq(25)
    end
  end

  describe '#execute_instructions!' do
    let(:solver) { Day12.new(input) }

    it 'moves the ship accordingly' do
      solver.execute_instructions!
      expect(solver.direction).to eq(:s)
      expect(solver.pos).to eq([17, -8])
    end
  end

  describe '#step' do
    let(:solver) { Day12.new(input) }
    let(:state) do
      {
        direction: :e,
        pos: [0, 0]
      }
    end

    it 'moves the ship accordingly' do
      expect(solver.step(state, 'F10')).to eq({ direction: :e, pos: [10, 0] })
      expect(solver.step(state, 'N3')).to eq({ direction: :e, pos: [0, 3] })
      expect(solver.step(state, 'E3')).to eq({ direction: :e, pos: [3, 0] })
      expect(solver.step(state, 'S3')).to eq({ direction: :e, pos: [0, -3] })
      expect(solver.step(state, 'R90')).to eq({ direction: :s, pos: [0, 0] })
      expect(solver.step(state, 'R270')).to eq({ direction: :n, pos: [0, 0] })
      expect(solver.step(state, 'L270')).to eq({ direction: :s, pos: [0, 0] })
    end
  end

  describe '#step_waypoint' do
    let(:solver) { Day12.new(input) }
    let(:state) do
      {
        waypoint: [10, 1],
        pos: [0, 0]
      }
    end

    it 'update the state accordingly' do
      expect(solver.step_waypoint(state, 'F10')).to eq({ waypoint: [10, 1], pos: [100, 10] })
      expect(solver.step_waypoint(state, 'N3')).to eq({ waypoint: [10, 4], pos: [0, 0] })
      expect(solver.step_waypoint(state, 'E3')).to eq({ waypoint: [13, 1], pos: [0, 0] })
      expect(solver.step_waypoint(state, 'S3')).to eq({ waypoint: [10, -2], pos: [0, 0] })
      expect(solver.step_waypoint(state, 'W3')).to eq({ waypoint: [7, 1], pos: [0, 0] })
      expect(solver.step_waypoint(state, 'R90')).to eq({ waypoint: [1, -10], pos: [0, 0] })
    end
  end

  describe '#execute_waypoint!' do
    let(:solver) { Day12.new(input) }

    it 'moves the ship accordingly' do
      solver.execute_waypoint!
      expect(solver.waypoint).to eq([4, -10])
      expect(solver.pos).to eq([214, -72])
    end
  end

  describe '#part2' do
    let(:solver) { Day12.new(input) }

    it 'moves and calculates manhattan distance' do
      expect(solver.part2).to eq(286)
    end
  end
end
