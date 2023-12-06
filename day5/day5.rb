# oh my goodness, what did they try to grow.
# capture array of seeds (X)
# push map strings into appropriate arrays
# process arrays into array of map objects (array/tuple?, hash?, map class?)
#  - lowest value, highest value, transformation
#  - in_range
#  - transform(x)
$file = 'test'
$seeds = []

class Mapping
  # 0.0 what am I doing?
  def initialize()
    @transformations = []
  end

  def addMappings(mappingArrays)
    # mapping arrays is an array of strings
    # each string has 3 parts
    # [0] - transformation of range
    # [1] - Start of range
    # [2] - Length of range
    mappingArrays.each { |map|
      values = map.split(' ')
      map = {
        start: values[1].to_i,
        end: values[1].to_i+values[2].to_i,
        transform: values[0].to_i-values[1].to_i
      }
      @transformations.push(map)
    }
  end

  def map(value)
    # pass in value
    # find appropriate transformation
    # return transformed value
    # p "In map: #{@transformations}, #{value}"
    @transformations.each { |map|
      return value+map[:transform] if value >= map[:start] && value < map[:end]
    }
    # if no value is found, return original value
    value
  end
end

$soil = Mapping.new()
$fert = Mapping.new()
$water = Mapping.new()
$light = Mapping.new()
$temp = Mapping.new()
$humid = Mapping.new()
$loc = Mapping.new()

def process_inputs
  toggle = ''
  build_map = []
  File.foreach($file) { |line|
    # send map off to parse, wipe build_map
    if line.length < 2
      next if toggle == ''
      case toggle
        when 'soil'
          $soil.addMappings(build_map)
        when 'fert'
          $fert.addMappings(build_map)
        when 'water'
          $water.addMappings(build_map)
        when 'light'
          $light.addMappings(build_map)
        when 'temp'
          $temp.addMappings(build_map)
        when 'humid'
          $humid.addMappings(build_map)
        when 'loc'
          $loc.addMappings(build_map)
      end
      build_map = []
      next
    end

    # build mapping array
    if line[0].to_i.to_s == line[0]
      build_map.push(line)
      next
    end

    # get seeds input
    if line.include?('seeds')
      $seeds = line.split(' ').drop(1)
      next
    end

    toggle = 'soil' if line.include?('-to-soil')
    toggle = 'fert' if line.include?('-to-fertilizer')
    toggle = 'water' if line.include?('-to-water')
    toggle = 'light' if line.include?('-to-light')
    toggle = 'temp' if line.include?('-to-temperature')
    toggle = 'humid' if line.include?('-to-humidity')
    toggle = 'loc' if line.include?('-to-location')
  }
  $loc.addMappings(build_map)
end

def traverse_maps(value)
  soil_val = $soil.map(value)
  fert_val = $fert.map(soil_val)
  water_val = $water.map(fert_val)
  light_val = $light.map(water_val)
  temp_val = $temp.map(light_val)
  humid_val = $humid.map(temp_val)
  loc = $loc.map(humid_val)
end

def part1
  process_inputs()
  loc_values = []
  $seeds.each {|seed|
    loc_values.push(traverse_maps(seed.to_i))
  }
  p loc_values
  p loc_values.min()
end

def part2
  # aka do it at scale!...nah
end

# part1()
part2()
