require 'spec_helper'
require 'top_3_words'

describe Top3Words do
  let(:t) { Top3Words.new }

  describe '#top_3_words' do
    it '' do
      expect(t.top_3_words("In a village of La Mancha, the name of which I have no desire to call to mind, there lived not long since one of those gentlemen that keep a lance in the lance-rack, an old buckler, a lean hack, and a greyhound for coursing. An olla of rather more beef than mutton, a salad on most nights, scraps on Saturdays, lentils on Fridays, and a pigeon or so extra on Sundays, made away with three-quarters of his income.")).to eq(["a", "of", "on"])
      expect(t.top_3_words("e e e e DDD ddd DdD: ddd ddd aa aA Aa, bb cc cC e e e")).to eq(["e", "ddd", "aa"])
      expect(t.top_3_words("  //wont won't won't")).to eq(["won't", "wont"])
    end
  end
end
