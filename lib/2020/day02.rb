class Day02
  attr_reader :list

  def initialize(list = nil)
    list ||= File.read('inputs/2020/day2')
    @list = list
  end

  def part1
    list.split("\n").reduce(0) { |sum, entry| valid?(entry) ? sum + 1 : sum }
  end

  def part2
    list.split("\n").reduce(0) { |sum, entry| valid_new?(entry) ? sum + 1 : sum }
  end

  def data(entry)
    /(\d+)-(\d+) (.): (.+)/.match(entry)
  end

  def valid?(entry)
    parsed = data(entry)
    return false unless parsed

    from = parsed[1].to_i
    to = parsed[2].to_i
    letter = parsed[3]
    password = parsed[4]

    occs = password.chars.reduce(0) do |sum, c|
      c == letter ? sum + 1 : sum
    end

    from <= occs && occs <= to
  end

  def valid_new?(entry)
    parsed = data(entry)
    return false unless parsed

    pos1 = parsed[1].to_i - 1
    pos2 = parsed[2].to_i - 1
    letter = parsed[3]
    password = parsed[4]

    (password[pos1] == letter) ^ (password[pos2] == letter)
  end
end
