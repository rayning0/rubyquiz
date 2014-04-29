require 'spec_helper'
require '001_solitaire_cipher'

describe Encrypt do
  let(:message) { Encrypt.new('Code in Ruby, live longer!') }

# 1. Discard any non–A to Z characters, and uppercase all remaining
# letters. Split the message into five character groups, using Xs to
# pad the last group, if needed.

  describe '#step_one' do
    it 'Discards non-letters, makes upcase, splits into 5 char gps' do
      expect(message.step_one).to eq('CODEI NRUBY LIVEL ONGER')
    end
  end

# 2. Use Solitaire to generate a keystream letter for each letter in the
# message.

  describe '#make_keystream' do
    it 'Makes keystream letter for each letter in message' do
      expect(message.make_keystream).to eq('DWJXH YRFDG TMSHP UURXJ')
    end
  end

# 3. Convert the message from step 1 into numbers, A = 1, B = 2, etc

  describe '#to_num' do
    it 'Converts message from step 1 to numbers, A = 1, B = 2, etc' do
      expect(message.to_num('CODEI NRUBY LIVEL ONGER')).to \
        eq('3 15 4 5 9 14 18 21 2 25 12 9 22 5 12 15 14 7 5 18')
    end

# 4. Convert the keystream letters from step 2 using the same method:

    it 'Converts keystream letters from step 2 the same way:' do
      expect(message.to_num('DWJXH YRFDG TMSHP UURXJ')).to \
      eq('4 23 10 24 8 25 18 6 4 7 20 13 19 8 16 21 21 18 24 10')
    end
  end

# 5. Add message numbers from step 3 to keystream numbers from step 4
# and subtract 26 from the result if it's > 26. For example,
# 6 + 10 = 16 as expected, but 26 + 1 = 1 (27 - 26):

  describe '#add_nums_mod' do
    let(:step3) { '3 15 4 5 9 14 18 21 2 25 12 9 22 5 12 15 14 7 5 18' }
    let(:step4) { '4 23 10 24 8 25 18 6 4 7 20 13 19 8 16 21 21 18 24 10' }

    it 'Adds step 3 + step 4 numbers, mod 26' do
      expect(message.add_nums_mod(step3, step4)).to \
      eq('7 12 14 3 17 13 10 1 6 6 6 22 15 13 2 10 9 25 3 2')
    end
  end

# 6. Convert the numbers from step 5 back to letters:
  describe '#to_letters' do
    let(:step5) { '7 12 14 3 17 13 10 1 6 6 6 22 15 13 2 10 9 25 3 2' }
    it 'Converts step 5 numbers back to letters' do
      expect(message.to_letters(step5)).to eq('GLNCQ MJAFF FVOMB JIYCB')
    end
  end
end
