


def task_a(input)
  result_numbers = []
  num_cols = input[0].size
  num_lines = input.size

  joined_input = input.join
  d2_input = input.map { |x| x.chars}

  symbols = joined_input.dup
  symbols.gsub!(/\d+/,"")
  symbols.gsub!(/\./,"")
  symbols = symbols.split('')

  matches = []
  joined_input.scan(/\d+/) do |match|
    md = Regexp.last_match
    matches << { match: match, start: md.begin(0), end: md.end(0)-1 }
  end

  matches.each do |m|
    # puts "#{m[:match]} starts at #{m[:start]} and ends at #{m[:end]}"
    (m[:start]..m[:end]).each do |pos|
      row = pos / num_cols
      col = pos % num_cols
      # RIGHT
      if pos == m[:end] &&col < num_cols && symbols.include?(d2_input[row][col + 1])
        result_numbers.append(m[:match].to_i)
        next
      end
      # RIGHT DOWN
      if pos == m[:end] && col < num_cols - 1 && row < num_lines - 1 && symbols.include?(d2_input[row+1][col + 1])
        result_numbers.append(m[:match].to_i)
        next
      end
      # RIGHT UP
      if pos == m[:end] && col < num_cols - 1  && row > 0 && symbols.include?(d2_input[row - 1][col + 1])
        result_numbers.append(m[:match].to_i)
        next
      end
      # LEFT
      if pos == m[:start] && col > 0 && symbols.include?(d2_input[row][col - 1])
        result_numbers.append(m[:match].to_i)
        next
      end
      # LEFT DOWN
      if pos == m[:start] && col > 0 && row < num_lines - 1 && symbols.include?(d2_input[row + 1][col - 1])
        result_numbers.append(m[:match].to_i)
        next
      end
      # LEFT UP
      if pos == m[:start] && col > 0 && row > 0 && symbols.include?(d2_input[row - 1][col - 1])
        result_numbers.append(m[:match].to_i)
        next
      end
      # ALL DOWN
      if row < num_lines - 1 && symbols.include?(d2_input[row + 1][col])
          result_numbers.append(m[:match].to_i)
          next
      end
      # ALL UP
      if row > 0 && symbols.include?(d2_input[row - 1][col])
        result_numbers.append(m[:match].to_i)
        next
      end
    end



  end

  puts result_numbers.sum



  puts "done"
end



def task_b(input)
  result_hash = []
  num_cols = input[0].size
  num_lines = input.size

  joined_input = input.join
  d2_input = input.map { |x| x.chars}

  symbols = ['*']

  matches = []
  joined_input.scan(/\d+/) do |match|
    md = Regexp.last_match
    matches << { match: match, start: md.begin(0), end: md.end(0)-1 }
  end

  matches.each do |m|
    (m[:start]..m[:end]).each do |pos|
      row = pos / num_cols
      col = pos % num_cols
      # RIGHT
      if pos == m[:end] &&col < num_cols && symbols.include?(d2_input[row][col + 1])
        result_hash << { ratio: m[:match].to_i, gear_y: row, gear_x: col + 1 }
        next
      end
      # RIGHT DOWN
      if pos == m[:end] && col < num_cols - 1 && row < num_lines - 1 && symbols.include?(d2_input[row+1][col + 1])
        result_hash << { ratio: m[:match].to_i, gear_y: row + 1, gear_x: col + 1 }
        next
      end
      # RIGHT UP
      if pos == m[:end] && col < num_cols - 1  && row > 0 && symbols.include?(d2_input[row - 1][col + 1])
        result_hash << { ratio: m[:match].to_i, gear_y: row - 1, gear_x: col + 1 }
        next
      end
      # LEFT
      if pos == m[:start] && col > 0 && symbols.include?(d2_input[row][col - 1])
        result_hash << { ratio: m[:match].to_i, gear_y: row, gear_x: col - 1 }
        next
      end
      # LEFT DOWN
      if pos == m[:start] && col > 0 && row < num_lines - 1 && symbols.include?(d2_input[row + 1][col - 1])
        result_hash << { ratio: m[:match].to_i, gear_y: row + 1, gear_x: col - 1 }
        next
      end
      # LEFT UP
      if pos == m[:start] && col > 0 && row > 0 && symbols.include?(d2_input[row - 1][col - 1])
        result_hash << { ratio: m[:match].to_i, gear_y: row - 1, gear_x: col - 1 }
        next
      end
      # ALL DOWN
      if row < num_lines - 1 && symbols.include?(d2_input[row + 1][col])
        result_hash << { ratio: m[:match].to_i, gear_y: row + 1, gear_x: col }
        next
      end
      # ALL UP
      if row > 0 && symbols.include?(d2_input[row - 1][col])
        result_hash << { ratio: m[:match].to_i, gear_y: row - 1, gear_x: col }
        next
      end
    end



  end

  grouped_hashes = result_hash.group_by { |h| [h[:gear_y], h[:gear_x]] }
  mult_values = grouped_hashes.map do |key, values|
    (values.count > 1) ? values.reduce(1) { |mult, hash| mult * hash[:ratio] } : nil
  end.compact

  puts mult_values.sum




  puts "done"
end


sample_input = %w(
467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..)

file_input = File.readlines("day3.txt", chomp: true).to_a



task_b(file_input)