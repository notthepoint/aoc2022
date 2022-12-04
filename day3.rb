#!/usr/bin/ruby
require 'set'

class Group
  attr_accessor :members

  def initialize(threelines)
    @members = []
    for line in threelines
      rucksack = Rucksack.new(line)
      @members.append(rucksack)
    end
  end

  def badge
    (@members[0].items & @members[1].items & @members[2].items).to_a[0]
  end

  def badge_value
    Rucksack.value(badge)
  end
end

class Rucksack

  attr_accessor :items
  attr_accessor :first_compartment
  attr_accessor :second_compartment

  def initialize(line)
    @items = line.split('')
    @first_compartment, @second_compartment = items.each_slice( (items.size/2.0).round ).to_a
  end

  def self.value(item)
    byte = item.bytes[0]
    if 97 <= byte && byte <= 122
      return byte - 96
    else
      return byte - 38
    end
  end

  def wrong_item
    (@first_compartment.to_set & @second_compartment.to_set).to_a[0]
  end

  def wrong_item_value
    self.class.value(wrong_item)
  end
end


def dayThree
  file = File.open("inputs/day3.txt")
  lines = file.readlines.map(&:chomp)

  score = 0

  for line in lines do
    rucksack = Rucksack.new(line)
    score += rucksack.wrong_item_value
  end

  scoreTwo = 0

  lines.each_slice(3) do |lines|
    group = Group.new(lines)
    scoreTwo += group.badge_value
  end

  return score, scoreTwo
end

print dayThree()

