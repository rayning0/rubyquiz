# http://www.codewars.com/kata/52f787eb172a8b4ae1000a34
# Write a program that will calculate the number of trailing
# zeros in a factorial of a given number.

# Test Cases:
# Expected: 0,
# Expected: 1,
# Expected: 7,
# Expected: 24,
# Expected: 249,
# Expected: 24999,
# Expected: 249999998

# It's the geometric series:
# n/5 + n/25 + n/125 + n/625 ... + n/(5**c)

def zeros(n)
  c, zeros = 0, 0
  loop do
    c += 1
    power_term = n / 5**c
    break if power_term == 0
    zeros += power_term
  end
  zeros
end

# Better Solution:
# def zeros(n)
#   zeros = 0
#   zeros += n /= 5 until n == 0
#   zeros
# end

puts zeros(1)
puts zeros(6)
puts zeros(14)
puts zeros(24)
puts zeros(25)
puts zeros(40)
puts zeros(49)
puts zeros(50)
puts zeros(99)
puts zeros(100)
puts zeros(999)
puts zeros(1000)

# 0-4! = 0 zeroes
# 5-9! = 1 zero
# 10-14 = 2 zeroes
# 20-24 = 4
# 25-29 = 6
# 40-44 = 9
# 45-49 = 10
# 50-54 = 12
# 99    = 22
# 100   = 24
# 999   = 246
# 1000  = 249
