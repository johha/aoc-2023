
def task_a(input)
  types_with_bid = Array.new(7) { Hash.new }

  input.each do |i|
    cards, bid = i.split(" ")
    cards = cards.split('')

    cards_hash = cards.tally.sort_by {|_, value| value}.reverse.to_h
    if cards_hash.values[0] == 5
      types_with_bid[6][cards] = bid
    elsif cards_hash.values[0] == 4
      types_with_bid[5][cards] = bid
    elsif cards_hash.values[0] == 3 && cards_hash.values[1]== 2
      types_with_bid[4][cards] = bid
    elsif cards_hash.values[0] == 3
      types_with_bid[3][cards] = bid
    elsif cards_hash.values[0] == 2 && cards_hash.values[1] == 2
      types_with_bid[2][cards] = bid
    elsif cards_hash.values[0] == 2
      types_with_bid[1][cards] = bid
    else
      types_with_bid[0][cards] = bid
    end
  end

  cards_order = { "A" => 13, "K" => 12, "Q" => 11, "J" => 10, "T" => 9, "9" => 8, "8" => 7, "7" => 6, "6" => 5, "5" => 4, "4" => 3, "3" => 2, "2" => 1 }
  sorted_array = types_with_bid.map do |hash|
    Hash[hash.sort_by { |k, _| k.map { |card| cards_order[card] } }]
  end

  total_winnings = 0
  sorted_array.map(&:values).flatten.each_with_index { |v, i| total_winnings += ((i + 1) * v.to_i) }


  p "done: #{total_winnings}"
end

def task_b(input)
  types_with_bid = Array.new(7) { Hash.new }

  input.each do |i|
    cards, bid = i.split(" ")
    cards = cards.split('')

    cards_hash = cards.tally.sort_by {|_, value| value}.reverse.to_h
    val_1 = cards_hash.values[0]
    val_2 = cards_hash.values[1]
    val_j = cards_hash.fetch("J", 0)
    if val_1 == 5
      types_with_bid[6][cards] = bid
    elsif val_1 == 4
      if val_j == 1 || val_j == 4
        types_with_bid[6][cards] = bid
      else
        types_with_bid[5][cards] = bid
      end
    elsif val_1 == 3 && val_2 == 2
      if val_j == 1
        types_with_bid[5][cards] = bid
      elsif val_j >= 2
        types_with_bid[6][cards] = bid
      else
        types_with_bid[4][cards] = bid
      end
    elsif val_1 == 3
      if val_j == 1
        types_with_bid[4][cards] = bid
      elsif  val_j == 2
        types_with_bid[5][cards] = bid
      elsif  val_j == 3
        types_with_bid[6][cards] = bid
      else
        types_with_bid[3][cards] = bid
      end
    elsif val_1 == 2 && val_2 == 2
      if val_j == 1
        types_with_bid[3][cards] = bid
      elsif val_j == 2
        types_with_bid[4][cards] = bid
      elsif val_j == 3
        types_with_bid[5][cards] = bid
      elsif val_j == 4
        types_with_bid[6][cards] = bid
      else
        types_with_bid[2][cards] = bid
      end
    elsif val_1 == 2
      if val_j == 1
        types_with_bid[2][cards] = bid
      elsif  val_j == 2
        types_with_bid[3][cards] = bid
      elsif  val_j == 3
        types_with_bid[4][cards] = bid
      elsif  val_j == 3
        types_with_bid[4][cards] = bid
      elsif  val_j == 4
        types_with_bid[5][cards] = bid
      elsif  val_j == 5
        types_with_bid[6][cards] = bid
      else
        types_with_bid[1][cards] = bid
      end
    elsif val_j == 1
      types_with_bid[1][cards] = bid
    else
      types_with_bid[0][cards] = bid
    end
  end

  cards_order = { "A" => 13, "K" => 12, "Q" => 11, "T" => 10, "9" => 9, "8" => 8, "7" => 7, "6" => 6, "5" => 5, "4" => 4, "3" => 3, "2" => 2, "J" => 1 }
  sorted_array = types_with_bid.map do |hash|
    Hash[hash.sort_by { |k, _| k.map { |card| cards_order[card] } }]
  end

  total_winnings = 0
  sorted_array.map(&:values).flatten.each_with_index { |v, i| total_winnings += ((i + 1) * v.to_i) }


  p "done: #{total_winnings}"
end


def task_bb(input)
  types_with_bid = Array.new(7) { Hash.new }
  cards_order = { "A" => 13, "K" => 12, "Q" => 11, "T" => 10, "9" => 9, "8" => 8, "7" => 7, "6" => 6, "5" => 5, "4" => 4, "3" => 3, "2" => 2, "J" => 1 }

  input.each do |i|
    cards, bid = i.split(" ")
    cards = cards.split('')

    cards_hash = cards.dup.tally.sort_by {|_, value| value}.reverse.to_h
    cards_wo_j = cards_hash.dup
    cards_wo_j.delete('J')
    val_1 = cards_wo_j.values[0]
    key_1 = cards_wo_j.keys[0]
    val_2 = cards_wo_j.values[1]
    key_2 = cards_wo_j.keys[1]
    val_j = cards_hash.fetch("J", 0)

    if val_j == 5
      cards_hash[cards_order.keys[0]] = cards_hash.delete('J')
    elsif val_j == 4
        cards_hash[key_1] = cards_hash['J'] + cards_hash[key_1]
        cards_hash.delete('J')
    elsif val_j > 0 && val_2 == nil
      cards_hash[key_1] = cards_hash['J'] + cards_hash[key_1]
      cards_hash.delete('J')
    elsif val_j > 0 && val_1 > val_2
      cards_hash[key_1] = cards_hash['J'] + cards_hash[key_1]
      cards_hash.delete('J')
    elsif val_j > 0 && val_2 > val_1
      cards_hash[key_2] = cards_hash['J'] + cards_hash[key_2]
      cards_hash.delete('J')
    elsif val_j > 0
      (cards_order[key_1] > cards_order[key_2]) ?
        cards_hash[key_1] = cards_hash['J'] + cards_hash[key_1] :
        cards_hash[key_2] = cards_hash['J'] + cards_hash[key_2]
      cards_hash.delete('J')
    end


    cards_hash = cards_hash.sort_by {|_, value| value}.reverse.to_h
    val_1 = cards_hash.values[0]
    val_2 = cards_hash.values[1]

    if val_1 == 5
      types_with_bid[6][cards] = bid
    elsif val_1 == 4
      types_with_bid[5][cards] = bid
    elsif val_1 == 3 && val_2 == 2
      types_with_bid[4][cards] = bid
    elsif val_1 == 3
      types_with_bid[3][cards] = bid
    elsif val_1 == 2 && val_2 == 2
      types_with_bid[2][cards] = bid
    elsif val_1 == 2
      types_with_bid[1][cards] = bid
    else
      types_with_bid[0][cards] = bid
    end
  end

  sorted_array = types_with_bid.map do |hash|
    Hash[hash.sort_by { |k, _| k.map { |card| cards_order[card] } }]
  end

  total_winnings = 0
  sorted_array.map(&:values).flatten.each_with_index { |v, i| total_winnings += ((i + 1) * v.to_i) }


  p "done: #{total_winnings}"
end
sample_input = <<-TEXT
32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483
TEXT

sample_input = sample_input.split("\n")

input = File.readlines("day7.txt", chomp: true)


# task_a(sample_input)
task_bb(input)



