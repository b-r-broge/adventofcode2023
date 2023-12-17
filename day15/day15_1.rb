def calculate_hash(string)
  hash_value = 0
  string.split('').each { |char|
    hash_code = char.ord + hash_value
    hash_value = (hash_code * 17) % 256
  }
  hash_value
end

def parse_input(input)
  values = []
  File.foreach(input) { |line|
    arr = line.chomp.split(',')
    arr.each { |str|
      values.push(calculate_hash(str))
    }
  }
  values
end

def part_1
  input = "input"
  values = parse_input(input)
  # p values
  p values.reduce(0) { |value, increment| value + increment}
end

part_1
