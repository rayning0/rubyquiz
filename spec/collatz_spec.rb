class Collatz

  def sequence
    max_sequence_count = 0
    max_index_number = 0

    (1..1000000).each do |i|
      num = i
      sequence_count = 1
      if (i == 1)
        sequence_count = 1
      else
        while (num > 1)
          if (num % 2 == 0)
            num /= 2
          else
            num = num * 3 + 1
          end
          sequence_count += 1
        end
      end
      if sequence_count > max_sequence_count
        max_sequence_count = sequence_count
        max_index_number = i
      end
    end
      puts max_index_number
      puts max_sequence_count

  end

end

Collatz.new.sequence


#Sample of Tests

require 'rspec'

require './collatz'

describe Collatz do

  describe '.sequence' do

    it '2nd number (2) has 2 items in the sequence' do
      expect(CollatzDigits.new.max_value[0]).to eql(2)
    end

    it '13th number (13) has 10 items in the sequence' do
      expect(CollatzDigits.new.calculate[12]).to eql(10)
    end

    it '1000000th number (1000000) has 525 items in the sequence' do
      expect(CollatzDigits.new.calculate[999999]).to eql(525)
    end

  end

end