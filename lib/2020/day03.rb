class Day03
  attr_reader :input

  def initialize(input = nil)
    input ||= File.read('inputs/2020/day3')
    @input = input.split("\n")
  end

  def part1
    tree_count([3, 1])
  end

  def part2
    tree_count([1, 1]) *
      tree_count([3, 1]) *
      tree_count([5, 1]) *
      tree_count([7, 1]) *
      tree_count([1, 2])
  end

  def tree_count(slope)
    right = slope[0]
    down = slope[1]
    trees = 0
    position = [0, 0]

    until end?(position)
      trees += 1 if tree?(position)
      position = move(position, right, down)
    end

    trees
  end

  def tree?(position)
    x = position[0]
    y = position[1] % length
    input[x][y] == '#'
  end

  def move(position, right, down)
    position[0] += down
    position[1] += right
    position
  end

  def end?(position)
    position[0] >= height
  end

  private

  def length
    @length ||= input[0].length
  end

  def height
    @height ||= input.length
  end
end
