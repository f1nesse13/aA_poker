require 'rspec'
require 'hand'

describe Hand do
  subject(:hand) { Hand.new }

  describe '#initialize' do
    describe 'contains 5 cards' do
      expect(hand.cards.count).to eq(5)
    end
  end

  describe '#hand_values' do
    hand.cards = [2,2,3,13,10]
    it 'calculates a pair'
    expect 
  end
end