#!/usr/bin/ruby

class Assignment
  attr_accessor :sections, :max, :min

  def initialize(range)
    @min, @max = range.split('-')[0].to_i, range.split('-')[-1].to_i
    @sections = [*min..max]
  end

  def fully_contains?(assignment)
    @min <= assignment.min && @max >= assignment.max
  end

  def overlap?(assignment)
    @min <= assignment.min && @max >= assignment.min ||
      @max >= assignment.max && @min <= assignment.max ||
      @min > assignment.min && @max < assignment.max # contained within
  end
end


def dayFour
  file = File.open("inputs/day4.txt")
  lines = file.readlines.map(&:chomp)

  score = 0
  scoreTwo = 0

  index = 0

  for line in lines do
    a, b = line.split(',')
    assigmentA = Assignment.new(a)
    assigmentB = Assignment.new(b)
    
    score += 1 if assigmentA.fully_contains?(assigmentB) || assigmentB.fully_contains?(assigmentA)
    scoreTwo += 1 if assigmentA.overlap?(assigmentB)
  end

  return score, scoreTwo
end

print dayFour()
