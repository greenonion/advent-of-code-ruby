class Day01
  attr_reader :entries

  def initialize(entries = nil)
    entries ||= File.read('inputs/2020/day1')
    @entries = entries.split.map(&:to_i)
  end

  def part1
    (0...entries.size).each do |i|
      (i+1...entries.size).each do |j|
        next unless entries[i] + entries[j] == 2020

        return entries[i] * entries[j]
      end
    end
  end

  def part2
    return 0 unless entries.size > 2

    (0...entries.size).each do |i|
      (i+1...entries.size).each do |j|
        (j+1...entries.size).each do |k|
          next unless entries[i] + entries[j] + entries[k] == 2020
          return entries[i] * entries[j] * entries[k]
        end
      end
    end
  end
end
