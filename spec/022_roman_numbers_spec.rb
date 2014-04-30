require 'spec_helper'
require '022_roman_numbers'

describe RomanNumerals do
  before(:all) do
    @rn = RomanNumerals.new
    @rn.write_roman_file
  end

  describe '#to_roman' do
    it 'converts integer to Roman number' do
      expect(@rn.to_roman(900)).to eq('CM')
      expect(@rn.to_roman(3)).to eq('III')
      expect(@rn.to_roman(2)).to eq('II')
      expect(@rn.to_roman(29)).to eq('XXIX')
      expect(@rn.to_roman(38)).to eq('XXXVIII')
      expect(@rn.to_roman(291)).to eq('CCXCI')
      expect(@rn.to_roman(1999)).to eq('MCMXCIX')
      expect(@rn.to_roman(8)).to eq('VIII')
      expect(@rn.to_roman(31)).to eq('XXXI')
      expect(@rn.to_roman(4)).to eq('IV')
      expect(@rn.to_roman(15)).to eq('XV')
    end
  end

  describe '#from_roman' do
    it 'converts Roman number to integer' do
      expect(@rn.from_roman('CM')).to eq(900)
      expect(@rn.from_roman('III')).to eq(3)
      expect(@rn.from_roman('II')).to eq(2)
      expect(@rn.from_roman('XXIX')).to eq(29)
      expect(@rn.from_roman('XXXVIII')).to eq(38)
      expect(@rn.from_roman('CCXCI')).to eq(291)
      expect(@rn.from_roman('MCMXCIX')).to eq(1999)
      expect(@rn.from_roman('VIII')).to eq(8)
      expect(@rn.from_roman('XXXI')).to eq(31)
      expect(@rn.from_roman('IV')).to eq(4)
      expect(@rn.from_roman('XV')).to eq(15)
    end
  end
end
