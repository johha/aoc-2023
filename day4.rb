

def task_a(cards)
  total_points = 0
  cards.each do |c|
    c = c.split(': ')[1].split(" | ")
    winning_nums = c[0].split(" ").map(&:to_i) & c[1].split(" ").map(&:to_i)
    card_points = winning_nums.empty? ? 0 : 2 ** (winning_nums.size - 1)
    total_points += card_points
  end

  puts "done: #{total_points}"

end


def task_b(cards)
  card_counts = Hash.new {|h,k| h[k] = 1}

  cards.each do |c|
    c_split = c.split(': ')
    card_id = c_split[0].split('Card ')[1].to_i
    c = c_split[1].split(" | ")
    winners = c[0].split(" ").map(&:to_i) & c[1].split(" ").map(&:to_i)

    card_counts[card_id].times do  # Math magic
      winners.size.times do |i|
        card_counts[card_id + i + 1] += 1
      end
    end

  end
  puts card_counts.values.sum
end


def recurse_cards(cards, all_cards, num_winning_cards=0, depth=0)
  cards.each_with_index do |c, index|
    c_split = c.split(': ')
    c_num = c_split[0].split('Card ')[1].to_i
    c = c_split[1].split(" | ")
    winning_nums = c[0].split(" ").map(&:to_i) & c[1].split(" ").map(&:to_i)
    if winning_nums.size > 0
      num_winning_cards += winning_nums.size
      puts "Card ##{c_num} won cards: #{(c_num + 1 ..c_num + winning_nums.size)} - with depth #{depth}"
      winning_cards = all_cards[c_num..(c_num + winning_nums.size - 1)]
      recurse_cards(winning_cards, all_cards, num_winning_cards, depth=(depth + 1))
    else
      puts "Card ##{c_num} did not win - with depth #{depth}"
    end




  end
  num_winning_cards
end

cards = File.readlines("day4.txt", chomp: true).to_a

sample_cards = [
"Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53",
"Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19",
"Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1",
"Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83",
"Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36",
"Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11",
]

# task_a(cards)
task_b(cards)