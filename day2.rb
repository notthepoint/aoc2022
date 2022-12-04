#!/usr/bin/ruby

class Round
  @@points = {"win": 6, "draw": 3, "lose": 0, "rock": 1, "paper": 2, "scissors": 3}
  @@result = :unplayed

  attr_accessor :moveA, :moveB

  def initialize(a, b, partTwo)
    @moveA = {A: :rock, B: :paper, C: :scissors}[a.to_sym]
    if partTwo
      @result = {X: :lose, Y: :draw, Z: :win}[b.to_sym]
      @moveB = desiredMoveB
    else
      @moveB = {X: :rock, Y: :paper, Z: :scissors}[b.to_sym]
      @result = playerBResult
    end
  end

  def playerBResult
    res = :lose

    if @moveA == @moveB
      res = :draw
    elsif @moveA == :rock
      res =  :win if @moveB == :paper
    elsif @moveA == :paper
      res = :win if @moveB == :scissors
    else
      res = :win if @moveB == :rock
    end

    return res
  end

  def desiredMoveB
    if @result == :draw
      return @moveA
    elsif @result == :win
      if @moveA == :rock
        return :paper
      elsif @moveA == :paper
        return :scissors
      else
        return :rock
      end
    else
      if @moveA == :rock
        return :scissors
      elsif @moveA == :paper
        return :rock
      else
        return :paper
      end
    end
  end

  def playerBScore
    @@points[@result] + @@points[@moveB]
  end
end

def dayTwo
  file = File.open("inputs/day2.txt")
  lines = file.readlines.map(&:chomp)

  score = 0

  for line in lines do
    round = Round.new(*line.split, true)
    score += round.playerBScore
  end

  return score
end

# whats my score?
print dayTwo()
