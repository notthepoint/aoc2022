#!/usr/bin/ruby

def dayFour
  file = File.open("inputs/day5.txt")
  lines = file.readlines.map(&:chomp)

  stacks = Array.new(9, [])

  stack_lines = lines[0..7]
  move_lines = lines[10..-1]

  # prepare stacks
  for line in stack_lines do
    char_locations = (1..33).step(4).to_a

    9.times do |index|
      char = line[char_locations[index]]
      if char != " "
        puts char
        stacks[index] = [char] + stacks[index]
      end
    end
  end

  # move stacks
  for line in move_lines do
    format = /move\s(\d+)\sfrom\s(\d)\sto\s(\d)/
    moves = line.match(format).captures.map(&:to_i)

    # first part
    #moves[0].times do
    #  crate = stacks[moves[1] - 1].pop
    #  stacks[moves[2] - 1].append(crate)
    #end

    # second part
    crates = stacks[moves[1] - 1].slice!(-moves[0], moves[0])
    stacks[moves[2] - 1].concat(crates)
  end

  return stacks.map(&:last).join
end

print dayFour()
