class Runner
  attr_reader :year, :day, :part

  def initialize(year, day, part)
    @year = year
    @day = day
    @part = part.to_i
  end

  def solve!
    puts "Solving part #{part} of year #{year} and day #{day}"
    require_relative "#{year}/day#{day}"

    solver = Object.const_get("Day#{day}").new
    if part == 1
      puts solver.part1
    else
      puts solver.part2
    end
  end
end
