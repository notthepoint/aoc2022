#!/usr/bin/ruby

def daySix
  file = File.open("inputs/day6.txt")
  chars = file.read.split('')


  packet_marker_end = -1
  message_marker_end = -1

  chars.each_with_index do |char, index|
    if chars[index, 4].uniq.length == 4 && packet_marker_end < 0
      packet_marker_end = index + 4
    end

    if chars[index, 14].uniq.length == 14 && message_marker_end < 0
      message_marker_end = index + 14
    end
  end

  return packet_marker_end, message_marker_end
end

print daySix()
