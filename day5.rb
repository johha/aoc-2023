def calc_hash_slow(input_map)

  output_hash = Hash.new { |h, k| h[k] = k }
  input_map.each do |m|
    dest, src, range_length = m.split(" ").map(&:to_i)
    range = (0..range_length - 1)
    range.each { |r| output_hash[src + r] = dest + r } # if seeds.any? {|i| range.include? i}
  end
  output_hash
end


def calc_pos(input_map, requested_pos)

  destination_pos = 0
  input_map.each do |m|
    dest, src, range_size = m.split(" ").map(&:to_i)
    if (src..src + range_size).include?(requested_pos)
      range_pos = requested_pos - src
      destination_pos = dest + range_pos
    end
  end
  destination_pos == 0 ? requested_pos : destination_pos
end


# def calc_pos_with_range(input_map, requested_range)
#
#   destination_pos = 0
#   input_map.each do |m|
#     dest, src, range_size = m.split(" ").map(&:to_i)
#     if (src..src + range_size).include?(requested_pos)
#       range_pos = requested_pos - src
#       destination_pos = dest + range_pos
#     end
#   end
#   destination_pos == 0 ? requested_pos : destination_pos
# end

def task_a(input)
  seeds = input[0].split(': ')[1].split(' ').map(&:to_i)

  all_maps = input[2..]

  seed_soil_map = all_maps[1..all_maps.index("") - 1]
  all_maps = all_maps[all_maps.index("") + 1..]

  soil_fert_map = all_maps[1..all_maps.index("") - 1]
  all_maps = all_maps[all_maps.index("") + 1..]
  fert_water_map = all_maps[1..all_maps.index("") - 1]
  all_maps = all_maps[all_maps.index("") + 1..]
  water_light_map = all_maps[1..all_maps.index("") - 1]
  all_maps = all_maps[all_maps.index("") + 1..]
  light_tmp_map = all_maps[1..all_maps.index("") - 1]
  all_maps = all_maps[all_maps.index("") + 1..]
  tmp_hum_map = all_maps[1..all_maps.index("") - 1]
  all_maps = all_maps[all_maps.index("") + 1..]
  hum_loc_map = all_maps[1..]

  seed_loc_hash = {}
  seeds.each do |s|
    soil_pos = calc_pos(seed_soil_map, s)
    fert_pos = calc_pos(soil_fert_map, soil_pos)
    water_pos = calc_pos(fert_water_map, fert_pos)
    light_pos = calc_pos(water_light_map, water_pos)
    tmp_pos = calc_pos(light_tmp_map, light_pos)
    hum_pos = calc_pos(tmp_hum_map, tmp_pos)
    loc_pos = calc_pos(hum_loc_map, hum_pos)



    seed_loc_hash[s] = loc_pos
  end
  puts "done #{seed_loc_hash.values.min}"
end

##############
### TASK B ###
##############

# def task_b(input)
#   seeds = input[0].split(': ')[1].split(' ').map(&:to_i)
#   seed_ranges = {}
#   seeds.each_slice(2) { |a, b| seed_ranges[a] = b }


input = File.readlines("day5.txt", chomp: true).to_a


sample_input = [
  "seeds: 79 14 55 13",
  "",
  "seed-to-soil map:",
  "50 98 2",
  "52 50 48",
  "",
  "soil-to-fertilizer map:",
  "0 15 37",
  "37 52 2",
  "39 0 15",
  "",
  "fertilizer-to-water map:",
  "49 53 8",
  "0 11 42",
  "42 0 7",
  "57 7 4",
  "",
  "water-to-light map:",
  "88 18 7",
  "18 25 70",
  "",
  "light-to-temperature map:",
  "45 77 23",
  "81 45 19",
  "68 64 13",
  "",
  "temperature-to-humidity map:",
  "0 69 1",
  "1 0 69",
  "",
  "humidity-to-location map:",
  "60 56 37",
  "56 93 4",
]

task_b(sample_input)