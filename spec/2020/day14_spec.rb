# frozen_string_literal: true

require 'rspec'
require '2020/day14'

describe 'Day 14' do
  describe '#part!' do
    let(:input) do
      <<~TXT
        mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
        mem[8] = 11
        mem[7] = 101
        mem[8] = 0
      TXT
    end

    let(:solver) { Day14.new(input) }

    it 'executes the program and counts values in memory' do
      expect(solver.part1).to eq(165)
    end
  end

  describe '#run_program!' do
    let(:input) do
      <<~TXT
        mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
        mem[8] = 11
        mem[7] = 101
        mem[8] = 0
      TXT
    end

    let(:solver) { Day14.new(input) }

    it 'runs the whole input program' do
      solver.run_program!
      expect(solver.mask).to eq('XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X')
      expect(solver.memory[7]).to eq(101)
      expect(solver.memory[8]).to eq(64)
    end
  end

  describe '#execute!' do
    let(:solver) { Day14.new }

    context 'when mask' do
      it 'sets mask accordingly' do
        instruction = 'mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X'
        expect { solver.execute!(instruction) }.to change { solver.mask }.from('X' * 36).to('XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X')
      end
    end

    context 'when mem' do
      it 'saves the appropriate value to memory' do
        instruction = 'mem[8] = 11'
        expect { solver.execute!(instruction) }.to change { solver.memory[8] }.from(0).to(11)
      end
    end
  end

  describe '#masked' do
    let(:solver) { Day14.new }

    it 'applies a mask to a value' do
      expect(solver.masked(11, 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X')).to eq(73)
      expect(solver.masked(101, 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X')).to eq(101)
      expect(solver.masked(0, 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X')).to eq(64)
    end
  end

  describe '#set' do
    let(:solver) { Day14.new }

    before { solver.mask = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X' }

    it 'sets a value after masking it' do
      solver.set(8, 11)
      expect(solver.memory[8]).to eq(73)
    end

    it 'sets a value after masking it' do
      solver.set(7, 101)
      expect(solver.memory[7]).to eq(101)
    end

    it 'sets a value after masking it' do
      solver.set(8, 0)
      expect(solver.memory[8]).to eq(64)
    end
  end
end
