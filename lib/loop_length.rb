class Node
  attr_accessor :next, :name
  def initialize(name)
    @name = name
  end
end

a = Node.new('a')
b = Node.new('b')
c = Node.new('c')
d = Node.new('d')
e = Node.new('e')
f = Node.new('f')
g = Node.new('g')
h = Node.new('h')

a.next = b
b.next = c
c.next = d
d.next = e
e.next = f
f.next = g
g.next = h
h.next = d

def loop_size(node)
  return 1 if node.next == node   # 1 node loops to itself
  c = 0
  visited = []
  index = {}
  index[node.name] = c
  loop do
    puts "node: #{node.name}, #{index}"
    visited << node.name
    node = node.next
    c += 1
    if visited.include?(node.name)
      index[node.name] = c - index[node.name]
      break
    end
    index[node.name] = c
  end
  print "\nc: #{c}, visited: #{visited}\n"
  puts "index: #{index}"
  puts "loop size: #{index[node.name]}"
  index[node]
end

loop_size(a)

# Simple example that works with a hash
lp = {a: :b, b: :c, c: :d, d: :e, e: :f, f: :g, g: :h, h: :d}
lp2 = {a: :a}

def loop_size_hash(lp2)
  c = 0
  node = :a
  visited = []
  index = {}
  index[node] = c
  loop do
    puts "#{node}, #{index}"
    visited << node
    node = lp2[node]

    c += 1
    if visited.include?(node)
      index[node] = c - index[node]
      break
    end
    index[node] = c
  end
  print "\nc: #{c}, visited: #{visited}\n"
  puts "index: #{index}"
  puts "loop size: #{index[node]}"
end

#loop_size_hash(lp2)