sum = 0
numbers = %w(1 2 3 4 5 6 7 8 9)
word_nums = %w(one two three four five six seven eight nine)

File.foreach("input") { |line|
  first = 0
  second = 0

  # p line
  # this should turn all typed out numbers into actual numbers
  # this doesn't work because 'eightwothree' -> 'eigh23' instead of '8wo3'
  # also can't rearrange the word_number ordering because 'one' needs to be before 'eight'
  #   which needs to be before 'two' which needs to be before 'one' :(
  # word_nums.each_with_index {|word, index|
  #   line.gsub! word, index
  # }

  findex = 1000
  word_nums.each_with_index {|word, ind|
    tmp = line.index(word)
    if (tmp != nil && tmp < findex)
      findex = tmp
      first = ind + 1
    end
  }
  numbers.each {|num|
    tmp = line.index(num)
    if (tmp != nil && tmp < findex)
      findex = tmp
      first = num
    end
  }

  lindex = -1
  word_nums.each_with_index {|word, ind|
    tmp = line.rindex(word)
    if (tmp != nil && tmp > lindex)
      lindex = tmp
      second = ind + 1
    end
  }
  numbers.each {|num|
    tmp = line.rindex(num)
    if (tmp != nil && tmp > lindex)
      lindex = tmp
      second = num
    end
  }

  # p first, second
  # this alone worked ok for part 1
  # line.each_char { |char|
  #   # if first is zero, and char is in numbers -> set first to char
  #   # if char is in numbers -> set second to char
  #   first = char if first == 0 && numbers.include?(char)
  #   second = char if numbers.include? char
  # }

  sum += (first.to_i * 10) + second.to_i
}
p sum
