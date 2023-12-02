# parse input, find if any of the values are greater than
# puzzle 1
# 12 red
# 13 green
# 14 blue
# if all values are under -> add gameId to sum
# if any value is over -> continue.

sum = 0
max_red = 12
max_green = 13
max_blue = 14

File.foreach("input") { |line|
  # Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
  is_valid = true
  game_line = line.sub('\n', '').split(': ')
  pulls = game_line[1].split('; ')
  pulls.each { |pull|
    cubes = pull.split(', ')
    cubes.each { |color| # '3 blue'
      values = color.split(' ')
      case values[1]
      when 'red'
        is_valid = values[0].to_i <= max_red
      when 'blue'
        is_valid = values[0].to_i <= max_blue
      when 'green'
        is_valid = values[0].to_i <= max_green
      end
      break unless is_valid
    }
    break unless is_valid
  }
  # p line, is_valid
  sum += game_line[0].split(' ')[1].to_i if is_valid
  # p sum
}
p sum
