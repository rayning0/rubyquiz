# http://www.codewars.com/kata/51b66044bce5799a7f000003/train/ruby
# http://rubyquiz.com/quiz22.html

class RomanNumerals
  ROMAN = { 1 => 'I',
            4 => 'IV',
            5 => 'V',
            9 => 'IX',
            10 => 'X',
            40 => 'XL',
            50 => 'L',
            90 => 'XC',
            100 => 'C',
            400 => 'CD',
            500 => 'D',
            900 => 'CM',
            1000 => 'M' }

  RROMAN = Hash[ROMAN.to_a.map(&:reverse)] # reversed ROMAN hash

  DIVS = [1, 5, 10, 50, 100, 500, 1000]
  WEIRD = [4, 9, 40, 90, 400, 900]
  INPUT_FILE = './data/roman_number_input.txt'
  OUTPUT_FILE = './data/roman_number_output.txt'

  attr_reader :filename, :input

  def initialize(filename = INPUT_FILE)
    @filename = filename
    @input = read_file
  end

  def read_file
    IO.readlines(filename).map(&:chomp) # reads file as array
  end

  def write_roman_file
    File.open(OUTPUT_FILE, 'w') # overwrites old file

    input.each do |line|
      File.open(OUTPUT_FILE, 'a') do |file|
        if line.to_i != 0   # We read integer. Convert to Roman.
          file.puts(to_roman(line.to_i))
        else                # We read Roman. Convert to integer.
          file.puts(from_roman(line))
        end
      end
    end
  end

  def to_roman(int)
    return ROMAN[int] if ROMAN[int]
    ans = ''
    DIVS.reverse_each do |d|
      duplicates = int / d
      remainder = int % d

      ans += ROMAN[d] * duplicates if duplicates > 0

      WEIRD.reverse_each do |weird|
        break if weird < d
        wremainder = int % weird
        if wremainder < remainder
          remainder = wremainder
          # write over last addition to ans, with weird Roman number
          ans = ans[0..-2] + ROMAN[weird]
        end
      end

      int = remainder
    end
    ans
  end

  def from_roman(string)
    return RROMAN[string] if RROMAN[string]
    ans, i = 0, 0
    while i < string.size
      s = string[i]

      if i < string.size - 1
        # look ahead 1 char. are these 2 chars in hash?
        lookahead = RROMAN[string[i..i + 1]]

        if lookahead
          ans += lookahead
          i += 2
          next
        end
      end

      ans += RROMAN[s]
      i += 1
    end
    ans
  end
end