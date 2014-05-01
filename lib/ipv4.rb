# input: 32-bit number. output: IPv4 address
# http://www.codewars.com/kata/52e88b39ffb6ac53a400022e
# Ex:  int32_to_ip(2149583361) => "128.32.10.1"

def int32_to_ip(num)
  return '0.0.0.0' if num == 0
  n = num.to_s(2)   # binary version of 32-bit num
  ip = ''
  [0, 8, 16, 24].each do |x|
    ip += "#{n[x..x + 7].to_i(2)}." # decimal version of 8 bit chunk
  end
  ip[0..-2]
end

puts int32_to_ip(2149583361)