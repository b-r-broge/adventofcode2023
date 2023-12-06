sum = 0
schema = []
numbers = {}

file = File.read('input').split
file.each_with_index { |line, index|
  # don't want negative numbers
  line.gsub!('-', '#')
  numbers[index] = {}
  num = 0
  line.split('').each_with_index { |value, idx|
    if value.to_i.to_s == value
      num = (num*10)+value.to_i
    else
      schema.push([index, idx]) if value == '*'
      numbers[index][idx-num.to_s.length] unless num == 0
      num = 0
    end
  }
  numbers.push([num, index, line.length-num.to_s.length]) unless num == 0
  num = 0
}

numbers.each { |number_tuple|
  found_symbol = false
  number = number_tuple[0]
  row = number_tuple[1]
  column = number_tuple[2]

  # check the box around the number, if any return true, add to sum and exit
  for r_index in row-1...row+2 do
    for c_index in column-1...column+1+number.to_s.length() do
      # p "searching #{r_index}, #{c_index}"
      found_symbol = schema.dig(r_index, c_index) || false
      break if found_symbol
    end
    break if found_symbol
  end

  # p number if found_symbol
  # p found_symbol
  sum += number if found_symbol
}

# p schema, numbers
p sum
