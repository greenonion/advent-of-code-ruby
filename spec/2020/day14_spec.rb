# frozen_string_literal: true

require 'rspec'
require '2020/day14'

describe 'Day 14' do
  describe '#part1!' do
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

  describe '#part2!' do
    let(:input) do
      <<~TXT
        mask = 000000000000000000000000000000X1001X
        mem[42] = 100
        mask = 00000000000000000000000000000000X0XX
        mem[26] = 1
      TXT
    end

    let(:solver) { Day14.new(input) }

    it 'executes the program and counts values in memory' do
      expect(solver.part2).to eq(208)
    end
  end


  describe '#run_floating_program!' do
    let(:input) do
      <<~TXT
        mask = 000000000000000000000000000000X1001X
        mem[42] = 100
        mask = 00000000000000000000000000000000X0XX
        mem[26] = 1
      TXT
    end

    let(:solver) { Day14.new(input) }

    it 'runs the whole input program' do
      solver.run_floating_program!
      expect(solver.mask).to eq('00000000000000000000000000000000X0XX')
      expect(solver.memory[58]).to eq(100)
      expect(solver.memory[59]).to eq(100)

      expect(solver.memory[16]).to eq(1)
      expect(solver.memory[17]).to eq(1)
      expect(solver.memory[18]).to eq(1)
      expect(solver.memory[19]).to eq(1)
      expect(solver.memory[24]).to eq(1)
      expect(solver.memory[25]).to eq(1)
      expect(solver.memory[26]).to eq(1)
      expect(solver.memory[27]).to eq(1)
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

  describe '#execute_floating!' do
    let(:solver) { Day14.new }

    context 'when mask' do
      it 'sets mask accordingly' do
        instruction = 'mask = 000000000000000000000000000000X1001X'
        expect { solver.execute_floating!(instruction) }.to change { solver.mask }.from('X' * 36).to('000000000000000000000000000000X1001X')
      end
    end

    context 'when mem' do
      before { solver.mask = '000000000000000000000000000000X1001X' }

      it 'saves the appropriate value to memory' do
        instruction = 'mem[42] = 100'
        solver.execute_floating!(instruction)
        expect(solver.memory[26]).to eq(100)
        expect(solver.memory[27]).to eq(100)
        expect(solver.memory[58]).to eq(100)
        expect(solver.memory[59]).to eq(100)
      end
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

  describe '#unfloat_address' do
    let(:solver) { Day14.new }

    it 'returns the array of possible addresses' do
      expect(solver.unfloat_address('000000000000000000000000000000X1101X')).to match_array([26, 27, 58, 59])
    end

    it 'returns the array of possible addresses' do
      expect(solver.unfloat_address('00000000000000000000000000000001X0XX')).to match_array([16, 17, 18, 19, 24, 25, 26, 27])
    end
  end

  describe '#floating_bits' do
    let(:solver) { Day14.new }

    it 'returns the significant indexes of the floating bits' do
      expect(solver.floating_bits('000000000000000000000000000000X1101X')).to match_array([0, 5])
    end
  end

  describe 'memory_masked' do
    let(:solver) { Day14.new }

    it 'applies the mask to the memory address' do
      expect(solver.memory_masked(42, '000000000000000000000000000000X1001X')).to eq('000000000000000000000000000000X1101X')
    end
  end
end
