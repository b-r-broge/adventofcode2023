# to new var gsub n number of '.' with single character ' '
# split new var on ' '
# grab values, store in nested hash .dig(row, start_column)
# store numbers in array as tuples (val, row, start_column)
# loop through, checking nested hash for all surroundings for symbol
# those with a symbol nearby += sum, those without, continue

sum = 0
schema = {}
numbers = []

file = File.read('test').split
file.each_with_index { |line, index|
  # don't want negative numbers
  line.gsub!(/\-!@#$%^*_=+\//, '#')
  schema[index] = {}
  line_items = line.gsub(/\.+/, " ")
  line_items.strip!
  line_values = line_items.split(' ')

  line_values.each { |value|
    is_number = value.to_i.to_s == value
    if is_number
      tuple = [value.to_i, index, line.index(value)]
      numbers.push(tuple)
    else
      # number may begin or end (or both) with a symbol, need to backup check here
      if value.length() > 1
        # 617*123
        num = 0
        arr = value.split('')
        arr.each_with_index { |val, idx|
          is_num = val.to_i.to_s == val
          if is_num
            num = (num*10)+val.to_i
          else
            schema[index][line.index(value)+idx] = true
            numbers.push([num, index, line.index(value)+idx-num.to_s.length()]) unless num == 0
            num = 0
          end
        }
        numbers.push([num, index, line.index(value)+value.to_s.length()-num.to_s.length()]) unless num == 0
      else
        schema[index][line.index(value)] = true
      end
    end
  }
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

  # p number
  # p found_symbol
  sum += number if found_symbol
}

# p schema, numbers
p sum
