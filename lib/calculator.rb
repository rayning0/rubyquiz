# http://www.codewars.com/kata/5235c913397cbf2508000048/train/ruby

# Create a simple calculator that, given a string of operators
# (+ - * and /), and numbers separated by spaces, returns the value
# of that expression

# Ex: Calculator.new.evaluate("2 / 2 + 3 * 4 - 6") # => 7
# Remember order of operations!

class Calculator
  def evaluate(string)
    # Ex: s = "- 2 + 3 * 4 / 3 - 6 / 3 * 3 + 8"

    # array of parts with only * and /
    # Ex: ["", " 2 ", " 3 * 4 / 3 ", " 6 / 3 * 3 ", " 8"]
    mult_div = string.split(/[+-]/)
    mult_div[0] = '0' if mult_div[0] == '' #for negative 1st number

    # array of all +/- characters in string
    # Ex: ["-", "+", "-", "+"]
    plus_minus = string.split.select { |c| c =~ /[+-]/ }
    print "mult_div: #{mult_div}\n"
    print "plus_minus: #{plus_minus}\n\n"
    combine(mult_div, plus_minus, calc_md(mult_div[0]), true)
  end

  def calc(x, y, operator)
    case operator
    when '*' then x * y
    when '/' then x / y.to_f
    when '+' then x + y
    else x - y
    end
  end

  # evaluate only parts with * and /
  # Ex: " 3 * 4 / 3 "
  def calc_md(md)
    # array of only numbers: [3, 4, 3]
    nums = md.split.select{ |x| x =~ /[0-9]+/ }.map(&:to_i)
    # array of only * and / symbols: ["*", "/"]
    symbols = md.split.select{|y| y=~ /[*\/]/}
    combine(nums, symbols, nums[0])
  end

  # calculates combination of numbers and symbols
  def combine(nums, symbols, initial_total, md_flag = false)
    total = initial_total
    nums.each_with_index do |num, i|
      next if i == 0
      operator = symbols[i - 1]
      if md_flag
        total = calc(total, calc_md(num), operator)
      else
        total = calc(total, num, operator)
      end
    end
    total
  end
end