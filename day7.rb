#!/usr/bin/ruby

class Tree
  attr_accessor :root

  def initialize(root)
    @root = root
  end

  def dir_sizes
    total, descendents = @root.size
  end

  def sizes_part_one 
    total, descendents = @root.size
    return descendents.select{ |d| d <= 100000 }.sum
  end
end

class Node
  attr_accessor :name
end

class Directory < Node
  attr_accessor :children, :parent

  def initialize(name, parent)
    @name = name
    @children = []
    @parent = parent
  end

  def files
    children.select{ |c| c.is_a?(ElfFile) }
  end

  def directories
    children.select{ |c| c.is_a?(Directory) }
  end

  def size
    # e.g. [[1,[]], [2,[]], [3,[]]
    # returns 6, [6]
    # e.g. [[6, [6]], [5, [5]]]
    # returns [11, [6, 5, 11]]
    # e.g [11, [6,5,11]], [12, [5,4]]
    # returns 23, [6,5,11,5,4,23]
    sizes = children.map(&:size) # [[int, []], [int, [int, int]]]

    total = sizes.map(&:first).sum # int
    parts = sizes.map(&:last).map(&:compact).flatten # [int, int]

    # i want to append my size to all the sizes
    return total, parts.append(total)
  end
end

class ElfFile < Node
  attr_accessor :size

  def initialize(name, size)
    @name = name
    @size = size.to_i
  end

  def size
    return @size, []
  end
end



def parse_line(tree, current_node, line)
  if line.start_with?("$ cd")
    change_directory(tree, current_node, line)
  elsif line.start_with?("$ ls")
    return current_node
  else
    # add child
    new_child = new_child(current_node, line)
    current_node.children.append(new_child)
    return current_node
  end
end

def new_child(current_node, line)
  info, name = line.split(' ')
  if info == "dir"
    return Directory.new(name, current_node)
  else
    return ElfFile.new(name, info.to_i)
  end
end

def change_directory(tree, current_node, line)
  pattern = /\$ cd (.*)/
  move_to = line.match(pattern).captures[0]

  case move_to
  when ".."
    return current_node.parent
  when "/"
    return tree.root
  else
    return current_node.children.find{ |n| n.name == move_to }
  end
end

def daySeven
  file = File.open("inputs/day7.txt")
  lines = file.readlines.map(&:chomp)

  tree = Tree.new(Directory.new("/", nil))
  current_node = tree.root

  for line in lines do
    current_node = parse_line(tree, current_node, line)
  end

  space_required = 30000000
  total_available = 70000000

  total_used, dir_sizes = tree.dir_sizes
  extra_space_required = space_required - (total_available - total_used)
  puts "Space required: #{extra_space_required}"

  smaller_dir_to_delete = total_available
  for dir_size in dir_sizes do
    if dir_size >= extra_space_required && dir_size < smaller_dir_to_delete
      smaller_dir_to_delete = dir_size
    end
  end

  return tree.sizes_part_one, smaller_dir_to_delete
end

print daySeven
