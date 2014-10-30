require 'spec_helper'
require 'product'

describe Product do
  let(:p) { Product.new }

  describe '#get_products' do
    it 'finds product of all integers EXCEPT integer at that index' do
      expect(p.get_products([1, 7, 3, 4])).to eq([84, 12, 28, 21])
    end
  end
end
