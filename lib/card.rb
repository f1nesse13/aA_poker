class Card
  attr_reader :value, :suit, :card_value
  CARD_SUITS = {
    :clubs    => "♣",
    :diamonds => "♦",
    :hearts   => "♥",
    :spades   => "♠"
  }
  CARD_VALUES = {
    :two   => "2",
    :three => "3",
    :four  => "4",
    :five  => "5",
    :six   => "6",
    :seven => "7",
    :eight => "8",
    :nine  => "9",
    :ten   => "10",
    :jack  => "J",
    :queen => "Q",
    :king  => "K",
    :ace   => "A"
  }
  def self.suits
    CARD_SUITS.keys
  end
  def self.values
    CARD_VALUES.keys
  end
  def self.royal_values
    CARD_VALUES.keys[-5..-1]
  end
  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def to_s
    "|#{CARD_VALUES[value]}#{CARD_SUITS[suit]}|"
  end

  def ==(next_card)
    (self.value == next_card.value) &&
    (self.suit == next_card.suit)
  end

  def <=>(next_card)
    if self == next_card
      0
    elsif self.value != next_card.value
      Card.values.index(value) <=> Card.values.index(next_card.value)
    elsif self.suit != next_card.suit
      Card.suits.index(suit) <=> Card.suits.index(next_card.suit)
    end
  end

end
