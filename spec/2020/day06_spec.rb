# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/2020/day06'

RSpec.describe 'Day 6' do
  describe '#group_all_yes' do
    let(:solver) { Day06.new(nil) }
    let(:answers1) do
      <<~TXT
        abcx
        abcy
        abcz
      TXT
    end

    let(:answers2) do
      <<~TXT
        abc
      TXT
    end

    let(:answers3) do
      <<~TXT
        a
        b
        c
      TXT
    end

    let(:answers4) do
      <<~TXT
        ab
        ac
      TXT
    end

    let(:answers5) do
      <<~TXT
        a
        a
        a
        a
      TXT
    end

    let(:answers6) do
      <<~TXT
        b
      TXT
    end

    it 'counts the number of questions to each anyone answered yes' do
      expect(solver.group_all_yes(answers1)).to eq(3)
      expect(solver.group_all_yes(answers2)).to eq(3)
      expect(solver.group_all_yes(answers3)).to eq(0)
      expect(solver.group_all_yes(answers4)).to eq(1)
      expect(solver.group_all_yes(answers5)).to eq(1)
      expect(solver.group_all_yes(answers6)).to eq(1)
    end
  end

  describe '#group_yes' do
    let(:solver) { Day06.new(nil) }
    let(:answers1) do
      <<~TXT
        abcx
        abcy
        abcz
      TXT
    end

    let(:answers2) do
      <<~TXT
        abc
      TXT
    end

    let(:answers3) do
      <<~TXT
        a
        b
        c
      TXT
    end

    let(:answers4) do
      <<~TXT
        ab
        ac
      TXT
    end

    let(:answers5) do
      <<~TXT
        a
        a
        a
        a
      TXT
    end

    let(:answers6) do
      <<~TXT
        b
      TXT
    end

    it 'counts the number of questions to each anyone answered yes' do
      expect(solver.group_yes(answers1)).to eq(6)
      expect(solver.group_yes(answers2)).to eq(3)
      expect(solver.group_yes(answers3)).to eq(3)
      expect(solver.group_yes(answers4)).to eq(3)
      expect(solver.group_yes(answers5)).to eq(1)
      expect(solver.group_yes(answers6)).to eq(1)
    end
  end

  describe '#person_yes' do
    let(:solver) { Day06.new(nil) }

    it 'puts all yes answers into a set' do
      expect(solver.person_yes('abc')).to eq(Set.new(['a', 'b', 'c']))
    end
  end
end
