# http://www.codewars.com/kata/52bef5e3588c56132c0003bc/solutions/ruby
# You are given a binary tree (not sorted, it doesn't matter in this kata) represented by TreeNode class
# return the array with elements from tree sorted by levels, which means the root element goes first, then root children (from left to right) are second and third, and so on. The leaf terminator is nil. Return empty array for empty tree (nil argument).

class TreeNode
  attr_accessor :left, :right, :value

  def initialize(value = nil, left = nil, right = nil)
    @value = value
    @left = left
    @right = right
  end
end

# sample binary tree
n1 = TreeNode.new(1, nil, nil)
n3 = TreeNode.new(3, nil, nil)
n4 = TreeNode.new(4, nil, nil)
n5 = TreeNode.new(5, nil, nil)
n8 = TreeNode.new(8, n1, n3)
n9 = TreeNode.new(9, n4, n5)
n2 = TreeNode.new(2, n8, n9)

# n3 = TreeNode.new(3, nil, nil)
# n8 = TreeNode.new(8, nil, n3)
# n7 = TreeNode.new(7, nil, nil)
# n5 = TreeNode.new(5, nil, n7)
# n4 = TreeNode.new(4, nil, n5)
# n1 = TreeNode.new(1, n8, n4)

# Breadth-First Search algorithm
def tree_by_levels(node)
  return [] if node.nil?
  queue = [node]
  visited = []
  while !queue.empty?
    node = queue.shift
    visited << node.value
    [node.left, node.right].each do |child|
      queue << child if child
    end
  end
  visited
end

# Best solution:
# def tree_by_levels(node)
#   return [] unless node
#   visited = []
#   queue = [node]
#   until queue.empty?
#     node = queue.shift
#     visited << node.value
#     queue << node.left if node.left
#     queue << node.right if node.right
#   end
#   visited
# end

# generic depth-first search
# returns preorder visits
def dfs(node)
  preorder, visited = [], []
  dfs_visit(node, visited, preorder)
  preorder
end

def dfs_visit(node, visited, preorder)
  return if node.nil?
  visited << node
  preorder << node.value  # add vertex to queue BEFORE recursion
  # print "node: #{node.value} preorder: #{preorder}\n\n"
  [node.left, node.right].each do |child|
    if !visited.include?(child)
      dfs_visit(child, visited, preorder)
    end
  end
  preorder
end

print "Preorder, by DFS: #{dfs(n2)}\n"
print "BFS order: #{tree_by_levels(n2)}\n"

tree1 = TreeNode.new
tree2 = TreeNode.new
tree3 = TreeNode.new
tree4 = TreeNode.new
tree5 = TreeNode.new
tree6 = TreeNode.new
tree7 = TreeNode.new

# simple helper function to build trees more easily
def buildTree(node,arr)
  node.value = arr.shift
  size = (arr.size/2.0).round
  if size > 0
    left, right = arr.each_slice( size ).to_a
    if left and left.count > 0
      node.left = TreeNode.new
      buildTree(node.left, left)
    end
    if right and right.count > 0
      node.right = TreeNode.new
      buildTree(node.right, right)
    end
  end
end

buildTree(tree1,[1])
buildTree(tree2,[2,8,9,1,3,4,5])
buildTree(tree3,[421,423,23,1,1,1,1,1,1,1,324,432,3,2,1,34,6])
buildTree(tree4,[1,2,3,4,5,6,7,8,9])
buildTree(tree6,[1] * 100000)
buildTree(tree7,[9,1,1,1,1,4,7])

# Test.expect(tree_by_levels(nil) == [], 'Nil should yield empty array')
# Test.expect(tree_by_levels(tree1) == [1], 'Tree with one element')
# Test.expect(tree_by_levels(tree2) == [2, 8, 3, 9, 1, 4, 5], 'random tree 1')
# Test.expect(tree_by_levels(tree3) == [421, 423, 1, 23, 1, 324, 1, 1, 1, 1, 1, 432, 2, 34, 6, 1, 3], 'random tree 2')
# Test.expect(tree_by_levels(tree4) == [1, 2, 6, 3, 5, 7, 9, 4, 8], 'random tree 3')
# Test.expect(tree_by_levels(tree6) == ([1] * 100000), 'big tree')
# Test.expect(tree_by_levels(tree7) == [9, 1, 1, 1, 1, 4, 7], 'random tree 4')

print "nil tree: #{tree_by_levels(nil)}\n"
print "tree 1: #{tree_by_levels(tree1)}\n"
print "tree 2: #{tree_by_levels(tree2)}\n"
print "tree 3: #{tree_by_levels(tree3)}\n"
print "tree 4: #{tree_by_levels(tree4)}\n"
print "tree 6: array of 100,000 one's\n"
print "tree 7: #{tree_by_levels(tree7)}\n"
