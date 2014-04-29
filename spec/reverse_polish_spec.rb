require 'spec_helper'
require 'reverse_polish'

describe ReversePolish do
  let (:rp) { ReversePolish.new }
  it 'converts Reverse Polish notation to an integer' do
    expect(rp.calc('')).to eq(0)
    expect(rp.calc('3.5')).to eq(3.5)
    expect(rp.calc('5 1 2 + 4 * + 3 -')).to eq(14)
  end
end
