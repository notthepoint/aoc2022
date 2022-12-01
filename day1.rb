#!/usr/bin/ruby

class Elf
  attr_accessor :food

  def initialize
    @food = []
  end

  def totalCalories
    @food.sum
  end
end

def dayOne()
  file = File.open("inputs/day1.txt")
  lines = file.readlines.map(&:chomp)

  index = 0
  elves = [Elf.new]


  for line in lines do
    if line == ""
      index += 1
      elves[index] = Elf.new
    else 
      elf = elves[index] 
      elf.food = elf.food.append(line.to_i)
    end
  end
    
  elves.map(&:totalCalories).sort.reverse[0..2].sum
end

answer = dayOne()
print answer

