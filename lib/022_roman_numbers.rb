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
    ROMAN.keys.reverse.inject('') do |answer, div|
      duplicates = int / div
      int = int % div
      answer << ROMAN[div] * duplicates
    end
  end

  def from_roman(string)
    answer = 0
    # uses hash { 'M => 1000, 'CM' => 900, ... } and checks in that order
    # Ex: string = 'MCMXCIX'
    RROMAN.keys.reverse_each do |roman|
      # if the roman char (like 'M') from hash matches beginning of string
      while string.index(roman) == 0
        answer += RROMAN[roman]
        # remove 1st occurrence of roman ('M') from string
        # so now string = 'CMXCIX'
        string.slice!(roman)
      end
    end
    answer
  end
end