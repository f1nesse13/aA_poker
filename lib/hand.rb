require_relative 'deck'

class Hand
attr_accessor :cards
  def initialize(cards)
    @cards = cards.sort
  end

  def exchange_cards(old_cards, new_cards)
    raise 'hand must contain 5 cards' if old_cards.count != new_cards.count
    discard_old_cards(old_cards)
    take_new_cards(new_cards)
    @cards.sort!
  end

  def take_new_cards(cards)
    @cards.push(*cards)
  end

  def discard_old_cards(old_cards)
    old_cards.each { |card| @cards.delete(card) }
  end

  def sort!
    @cards.sort!
  end

end