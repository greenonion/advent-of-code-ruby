require 'spec_helper'
require_relative '../../lib/2020/day04'

RSpec.describe 'Day 4' do
  let(:input) do
    <<~TXT
       ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
       byr:1937 iyr:2017 cid:147 hgt:183cm

       iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
       hcl:#cfa07d byr:1929

       hcl:#ae17e1 iyr:2013
       eyr:2024
       ecl:brn pid:760753108 byr:1931
       hgt:179cm

       hcl:#cfa07d eyr:2025 pid:166559648
       iyr:2011 ecl:brn hgt:59in
    TXT
  end

  context 'Part One' do
    let(:solver) { Day04.new(input) }

    describe '#passports' do
      it 'returns all passports in the input' do
        expect(solver.passports.length).to eq(4)
      end
    end

    describe '#str_to_passport' do
      let(:passportstr1) do
        <<~TXT
           ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
           byr:1937 iyr:2017 cid:147 hgt:183cm
        TXT
      end

      it 'parses a passport from a string' do
        passport = {
          ecl: 'gry', pid: '860033327', eyr: '2020', hcl: '#fffffd',
          byr: '1937', iyr: '2017', cid: '147', hgt: '183cm'
        }

        expect(solver.str_to_passport(passportstr1)).to eq(passport)
      end
    end

    describe '#valid?' do
      let(:passport1) do
        {
          ecl: 'gry', pid: '860033327', eyr: '2020', hcl: '#fffffd',
          byr: '1937', iyr: '2017', cid: '147', hgt: '183cm'
        }
      end

      let(:passport2) do
        {
          iyr: '2013', ecl: 'amb', cid: '350', eyr: '2023', pid: '028048884',
          hcl: '#cfa07d', byr: '1929'
        }
      end

      it 'validates passwords' do
        expect(solver.valid?(passport1)).to be(true)
        expect(solver.valid?(passport2)).to be(false)
      end
    end

    describe '#part1' do
      it 'counts the number of valid passwords' do
        expect(solver.part1).to eq(2)
      end
    end
  end

  context 'Part Two' do
    let(:solver) { Day04.new(input) }

    describe '#valid_byr?' do
      it 'validates byr field' do
        expect(solver.valid_byr?('ad12')).to be(false)
        expect(solver.valid_byr?('1919')).to be(false)
        expect(solver.valid_byr?('1920')).to be(true)
        expect(solver.valid_byr?('2002')).to be(true)
        expect(solver.valid_byr?('2003')).to be(false)
      end
    end

    describe '#valid_iyr?' do
      it 'validates iyr field' do
        expect(solver.valid_iyr?('ad12')).to be(false)
        expect(solver.valid_iyr?('2009')).to be(false)
        expect(solver.valid_iyr?('2010')).to be(true)
        expect(solver.valid_iyr?('2020')).to be(true)
        expect(solver.valid_iyr?('2021')).to be(false)
      end
    end

    describe '#valid_eyr?' do
      it 'validates eyr field' do
        expect(solver.valid_eyr?('ad12')).to be(false)
        expect(solver.valid_eyr?('2019')).to be(false)
        expect(solver.valid_eyr?('2020')).to be(true)
        expect(solver.valid_eyr?('2030')).to be(true)
        expect(solver.valid_eyr?('2031')).to be(false)
      end
    end

    describe '#valid_hgt?' do
      it 'validates hgt field' do
        expect(solver.valid_hgt?('ad12')).to be(false)
        expect(solver.valid_hgt?('190in')).to be(false)
        expect(solver.valid_hgt?('60in')).to be(true)
        expect(solver.valid_hgt?('190cm')).to be(true)
        expect(solver.valid_hgt?('190')).to be(false)
      end
    end

    describe '#valid_hcl?' do
      it 'validates hcl field' do
        expect(solver.valid_hcl?('#123abc')).to be(true)
        expect(solver.valid_hcl?('#123abz')).to be(false)
        expect(solver.valid_hcl?('123abc')).to be(false)
      end
    end

    describe '#valid_ecl?' do
      it 'validates ecl field' do
        expect(solver.valid_ecl?('brn')).to be(true)
        expect(solver.valid_ecl?('wat')).to be(false)
      end
    end

    describe '#valid_pid?' do
      it 'validates pid field' do
        expect(solver.valid_pid?('000000001')).to be(true)
        expect(solver.valid_pid?('0123456789')).to be(false)
      end
    end

    describe '#valid_strict?' do
      context 'invalid passwords' do
        let(:pass1) do
          <<~TXT
             eyr:1972 cid:100
             hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926
          TXT
        end

        let(:pass2) do
          <<~TXT
             iyr:2019
             hcl:#602927 eyr:1967 hgt:170cm
             ecl:grn pid:012533040 byr:1946
          TXT
        end

        let(:pass3) do
          <<~TXT
             hcl:dab227 iyr:2012
             ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277
          TXT
        end

        let(:pass4) do
          <<~TXT
             hgt:59cm ecl:zzz
             eyr:2038 hcl:74454a iyr:2023
             pid:3556412378 byr:2007
          TXT
        end

        it 'validates a passport strictly' do
          pss1 = solver.str_to_passport(pass1)
          pss2 = solver.str_to_passport(pass2)
          pss3 = solver.str_to_passport(pass3)
          pss4 = solver.str_to_passport(pass4)

          expect(solver.valid_strict?(pss1)).to be(false)
          expect(solver.valid_strict?(pss2)).to be(false)
          expect(solver.valid_strict?(pss3)).to be(false)
          expect(solver.valid_strict?(pss4)).to be(false)
        end
      end

      context 'valid passports' do
        let(:pass1) do
          <<~TXT
             pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980
             hcl:#623a2f
          TXT
        end

        let(:pass2) do
          <<~TXT
             eyr:2029 ecl:blu cid:129 byr:1989
             iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm
          TXT
        end

        let(:pass3) do
          <<~TXT
             hcl:#888785
             hgt:164cm byr:2001 iyr:2015 cid:88
             pid:545766238 ecl:hzl
             eyr:2022
          TXT
        end

        let(:pass4) do
          <<~TXT
           iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719
          TXT
        end

        it 'validates a passport strictly' do
          pss1 = solver.str_to_passport(pass1)
          pss2 = solver.str_to_passport(pass2)
          pss3 = solver.str_to_passport(pass3)
          pss4 = solver.str_to_passport(pass4)

          expect(solver.valid_strict?(pss1)).to be(true)
          expect(solver.valid_strict?(pss2)).to be(true)
          expect(solver.valid_strict?(pss3)).to be(true)
          expect(solver.valid_strict?(pss4)).to be(true)
        end
      end
    end
  end
end
