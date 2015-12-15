# Take a sequence of comma separated integers as a command line
# argument. Find the longest palindrome in the sequence and write
# it to standard output. If there are no palindromes do not write
# any output. If there are two palindromes of equal length, write
# the first palindrome to appear in the sequence. nb. A palindrome
# is a sequence of numbers that reads the same backwards as forwards.
# Do not include spaces or any hidden characters in the output.

require 'spec_helper'
require 'palindrome'

describe Palindrome do
  let(:p) { Palindrome.new }

  it 'handles empty string (test 10)' do
    expect(p.find_pal('')).to eq ''
  end

  it 'handles no palindromes (test 9 & 2)' do
    expect(p.find_pal('a,b,c')).to eq ''
    expect(p.find_pal('2,0')).to eq ''
  end

  it 'handles 2 different length palindromes (test 1)' do
    expect(p.find_pal('1,7,3,8,7,8,3,0,9,2')).to eq '3,8,7,8,3'
  end

  it 'handles 2 palindromes of same length (test 5)' do
    expect(p.find_pal('1,2,1,4,5,4')).to eq '1,2,1'
  end

  it 'handles 3 palindromes, 2 of same length (test 8)' do
    expect(p.find_pal('1,2,3,2,1,5,6,7,6,5,10,11,10')).to eq '1,2,3,2,1'
  end

  it 'handles palindromes with negative numbers (test 7)' do
    expect(p.find_pal('-5,-7,-2,-1,0,1,0,-1,-2,-3,-4,-5,67')).to eq '-2,-1,0,1,0,-1,-2'
  end

  it 'handles palindromes w/ double or more digits (test 6)' do
    expect(p.find_pal('23,1,44,45,46,45,44,8,1234')).to eq '44,45,46,45,44'
  end

  it 'handles palindromes w/ several repeating digits (test 3 & 4)' do
    expect(p.find_pal('3,6,5,4,9,9,9,9,8,9,9,9,0')).to eq '9,9,9,8,9,9,9'
    expect(p.find_pal('1,4,5,6,5,4,7,4,5,6,5,7,8,9')).to eq '5,6,5,4,7,4,5,6,5'
  end
end