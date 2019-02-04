require_relative 'player'
class Game
  
attr_reader :players, :pot, :deck
  
  def initialize
    @pot = 0
    @deck = Deck.new
    @players = [] 
  end  

  def add_player(n, buy_in)
    n.times { |player| @players << Player.buy_in(buy_in) }
  end

  def deal_cards
    players.each do |player|
      next if player.bank <= 0 
      player.deal_hand(deck.deal_hand) 
    end
  end

end