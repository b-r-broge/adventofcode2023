$boxes = {}
for num in 0..255 do
  $boxes[num] = []
end

def calculate_hash(string)
  hash_value = 0
  string.split('').each { |char|
    hash_code = char.ord + hash_value
    hash_value = (hash_code * 17) % 256
  }
  hash_value
end

def remove_lense(string)
  val = string.chomp('-')
  box = calculate_hash(val)

  idx = -1
  $boxes[box].each_with_index { |lense, index|
    idx = index if lense.include?(val)
  }

  $boxes[box].delete_at(idx) if idx >= 0
end

def add_lense(string)
  val, lense_value = string.split('=')
  box = calculate_hash(val)

  # check if the val already exists in the box
  idx = -1
  $boxes[box].each_with_index { |lense, index|
    idx = index if lense.include?(val)
  }

  # if index is found
  if idx >= 0
    $boxes[box][idx] = string
    return
  end

  #if index is not found
  $boxes[box].push(string)
end

def parse_input(input)
  File.foreach(input) { |line|
    arr = line.chomp.split(',')
    arr.each { |str|
      remove_lense(str) if str.include?('-')
      add_lense(str) if str.include?('=')
    }
  }
  $boxes
end

def part_2
  input = "input"
  parse_input(input)
  p $boxes
  out = 0
  for box in 0..255
    $boxes[box].each_with_index { |lense, index|
      focal_length = lense.split('=')[1].to_i
      add = ((box + 1) * (index + 1) * focal_length)
      p add
      out += add
    }
    # p "box #{box} is #{$boxes[box]}, out is now #{out}"
  end
  p out
end

part_2
