# each line consists of '?', '.', '#' characters, followed by a list of numbers
# try to determine the number of possible locations of the '#' in the lines
# where they can be either '#' or in '?' blocks

def process_string(string)
  out = string.squeeze('.')
  out.delete_prefix!('.')
  out.chomp!('.')
  out
end

def calculate_options_distinct_groups(array, indicies)
  options = 1
  indicies.each_with_index { |num, idx|
    next if array[idx].length == num
    options = options * (array[idx].length - num + 1)
  }

  # p "array #{array.to_s}, indicies #{indicies}, options: #{options}"
  options
end

def parse_input(input)
  options = 0
  File.foreach(input) { |line|
    arr = line.split(' ')
    inventory = process_string(arr[0])
    indexes = arr[1].split(',').map { |num| num.to_i}
    count = indexes.reduce(0) { |x, i| x + i}

    # trivial case, where after simplifying the string, there is only as
    # many spots as there are indexes plus spaces
    if inventory.length == indexes.length - 1 + count
      # p "#{line} trivial case, +1"
      options += 1
      next
    end

    # more challenging cases
    # split inventory on '.'
    inventory_array = inventory.split('.')

    # if number of groups match number of indexes, there are descrete groups
    if inventory_array.length == indexes.length
      options += calculate_options_distinct_groups(inventory_array, indexes)
      next
    end

    p "still unsolved: #{line}"
  }
  options
end

def part_1(input)
  options = parse_input(input)
  p options
end

part_1('test')
