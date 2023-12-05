def parseNums(string)
  arr = []
  for step in 0..string.length/3-1 do
    arr.push(string[3*step..3*(step+1)].to_i)
  end
  arr
end

sum = 0
File.foreach('input') { |line|
  values = line.split(':')[1].split(' | ')
  winners,numbers = parseNums(values[0]), parseNums(values[1])
  # p winners, numbers
  wins = 0;
  numbers.each { |num|
    wins +=1 if winners.include?(num)
  }
  sum += 2**(wins-1) unless wins == 0
}

p sum
