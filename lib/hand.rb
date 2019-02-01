require_relative 'card'
class Hand

  POSSIBLE_HANDS = {
    :royal_flush => 27,
    :straight_flush => 26,
    :four_of_a_kind => 25,
    :full_house => 24,
    :flush => 23,
    :straight => 22,
    :three_of_a_kind => 21,
    :two_pair => 21,
    :one_pair => 20
  }
  attr_accessor :cards
  def initialize(cards)
    raise 'must contain 5 cards' unless cards.count == 5
    @cards = cards
    @hand_value = nil
    @matches = []
    @card_values = []
    @cards.sort!
  end

  def to_s
    @cards.join(" ")
  end

  def sort!
    @cards.sort!
  end

  def exchange_cards(old_cards, new_cards)
    raise 'hand must contain 5 cards' if old_cards.count != new_cards.count
    discard_old_cards(old_cards)
    take_new_cards(new_cards)
    old_cards
  end

  def take_new_cards(cards)
    @cards.push(*cards)
  end

  def discard_old_cards(old_cards)
    old_cards.each { |card| @cards.delete(card) }
  end

  def value_count(value)
    @cards.map(&:value).count(value)
  end

  def has_a?(value)
    @cards.map(&:value).include?(value) ||
    @cards.map(&:suit).include?(value)
  end

  def pairs
    pairs = []
    @cards.map(&:value).uniq.each do |val|
      if value_count(val) == 2
        pairs << @cards.select {|card| card.value == val} 
      end
    end
    pairs
  end
  
  def one_pairs
    pairs.count == 1
  end

  def two_pairs
    pairs.count == 2
  end
  
  def three_of_a_kind
    @cards.map(&:value).each do |val|
      return value_count(val) == 3
    end
  end

  def straight
    if @cards.has_a?(:ace) && @cards.has_a?(:two)
      straight = Card.values[0..3] + :ace
    else
      start_pos = Card.values.index(@cards[0].value)
      straight = Card.values[start_pos..(start_pos + 4)] 
    end
    @cards.map(&:value) == straight 
    end

end

