
sample_input = [
  "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green",
  "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue",
  "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red",
  "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red",
  "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green",
]

def task_a(games)
  max_reds  = 12
  max_greens = 13
  max_blues = 14

  impossible_game_ids = Set[]
  possible_game_ids = (1..games.size).to_set

  games.each_with_index do |g, index|
    g.split(":")[1].split(";").each do |round|
      hash = Hash[round.split(", ").map { |x| x.split(" ").reverse }]
      hash.each { |k, v| hash[k] = v.to_i }

      if hash.fetch('blue', 0) > max_blues || hash.fetch('green', 0) > max_greens || hash.fetch('red', 0) > max_reds
        impossible_game_ids.add(index + 1)
        break
      end

    end
    # next if possible_game_ids.any?(index + 1 )
  end
  puts possible_game_ids.subtract(impossible_game_ids).sum
  end


def task_b(games)
  game_power = []

  games.each_with_index do |g, index|
    round_max = {:blue => 0, :green => 0, :red => 0}
    g.split(":")[1].split(";").each do |round|
      hash = Hash[round.split(", ").map { |x| x.split(" ").reverse }]
      hash.each { |k, v| hash[k] = v.to_i }
      hash.transform_keys(&:to_sym)
      round_max.merge!(hash) { |k, o, n| [o, n].max }

    end
    game_power.append((round_max.values.reject(&:zero?).inject(:*)))
  end

  puts game_power.sum
end

games = File.readlines("day2.txt", chomp: true).to_a
# task_a(games)

task_b(games)