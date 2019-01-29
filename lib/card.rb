class Card
  attr_reader :value, :suit
  def initialize(value, suit)
    @value = value
    @suit = suit
    @card_values = {
      :J => 11,
      :Q => 12,
      :K => 13,
      :A => [1, 14]
    }
  end

  def to_s
    "|#{value}#{suit}|"
  end

end