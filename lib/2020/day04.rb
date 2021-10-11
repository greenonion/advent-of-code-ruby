require 'set'

class Day04
  attr_reader :input

  def initialize(input = nil)
    input ||= File.read('inputs/2020/day4')
    @input = input
  end

  def part1
    passports.count { |passport| valid?(passport) }
  end

  def part2
    passports.count { |passport| valid_strict?(passport) }
  end

  def passports
    @passports ||= input.split("\n\n").map { |p| str_to_passport(p) }
  end

  def str_to_passport(passport)
    passport.split.map do |pair|
      k, v = pair.split(':')
      [k.to_sym, v]
    end.to_h
  end

  def valid?(passport)
    fields = Set.new([:byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid])
    fields.subset?(Set.new(passport.keys))
  end

  def valid_strict?(passport)
    valid?(passport) &&
      valid_byr?(passport[:byr]) &&
      valid_iyr?(passport[:iyr]) &&
      valid_eyr?(passport[:eyr]) &&
      valid_hgt?(passport[:hgt]) &&
      valid_hcl?(passport[:hcl]) &&
      valid_ecl?(passport[:ecl]) &&
      valid_pid?(passport[:pid])
  end

  def valid_byr?(byr)
    return false unless /^\d{4}$/.match?(byr)
    byr = byr.to_i
    byr > 1919 && byr < 2003
  end

  def valid_iyr?(iyr)
    return false unless /^\d{4}$/.match?(iyr)
    iyr = iyr.to_i
    iyr > 2009 && iyr < 2021
  end

  def valid_eyr?(eyr)
    return false unless /^\d{4}$/.match?(eyr)
    eyr = eyr.to_i
    eyr > 2019 && eyr < 2031
  end

  def valid_hgt?(hgt)
    data = /^(\d{2,3})(in|cm)$/.match(hgt)
    return false unless data

    num = data[1].to_i
    scale = data[2]

    if scale == 'in'
      num > 58 && num < 77
    else
      num > 149 && num < 194
    end
  end

  def valid_hcl?(hcl)
    /^#[0-9a-f]{6}$/.match?(hcl)
  end

  def valid_ecl?(ecl)
    Set.new(['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth']).include?(ecl)
  end

  def valid_pid?(pid)
    /^\d{9}$/.match?(pid)
  end
end
