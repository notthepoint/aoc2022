
#!/usr/bin/ruby

def visible?(trees, tree)
  must_be_less_than = tree

  trees.each_with_index do |other_tree, index|
    if other_tree >= tree
      return false
    end
  end
  
  return true
end

def edge?(trees, col_i, row_i)
  col_i == 0 || row_i == 0 ||
    col_i == (trees.length - 1) || row_i == (trees[0].length - 1)
end

def part_one(trees)
  visible_tree_count = 0

  trees.each_with_index do |row, col_i|
    row.each_with_index do |tree, row_i|

      #is this a row?
      if edge?(trees, col_i, row_i)
        visible_tree_count += 1
      else
        # else
        # look left, look right, look up, look down
        visibility = [
          visible?(row[0,row_i].reverse, tree), # to the left
          visible?(row[row_i+1, row.length], tree), # to the right
          visible?(trees[0,col_i].map { |row| row[row_i] }.reverse, tree), # go upwards
          visible?(trees[col_i+1, trees.length].map{ |row| row[row_i]}, tree) # go downwards
        ]

        visible_tree_count += 1 if visibility.any?{ |v| v == true }
      end
    end
  end

  return visible_tree_count
end

def visible_trees(trees, tree)
  count = 0

  trees.each_with_index do |other_tree, index|
    if other_tree >= tree
      return count + 1
    else
      count += 1
    end
  end
  
  return count
end

def part_two(trees)
  best_view = 0

  trees.each_with_index do |row, col_i|
    row.each_with_index do |tree, row_i|
        sight_count = [
          visible_trees(row[0,row_i].reverse, tree), # to the left
          visible_trees(row[row_i+1, row.length], tree), # to the right
          visible_trees(trees[0,col_i].map { |row| row[row_i] }.reverse, tree), # go upwards
          visible_trees(trees[col_i+1, trees.length].map{ |row| row[row_i]}, tree) # go downwards
        ].reduce(:*)

        if sight_count > best_view
          best_view = sight_count
        end
    end
  end

  return best_view
end


def dayEight
  file = File.open("inputs/day8.txt")
  lines = file.readlines.map(&:chomp)

  trees = []
  for line in lines do
    trees.append(line.split('').map(&:to_i))
  end

  return part_one(trees), part_two(trees)
end

print dayEight
