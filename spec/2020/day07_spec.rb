# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/2020/day07'

RSpec.describe 'Day 7' do
  let(:input) do
    <<~TXT
      light red bags contain 1 bright white bag, 2 muted yellow bags.
      dark orange bags contain 3 bright white bags, 4 muted yellow bags.
      bright white bags contain 1 shiny gold bag.
      muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
      shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
      dark olive bags contain 3 faded blue bags, 4 dotted black bags.
      vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
      faded blue bags contain no other bags.
      dotted black bags contain no other bags.
    TXT
  end

  let(:input2) do
    <<~TXT
      shiny gold bags contain 2 dark red bags.
      dark red bags contain 2 dark orange bags.
      dark orange bags contain 2 dark yellow bags.
      dark yellow bags contain 2 dark green bags.
      dark green bags contain 2 dark blue bags.
      dark blue bags contain 2 dark violet bags.
      dark violet bags contain no other bags.
    TXT
  end

  describe '#bags_nested' do
    let(:solver) { Day07.new(input) }
    let(:solver2) { Day07.new(input2) }

    it 'returns the number of nested bags' do
      expect(solver.bags_nested('faded blue')).to eq(0)
      expect(solver.bags_nested('vibrant plum')).to eq(11)
      expect(solver.bags_nested('shiny gold')).to eq(32)
      expect(solver2.bags_nested('shiny gold')).to eq(126)
    end
  end

  describe '#carry' do
    let(:solver) { Day07.new(input) }

    it 'returns the number of bag types that can carry another' do
      expect(solver.carry('shiny gold')).to eq(4)
      expect(solver.carry('muted yellow')).to eq(2)
      expect(solver.carry('faded blue')).to eq(7)
      expect(solver.carry('bright white')).to eq(2)
    end
  end

  describe '#containers' do
    let(:solver) { Day07.new(input) }
    let(:rules) do
      {
        'light red' => { 'bright white' => 1, 'muted yellow' => 2 },
        'dark orange' => { 'bright white' => 3, 'muted yellow' => 4 },
        'bright white' => { 'shiny gold' => 1 },
        'muted yellow' => { 'shiny gold' => 2, 'faded blue' => 9 },
        'shiny gold' => { 'dark olive' => 1, 'vibrant plum' => 2 },
        'dark olive' => { 'faded blue' => 3, 'dotted black' => 4 },
        'vibrant plum' => { 'faded blue' => 5, 'dotted black' => 6 },
        'faded blue' => {},
        'dotted black' => {}
      }
    end
    let(:containers) do
      {
        'bright white' => ['light red', 'dark orange'],
        'muted yellow' => ['light red', 'dark orange'],
        'shiny gold' => ['bright white', 'muted yellow'],
        'faded blue' => ['muted yellow', 'dark olive', 'vibrant plum'],
        'dark olive' => ['shiny gold'],
        'vibrant plum' => ['shiny gold'],
        'dotted black' => ['dark olive', 'vibrant plum']
      }
    end

    it 'returns a hash containing all rules' do
      expect(solver.containers).to eq(containers)
    end
  end

  describe '#rules' do
    let(:solver) { Day07.new(input) }
    let(:rules) do
      {
        'light red' => { 'bright white' => 1, 'muted yellow' => 2 },
        'dark orange' => { 'bright white' => 3, 'muted yellow' => 4 },
        'bright white' => { 'shiny gold' => 1 },
        'muted yellow' => { 'shiny gold' => 2, 'faded blue' => 9 },
        'shiny gold' => { 'dark olive' => 1, 'vibrant plum' => 2 },
        'dark olive' => { 'faded blue' => 3, 'dotted black' => 4 },
        'vibrant plum' => { 'faded blue' => 5, 'dotted black' => 6 },
        'faded blue' => {},
        'dotted black' => {}
      }
    end
    it 'returns a hash containing all rules' do
      expect(solver.rules).to eq(rules)
    end
  end

  describe '#rule_from_str' do
    let(:solver) { Day07.new(nil) }

    let(:str1) { 'light red bags contain 1 bright white bag, 2 muted yellow bags.' }
    let(:str2) { 'dark orange bags contain 3 bright white bags, 4 muted yellow bags.' }
    let(:str3) { 'faded blue bags contain no other bags.' }

    it 'parses a string and creates a rule' do
      expect(solver.rule_from_str(str1)).to eq({ 'light red' =>
                                                 { 'bright white' => 1,
                                                   'muted yellow' => 2 } })
      expect(solver.rule_from_str(str2)).to eq({ 'dark orange' =>
                                                 { 'bright white' => 3,
                                                   'muted yellow' => 4 } })
      expect(solver.rule_from_str(str3)).to eq({ 'faded blue' => {} })
    end
  end
end
