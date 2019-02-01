require_relative 'card'
require_relative 'hand'
class Deck
  def self.fill_deck
    values = [:ace, :king, :queen, :jack, :ten, :nine, :eight, :seven, :six, :five, :four, :three, :two]
    suits = [:spades, :clubs, :hearts, :diamonds]
    deck = []
    values.map do |val|
      suits.map do |suit|
        deck << Card.new(val, suit)
      end
    end
    deck
  end
  attr_reader :cards
  
  def initialize(cards=Deck.fill_deck)
    @cards = cards
  end

  def deal_hand
    Hand.new(take_cards(5))
  end

  def take_cards(n)
    raise 'not enough cards' if n > @cards.count
    @cards.shift(n)
  end

  def shuffle_deck
    @cards.shuffle!
  end
  
  def return_cards(cards)
    @cards.push(*cards)
  end

end