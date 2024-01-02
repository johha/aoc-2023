




def task_1
  lines = File.readlines("day1.txt", chomp: true).to_a
  total_sum = 0

  lines.each do |l|
    l_split = l.scan(/\d/).map(&:to_i)
    total_sum += ((l_split.first * 10) + l_split.last) if l_split.size > 0
  end

  puts total_sum
end


def task_2
  lines = File.readlines("day1.txt", chomp: true).to_a

  total_sum = 0


  strings = [
    "two1nine",
  "eightwothree",
  "abcone2threexyz",
  "xtwone3four",
  "4nineeightseven2",
  "zoneight234",
  "7pqrstsixteen"
  ]

  # lines = strings


  numbers = %w[one two three four five six seven eight nine]
  lines.sum do |line|
    digits = line.scan(/(?=(one|two|three|four|five|six|seven|eight|nine|\d))/).flatten
    first = numbers.index(digits.first)&.next || digits.first
    last = numbers.index(digits.last)&.next || digits.last
    total_sum += "#{first}#{last}".to_i
  end
  puts total_sum
end



# task_1

task_2

