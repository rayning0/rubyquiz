# http://www.codewars.com/kata/52f78966747862fc9a0009ae/train/ruby
# create a calculator which evaluates expressions in Reverse Polish notation.
# http://en.wikipedia.org/wiki/Reverse_Polish_notation

class ReversePolish
  def calc(string)
    return 0 if string == ''
    stack = []
    string.split.each do |s|
      # if s is an operator. Ex: 3.respond_to?(:+)
      if stack.last.respond_to?(s)
        num2 = stack.pop
        num1 = stack.pop

        # same as stack << calculate(num1, num2, s)
        stack << num1.send(s, num2)
      else
        stack << s.to_f
      end

      # if s =~ /[0-9]/  # it's a number
      #   stack << s
      # elsif s =~ /[*+-\/]/ # it's an operator
      #   num2 = stack.pop.to_f
      #   num1 = stack.pop.to_f
      #   stack << num1.send(s, num2)
      #   # same as stack << calculate(num1, num2, s)
      # end
    end
    stack.pop
  end
end

# Best Solution:
# def calc(expr)
#   expr.split.inject([0]) do |stack, token|
#     if stack.last.respond_to? token
#       a, b = stack.pop(2)
#       stack << a.send(token, b)
#     else
#       stack << token.to_f
#     end
#   end.last
# end