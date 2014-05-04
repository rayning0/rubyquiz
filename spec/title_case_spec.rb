require 'spec_helper'
require 'title_case'

describe TitleCase do
  let(:t) { TitleCase.new }

  describe '#title_case' do
    it 'convert a string into title case, given an optional list of exceptions (minor words)' do
      expect(t.title_case('a clash of KINGS', 'a an the of')).to eq('A Clash of Kings')
      expect(t.title_case('THE WIND IN THE WILLOWS', 'The In')).to eq('The Wind in the Willows')
      expect(t.title_case('the quick brown fox')).to eq('The Quick Brown Fox')
    end
  end
end
