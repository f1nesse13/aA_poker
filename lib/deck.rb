require_relative 'card'
class Deck
  attr_reader :cards
  def initialize
    @cards = []
    fill_deck
  end

  private
  
  def fill_deck
    values = [:A, :K, :Q, :J, 10, 9, 8, 7, 6, 5, 4, 3, 2]
    suits = [:S, :C, :H, :D]
    deck = values.map do |val|
            suits.map do |suit|
              @cards << Card.new(val, suit)
            end
          end
    deck
  end

end
