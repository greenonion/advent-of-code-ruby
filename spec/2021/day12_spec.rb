# frozen_string_literal: true

require '2021/day12'

def str_to_path(str)
  str.split("\n").map { |line| line.split(',') }
end

describe 'Day 12' do
  let(:input) do
    <<~TXT
      start-A
      start-b
      A-c
      A-b
      b-d
      A-end
      b-end
    TXT
  end

  let(:solver) { Day12.new(input) }

  describe '#number_of_complex_paths' do
    it 'returns the number of possible paths' do
      expect(solver.number_of_complex_paths).to eq(36)
    end

    context 'with a larger input' do
      let(:input) do
        <<~TXT
        dc-end
        HN-start
        start-kj
        dc-start
        dc-HN
        LN-dc
        HN-end
        kj-sa
        kj-HN
        kj-dc
      TXT
      end

      it 'returns the number of possible paths' do
        expect(solver.number_of_complex_paths).to eq(103)
      end
    end

    context 'with a large input' do
      let(:input) do
        <<~TXT
          fs-end
          he-DX
          fs-he
          start-DX
          pj-DX
          end-zg
          zg-sl
          zg-pj
          pj-he
          RW-he
          fs-DX
          pj-RW
          zg-RW
          start-pj
          he-WI
          zg-he
          pj-fs
          start-RW
        TXT
      end

      it 'returns the number of possible paths' do
        expect(solver.number_of_complex_paths).to eq(3509)
      end
    end
  end

  describe '#number_of_paths' do
    context 'with a larger input' do
      let(:input) do
        <<~TXT
        dc-end
        HN-start
        start-kj
        dc-start
        dc-HN
        LN-dc
        HN-end
        kj-sa
        kj-HN
        kj-dc
      TXT
      end

      it 'returns the number of possible paths' do
        expect(solver.number_of_paths).to eq(19)
      end
    end

    context 'with a large input' do
      let(:input) do
        <<~TXT
          fs-end
          he-DX
          fs-he
          start-DX
          pj-DX
          end-zg
          zg-sl
          zg-pj
          pj-he
          RW-he
          fs-DX
          pj-RW
          zg-RW
          start-pj
          he-WI
          zg-he
          pj-fs
          start-RW
        TXT
      end

      it 'returns the number of possible paths' do
        expect(solver.number_of_paths).to eq(226)
      end
    end
  end

  describe '#paths' do
    let(:paths_str) do
      <<~TXT
        start,A,b,A,c,A,end
        start,A,b,A,end
        start,A,b,end
        start,A,c,A,b,A,end
        start,A,c,A,b,end
        start,A,c,A,end
        start,A,end
        start,b,A,c,A,end
        start,b,A,end
        start,b,end
      TXT
    end

    let(:paths) { str_to_path(paths_str) }

    it 'returns all possible paths' do
      expect(solver.paths).to match_array(paths)
    end
  end

  describe '#connections' do
    let(:connections) do
      {
        'start' => ['A', 'b'],
        'A' => ['start', 'c', 'b', 'end'],
        'b' => ['start', 'A', 'd', 'end'],
        'c' => ['A'],
        'd' => ['b'],
        'end' => ['A', 'b']
      }
    end

    it 'returns a hash with all conections from each node' do
      expect(solver.connections).to eq(connections)
    end
  end
end
