# frozen_string_literal: true

require 'pry'
require 'set'

class Day16
  attr_reader :input, :nearby_tickets, :rules, :ticket

  def initialize(input = nil)
    input ||= File.read('inputs/2020/day16')
    @input = input
    parse_input!
  end

  def part1
    nearby_tickets.sum { |ticket| invalid_ticket_values(ticket).sum }
  end

  def part2
    ticket_prefix_value('departure').reduce(:*)
  end

  def valid_nearby_tickets
    @valid_nearby_tickets ||= nearby_tickets.select { |ticket| valid_ticket?(ticket) }
  end

  def valid_ticket?(ticket)
    rule_ranges = rules.values
    ticket.all? do |value|
      rule_ranges.any? { |rule_fn| rule_fn.call(value) }
    end
  end

  def invalid_ticket_values(ticket)
    rule_ranges = rules.values
    ticket.select do |value|
      rule_ranges.all? { |rule_fn| !rule_fn.call(value) }
    end
  end

  def ticket_prefix_value(prefix)
    field_names.select { |name| name.start_with?(prefix) }.map { |name| ticket_value(name) }
  end

  def ticket_value(field_name)
    ticket[field_name_positions[field_name]]
  end

  def field_name_positions
    @field_name_positions ||=
      field_order.each_with_index.each_with_object({}) do |(field_name_index, ticket_index), coll|
        coll[field_names[field_name_index]] = ticket_index
      end
  end

  def field_names
    @field_names ||= rules.keys
  end

  def field_order
    @field_order ||= search([])
  end

  def satisfied?(field_name_index, position)
    field_name = field_name_at(field_name_index)
    valid_values_in_position[position].all? { |value| rules[field_name].call(value) }
  end

  def field_name_at(index)
    field_names[index]
  end

  # Using DFS and propagation, try all possible values
  #
  # values is an array of field name indexes
  def search(values)
    return nil unless values
    return values if solved?(values)

    next_position = values.length

    available_field_name_indexes(values).each do |field_name_index|
      # does this work?
      next unless satisfied?(field_name_index, next_position)

      next_values = values.dup << field_name_index
      search_result = search(next_values)
      return search_result if search_result
    end

    # if we're here, nothing worked
    nil
  end

  def available_field_name_indexes(values)
    probable_field_name_indexes.difference(values)
  end

  # order rules by how many tickets satisfy them (start from the most strict)
  # this will help eliminate whole generations instead of mindlessly repeating them
  def probable_field_name_indexes
    (0...field_names.length).sort_by do |field_name_index|
      possible_field_count(field_name_at(field_name_index))
    end
  end

  def possible_field_count(field_name)
    rule_fn = rules[field_name]
    valid_values_in_position.count { |values| values.all? { |value| rule_fn.call(value) } }
  end

  private

  def solved?(values)
    values.length == field_names.length
  end

  def parse_input!
    rules, ticket, nearby_tickets = input.split("\n\n")
    @rules = rules!(rules)
    @ticket = ticket!(ticket)
    @nearby_tickets = nearby_tickets!(nearby_tickets)
  end

  def ticket!(ticket)
    ticket.split("\n").last.split(',').map(&:to_i)
  end

  def valid_values_in_position
    @valid_values_in_position ||= valid_nearby_tickets.transpose
  end

  def nearby_tickets!(nearby_ticket_notes)
    nearby_ticket_notes.split("\n").drop(1).map { |line| line.split(',').map(&:to_i) }
  end

  def rules!(rules)
    rules.split("\n").each_with_object({}) do |rule, coll|
      name, ranges = rule.split(': ')
      range_a, range_b = ranges.split(' or ').map { |r| r.split('-').map(&:to_i) }

      coll[name] = lambda do |x|
        (x >= range_a[0] && x <= range_a[1]) || (x >= range_b[0] && x <= range_b[1])
      end
    end
  end
end
