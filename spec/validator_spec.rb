require 'validator'
require 'spec_helper'

describe Validator do
  let(:s) {Validator.new("{ [ ] ( ) }")}
  let(:t) {Validator.new("{ [ ( ] ) }")}
  let(:u) {Validator.new("{ [ }")}

  describe "#validates" do
    it "check if a string's openers and closers are properly nested" do
      expect(s.validates).to eq(true)
      expect(t.validates).to eq(false)
      expect(u.validates).to eq(false)
    end
  end
end