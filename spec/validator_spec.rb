require 'validator'
require 'spec_helper'

describe Validator do
  let(:s) {Validator.new("{ [ ] ( ) }")}
  let(:t) {Validator.new("{ [ ( ] ) }")}
  let(:u) {Validator.new("{ [ }")}

  describe "#validates" do
    it "check if a string's openers and closers are properly nested" do
      expect(s.validates).to be_true
      expect(t.validates).to be_false
      expect(u.validates).to be_false
    end
  end
end