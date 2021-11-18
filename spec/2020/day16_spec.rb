# frozen_string_literal: true

require 'rspec'
require '2020/day16'

describe 'Day 16' do
  let(:input) do
      <<~TXT
        class: 1-3 or 5-7
        row: 6-11 or 33-44
        seat: 13-40 or 45-50

        your ticket:
        7,1,14

        nearby tickets:
        7,3,47
        40,4,50
        55,2,20
        38,6,12
      TXT
  end

  let(:solver) { Day16.new(input) }

  describe '#probable_field_name_indexes' do
    it 'orders field name indexes by most restrictive to less' do
      expect(solver.probable_field_name_indexes).to eq([1, 2, 0])
    end

    context 'with different input' do
      let(:input) do
        <<~TXT
          class: 0-1 or 4-19
          row: 0-5 or 8-19
          seat: 0-13 or 16-19

          your ticket:
          11,12,13

          nearby tickets:
          3,9,18
          15,1,5
          5,14,9
        TXT
      end

      it 'orders field name indexes by most restrictive to less' do
        expect(solver.probable_field_name_indexes).to eq([2, 0, 1])
      end
    end
  end

  describe '#possible_field_count' do
    it 'returns the number of positions completely satisfying a field' do
      expect(solver.possible_field_count('class')).to eq(2)
      expect(solver.possible_field_count('row')).to eq(1)
      expect(solver.possible_field_count('seat')).to eq(1)
    end

    context 'with different input' do
      let(:input) do
        <<~TXT
          class: 0-1 or 4-19
          row: 0-5 or 8-19
          seat: 0-13 or 16-19

          your ticket:
          11,12,13

          nearby tickets:
          3,9,18
          15,1,5
          5,14,9
        TXT
      end

      it 'returns the number of positions completely satisfying a field' do
        expect(solver.possible_field_count('class')).to eq(2)
        expect(solver.possible_field_count('row')).to eq(3)
        expect(solver.possible_field_count('seat')).to eq(1)
      end
    end
  end

  describe '#nearby_tickets' do
    it 'returns the values for the nearby tickets' do
      expect(solver.nearby_tickets).to eq([[7, 3, 47], [40, 4, 50], [55, 2, 20], [38, 6, 12]])
    end
  end

  describe '#ticket' do
    it 'returns our ticket' do
      expect(solver.ticket).to match_array([7, 1, 14])
    end
  end

  describe '#rules' do
    it 'returns the rules as lambdas' do
      rules = solver.rules.values
      expect(rules[0].call(7)).to be(true)
      expect(rules[1].call(4)).to be(false)
      expect(rules[2].call(42)).to be(false)
    end
  end

  describe '#invalid_ticket_values' do
    it 'returns the invalid values of a ticket according to the rules' do
      expect(solver.invalid_ticket_values([7, 3, 47])).to eq([])
      expect(solver.invalid_ticket_values([40, 4, 50])).to match_array([4])
      expect(solver.invalid_ticket_values([55, 2, 20])).to match_array([55])
      expect(solver.invalid_ticket_values([38, 6, 12])).to match_array([12])
    end
  end

  describe '#part1' do
    it 'adds all invalid values of the nearby tickets' do
      expect(solver.part1).to eq(71)
    end
  end

  describe '#valid_ticket?' do
    it 'checks whether the ticket does not have any invalid values' do
      expect(solver.valid_ticket?([7, 3, 47])).to be(true)
      expect(solver.valid_ticket?([40, 4, 50])).to be(false)
      expect(solver.valid_ticket?([55, 2, 20])).to be(false)
      expect(solver.valid_ticket?([38, 6, 12])).to be(false)
    end
  end

  describe '#valid_nearby_tickets' do
    it 'returns the nearby tickets that do not have any invalid values' do
      expect(solver.valid_nearby_tickets).to match_array([[7, 3, 47]])
    end

    context 'with different input' do
      let(:input) do
        <<~TXT
          class: 0-1 or 4-19
          row: 0-5 or 8-19
          seat: 0-13 or 16-19

          your ticket:
          11,12,13

          nearby tickets:
          3,9,18
          15,1,5
          5,14,9
        TXT
      end

      it 'returns the nearby tickets that do not have any invalid values' do
        expect(solver.valid_nearby_tickets).to match_array([[3, 9, 18], [15, 1, 5], [5, 14, 9]])
      end
    end
  end

  describe '#satisfied?' do
    it 'checks whether a rules is satisfied by all values in a position' do
      expect(solver.satisfied?(0, 0)).to be(true)
      expect(solver.satisfied?(0, 1)).to be(true)
      expect(solver.satisfied?(0, 2)).to be(false)

      expect(solver.satisfied?(1, 0)).to be(true)
      expect(solver.satisfied?(1, 1)).to be(false)
      expect(solver.satisfied?(1, 2)).to be(false)

      expect(solver.satisfied?(2, 0)).to be(false)
      expect(solver.satisfied?(2, 1)).to be(false)
      expect(solver.satisfied?(2, 2)).to be(true)
    end
  end

  describe '#field_order' do
    it 'returns the order of the fields' do
      expect(solver.field_order).to eq([1, 0, 2])
    end

    context 'with different input' do
      let(:input) do
        <<~TXT
          class: 0-1 or 4-19
          row: 0-5 or 8-19
          seat: 0-13 or 16-19

          your ticket:
          11,12,13

          nearby tickets:
          3,9,18
          15,1,5
          5,14,9
        TXT
      end

      it 'returns the order of the fields' do
        expect(solver.field_order).to eq([1, 0, 2])
      end
    end
  end

  describe '#ticket_value' do
    it 'returns the value of the ticket for a field' do
      expect(solver.ticket_value('class')).to eq(1)
      expect(solver.ticket_value('row')).to eq(7)
      expect(solver.ticket_value('seat')).to eq(14)
    end

    context 'with different input' do
      let(:input) do
        <<~TXT
          class: 0-1 or 4-19
          row: 0-5 or 8-19
          seat: 0-13 or 16-19

          your ticket:
          11,12,13

          nearby tickets:
          3,9,18
          15,1,5
          5,14,9
        TXT
      end

      it 'returns the value of the ticket for a field' do
        expect(solver.ticket_value('class')).to eq(12)
        expect(solver.ticket_value('row')).to eq(11)
        expect(solver.ticket_value('seat')).to eq(13)
      end
    end
  end

  describe '#ticket_prefix_value' do
    it 'returns the values of the ticket for a field prefix' do
      expect(solver.ticket_prefix_value('cla')).to eq([1])
      expect(solver.ticket_prefix_value('r')).to eq([7])
      expect(solver.ticket_prefix_value('seat')).to eq([14])
    end

    context 'with different input' do
      let(:input) do
        <<~TXT
          class: 0-1 or 4-19
          row: 0-5 or 8-19
          seat: 0-13 or 16-19

          your ticket:
          11,12,13

          nearby tickets:
          3,9,18
          15,1,5
          5,14,9
        TXT
      end

      it 'returns the values of the ticket for a field prefix' do
        expect(solver.ticket_prefix_value('cla')).to eq([12])
        expect(solver.ticket_prefix_value('r')).to eq([11])
        expect(solver.ticket_prefix_value('seat')).to eq([13])
      end
    end
  end
end
