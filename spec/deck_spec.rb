require 'rspec'
require 'deck'

describe Deck do
  subject(:deck) { Deck.new }
  describe '#initialize' do

    it 'initializes with 52 cards' do
      expect(deck.cards.count).to eq(52)
    end
  end
end