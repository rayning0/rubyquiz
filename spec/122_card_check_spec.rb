require '122_card_check'
require 'spec_helper'

describe CardCheck do
  let(:c) { CardCheck.new }

  describe '#card_check' do
    it 'returns a list' do
      c.card_check('1').class.should eq(Array)
    end

    it 'correctly identifies an invalid card' do
      result = c.card_check('1')
      result[0].should eq('unknown')
      result[1].should eq('invalid')
    end

    it 'correctly identifies visa cards' do
      cards = %w(4539525598576146 4716016802653546)
      cards.each do |card|
        result = c.card_check(card)
        result[0].should eq('visa')
        result[1].should eq('valid')
      end
    end

    it 'correctly identifies mastercards' do
      cards = %w(5421884638451606 5206355609152441)
      cards.each do |card|
        result = c.card_check(card)
        result[0].should eq('mastercard')
        result[1].should eq('valid')
      end
    end

    it 'correctly identifies americanexpress cards' do
      cards = %w(373000624988415 342458690063208)
      cards.each do |card|
        result = c.card_check(card)
        result[0].should eq('americanexpress')
        result[1].should eq('valid')
      end
    end
    it 'correctly identifies discover cards' do
      cards = %w(6011633808627972 6011956740671844)
      cards.each do |card|
        result = c.card_check(card)
        result[0].should eq('discover')
        result[1].should eq('valid')
      end
    end
  end
end
