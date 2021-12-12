# frozen_string_literal: true

class Day12
  attr_reader :connections

  def initialize(input = nil)
    input ||= File.read('inputs/2021/day12')
    @connections = parse_input!(input)
  end

  def part1
    number_of_paths
  end

  def part2
    number_of_complex_paths
  end

  def number_of_paths
    paths.length
  end

  def number_of_complex_paths
    complex_paths.length
  end

  def complex_paths
    complex_path_from('start', Hash.new(0), [], [])
  end

  def complex_path_from(node, visited, path, whole_paths)
    # Only visit once if lowercase
    visited[node] += 1 unless /\A[A-Z]+\z/ =~ node
    path << node

    if node == 'end'
      whole_paths << path.dup
    else
      connections[node].each do |connection|
        next if connection == 'start'
        next if visited[connection] == 1 && visited.values.any? { |v| v > 1 }
        next if visited[connection] > 1

        complex_path_from(connection, visited, path, whole_paths)
      end
    end

    path.pop
    visited[node] -= 1
    whole_paths
  end

  def visited_once_allowed?(visited)
    visited.values.all? { |v| v < 2 }
  end

  def available_connections(node, visited)
    # if any has been visited more than once then it's not available
    used_double = visited.values.any? { |v| v > 1 }

    connections[node].select do |connection|
      if connection == 'start'
        false
      elsif /\A[A-Z]+\z/ =~ connection || connection == 'end' || visited[connection].zero? ||
            (visited[connection] == 1 && !used_double)
        true
      else
        false
      end
    end
  end

  def paths
    path_from('start', {}, [], [])
  end

  def path_from(node, visited, path, whole_paths)
    # Only visit once if lowercase
    visited[node] = true unless /\A[A-Z]+\z/ =~ node
    path << node

    whole_paths << path.dup if node == 'end'

    connections[node].each do |connection|
      next if visited[connection]

      path_from(connection, visited, path, whole_paths)
    end

    path.pop
    visited[node] = false
    whole_paths
  end

  private

  def parse_input!(input)
    input.split("\n").each_with_object({}) do |line, coll|
      from, to = line.split('-')
      coll[from] ? coll[from] << to : coll[from] = [to]
      coll[to] ? coll[to] << from : coll[to] = [from]
    end
  end
end
