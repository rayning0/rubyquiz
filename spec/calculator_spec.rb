require 'spec_helper'
require 'calculator'

describe Calculator do
  let(:string) { "2 / 2 + 3 * 4 - 6" }
  let(:c) { Calculator.new }

  it "evaluates arithmetic expression correctly, with order of operations" do
    expect(c.evaluate(string)).to eq(7)
    expect(c.evaluate('127')).to eq(127)
    expect(c.evaluate('2 - 3 - 4')).to eq(-5)
    expect(c.evaluate('2 + 3 - 4 + 6 + 2 - 7 - 9')).to eq(-7)
    expect(c.evaluate('2 - 3 * 4 / 6 / 2 * 7 * 7')).to eq(-47)
    expect(c.evaluate('- 2 + 3 * 4 / 3 - 6 / 3 * 3 + 8')).to eq(4)
  end

  describe '#calc' do
    it 'calculates basic +, -, *, / expressions with 2 numbers' do
      expect(c.calc(2, 3, '/')).to eq(0.6666666666666666)
      expect(c.calc(2, 3, '+')).to eq(5)
      expect(c.calc(2, 3, '*')).to eq(6)
      expect(c.calc(2, 3, '-')).to eq(-1)
    end
  end

  describe '#calc_md' do
    it 'calculates only expressions with multiplcation/division' do
      expect(c.calc_md('  3  * 4  / 5  ')).to eq(2.4)
      expect(c.calc_md(' 8  ')).to eq(8)
      expect(c.calc_md('3 * 4 / 6 / 2 * 7 * 7')).to eq(49)
    end
  end
end
