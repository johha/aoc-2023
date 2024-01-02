


def task_a(input)
  time_dist = Hash[input.split("\n").map { |line| line.split(':')[1].split.map(&:to_i) }.transpose]

  races_winner = Hash.new {|h,k| h[k] = 0}
  time_dist.each_with_index do |(time, dist), i|
    (0..time).each { |t| races_winner[i] += 1 if (time - t) * t > dist }
  end

  p "done: #{races_winner.values.inject(:*)}"
end


def task_b(input)
  time, dist = input.split("\n").map { |line| line.split(':')[1].gsub(" ","").to_i}

  races_winner = 0
  (0..time).each { |t| races_winner += 1 if (time - t) * t > dist }

  p "done: #{races_winner}"
end


sample_input = <<-TEXT
Time:      7  15   30
Distance:  9  40  200
TEXT


input = <<-TEXT
Time:        53     89     76     98
Distance:   313   1090   1214   1201
TEXT

# task_a(input)
task_b(input)