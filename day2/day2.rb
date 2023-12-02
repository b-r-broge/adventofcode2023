sum = 0
File.foreach("input") { |line|
  max_red = 1
  max_green = 1
  max_blue = 1
  game_line = line.sub('\n', '').split(': ')
  pulls = game_line[1].split('; ')
  pulls.each { |pull|
    cubes = pull.split(', ')
    cubes.each { |color| # '3 blue'
      values = color.split(' ')
      cube_num = values[0].to_i
      case values[1]
      when 'red'
        max_red = cube_num if cube_num > max_red
      when 'blue'
        max_blue = cube_num if cube_num > max_blue
      when 'green'
        max_green = cube_num if cube_num > max_green
      end
    }
  }
  # puts line, max_red, max_blue, max_green
  sum += (max_red*max_blue*max_green)
  # p sum
}
p sum
