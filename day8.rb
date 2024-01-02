def task_a(input)
  instructions = input[0].split("")

  nodes = {}

  input[2..].each do |inp|
    key, val = inp.split(" = ")
    nodes[key] = {:L => val[1..3], :R => val[6..8]}
  end

  start_node = 'AAA'
  end_node = 'ZZZ'

  current_node = start_node

  steps = 0
  until current_node == end_node
    steps += 1
    current_node = nodes[current_node][instructions[0].to_sym]
    instructions.rotate!
  end

  p "done in #{steps} steps"
end


def task_b(input)
  instructions = input[0].split("")

  nodes = {}

  input[2..].each do |inp|
    key, val = inp.split(" = ")
    nodes[key] = {:L => val[1..3], :R => val[6..8]}
  end

  start_nodes = nodes.keys.select { |k| k.end_with?("A") }

  steps_per_node = []

  current_nodes = start_nodes
  current_nodes.length.times do |i|
    curr = current_nodes[i]
    steps = 0
    until curr.end_with?("Z")
      steps += 1
      curr = nodes[curr][instructions[0].to_sym]
      instructions.rotate!
    end
    steps_per_node.append(steps)

  end
  lcm = steps_per_node.reduce(&:lcm)
  p "done in #{lcm} steps"
end
sample_input_1 = <<-TEXT
RL

AAA = (BBB, CCC)
BBB = (DDD, EEE)
CCC = (ZZZ, GGG)
DDD = (DDD, DDD)
EEE = (EEE, EEE)
GGG = (GGG, GGG)
ZZZ = (ZZZ, ZZZ)
TEXT

sample_input_2 = <<-TEXT
LLR

AAA = (BBB, BBB)
BBB = (AAA, ZZZ)
ZZZ = (ZZZ, ZZZ)
TEXT

sample_input_3 = <<-TEXT
LR

11A = (11B, XXX)
11B = (XXX, 11Z)
11Z = (11B, XXX)
22A = (22B, XXX)
22B = (22C, 22C)
22C = (22Z, 22Z)
22Z = (22B, 22B)
XXX = (XXX, XXX)

TEXT

input = File.readlines("day8.txt", chomp: true)
sample_input_1 = sample_input_1.split("\n")
sample_input_2 = sample_input_2.split("\n")
sample_input_3 = sample_input_3.split("\n")

# task_a(input)
task_b(input)


