def parse_nums(string)
  arr = []
  for step in 0...string.length/3 do
    arr.push(string[3*step...3*(step+1)].to_i)
  end
  arr
end

doubles_queue = []
cards = 0
# count = 1
File.foreach('input') { |line|
  values = line.split(':')[1].split(' | ')
  winners,numbers = parse_nums(values[0]), parse_nums(values[1])
  wins = 0;
  numbers.each { |num|
    wins +=1 if winners.include?(num)
  }
  # nil if queue is empty, otherwise top value
  double = doubles_queue.shift || 1
  cards += double

  # add wins to the doubles_queue
  # p "card #{count}:", wins, double
  for win in 0...wins do
    if doubles_queue.length > win
      doubles_queue[win] += double
    else
      double == 1 ? doubles_queue.push(2) : doubles_queue.push(double)
    end
  end
  # p doubles_queue, cards
  # count +=1
}

p cards
