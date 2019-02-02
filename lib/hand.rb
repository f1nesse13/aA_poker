require_relative 'card'
class Hand

  POSSIBLE_HANDS = [
    :royal_flush?,
    :straight_flush?,
    :four_of_a_kind?,
    :full_house?,
    :flush?,
    :straight?,
    :three_of_a_kind?,
    :two_pair?,
    :one_pair?,
    :high_card?
  ]
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

  def best_hand
    # iterates thru POSSIBLE_HANDS and returns the index if the method call returns true
    POSSIBLE_HANDS.each do |method|
      return POSSIBLE_HANDS.index(method) if self.send(method)
    end
  end

  def value_count(value)
    #helper method to get the number of values in a hand
    @cards.map(&:value).count(value)
  end

  def has_a?(value)
    @cards.map(&:value).include?(value) || @cards.map(&:suit).include?(value)
  end

  def pairs
    # helper method for one_pair? and two_pair? - creates an array of cards that are pairs
    pairs = []
    @cards.map(&:value).uniq.each do |val|
      if value_count(val) == 2
        pairs << @cards.select {|card| card.value == val}
      end
    end
    pairs
  end

  def high_card?
    true
  end

  def one_pair?
    pairs.count == 1
  end

  def two_pair?
    pairs.count == 2
  end

  def three_of_a_kind?
    @cards.map(&:value).any? { |val| value_count(val) == 3 }
  end

  def straight?
    if has_a?(:ace) && has_a?(:two)
      straight = Card.values[0..3] + [:ace]
    else
      start_pos = Card.values.index(@cards[0].value)
      straight = Card.values[start_pos..(start_pos + 4)]
    end
    @cards.map(&:value) == straight
  end

  def flush?
    @cards.map(&:suit).uniq.count == 1
  end

  def full_house?
    one_pair? && three_of_a_kind?
  end

  def four_of_a_kind?
    @cards.map(&:value).any? { |val| value_count(val) == 4 }
  end

  def straight_flush?
    straight? && flush?
  end

  def royal_flush?
    straight_flush? && (@cards.map(&:value) == Card.royal_values)
  end

end

