require 'rspec'
require 'deck'

describe Deck do

  subject(:deck) { Deck.new }
  
  describe '#initialize' do
    it 'initializes with 52 cards' do
      expect(deck.cards.count).to eq(52)
    end
  end

  describe '#take_cards' do
    it 'removes cards from the deck' do
      deck.take_cards(2)
      expect(deck.cards.count).to eq(50)
    end

    it 'will not give more cards then are left in the deck' do
      deck.take_cards(50)
      expect {deck.take_cards(3)}.to raise_error("not enough cards")
    end
  end

  describe '#shuffle_deck' do
    it 'shuffles the deck' do
      deck = Deck.new
      deck2 = deck.shuffle_deck
      expect(deck).to_not eq(deck2)
    end
  end
 
end