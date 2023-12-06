$file = 'input'

$race_duration = []
$dist_needed = []
def process_inputs
  File.foreach($file) { |line|
    normalized = line.gsub(/\W+\D+/, ' ')
    $race_duration = normalized.split(' ').drop(1) if normalized.include?('Time')
    $dist_needed = normalized.split(' ').drop(1) if normalized.include?('Distance')
  }
end

def part1
  process_inputs()

  wins_per_race = []
  for race in 0...$race_duration.length do
    min_dist = $dist_needed[race].to_i
    duration = $race_duration[race].to_i

    for time in 1..duration/2 do
      dist = time * (duration-time)
      if dist > min_dist
        wins = (((duration+1)/2.to_f)-(time)) * 2
        p wins
        wins_per_race.push(wins.to_i)
        break
      end
    end
  end

  p wins_per_race.reduce { |prod, num| prod*num }
end

part1()

#part2, just manipulated the input instead of changing the process_input method
