# Fibonacci sequence
class Fibonacci
  def fib(n)
    sum, f1, f2 = 1, 1, 1
    (1..n - 2).each do |i|
      sum = f1 + f2
      f1 = f2
      f2 = sum
    end
    sum
  end
end