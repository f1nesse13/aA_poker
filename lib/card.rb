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
    @card_value = find_value(@value)
  end

  def to_s
    "|#{CARD_VALUES[value]}#{CARD_SUITS[suit]}|"
  end

  private

  def find_value(value)
    card_values = {
      :two => 2,
      :three => 3,
      :four => 4,
      :five => 5,
      :six => 6,
      :seven => 7,
      :eight => 8,
      :nine => 9,
      :ten => 10,
      :jack => 11,
      :queen => 12,
      :king => 13,
      :ace => 14
    }
    card_values[@value]
  end

end
