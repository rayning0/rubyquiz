# http://rubyquiz.com/quiz1.html
class Encrypt
  attr_reader :message, :convert

  def initialize(message = '')
    @message = message
    @convert = {}
    ('A'..'Z').each_with_index do |letter, index|

      # {'A' => '1', 'B' => '2', etc}
      @convert[letter] = (index + 1).to_s
    end
  end

  def step_one
    # removes all non-word characters (\W) and numbers
    # m = message.gsub(/\W+/, '').gsub(/[0-9]+/, '').upcase
    # m.scan(/...../).join(' ')

    # Better! 1st scan extracts only all letters.
    # 2nd scan breaks result into array of 5 char chunks.
    message.scan(/[a-z]+/i).join.upcase.scan(/...../).join(' ')
  end

  def make_keystream

  end

  # change letters to string of numbers
  def to_num(string)
    string.gsub!(' ', '')
    string.each_char.map { |char| "#{convert[char]} " }.join.chop
  end

  # add message numbers + keystream numbers, mod 26 (max sum = 26)
  def add_nums_mod(string1, string2)
    s1, s2 = string1.split, string2.split
    s1.size.times.map { |i| (s1[i].to_i + s2[i].to_i) % 26 }
      .join(' ')
  end

  # change string of numbers back to letters
  def to_letters(num_string)
    num_string.split.map { |num| convert.key(num) }.join
      .scan(/...../).join(' ')
  end
end
