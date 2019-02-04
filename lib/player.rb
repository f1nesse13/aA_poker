require_relative 'hand'
class Player
  attr_reader :current_bet
  attr_accessor :hand, :cards, :bank

  def self.buy_in(bank)
      Player.new(bank)
  end

  def initialize(bank=100)
    @bank = bank
    @current_bet = 0
  end

  def deal_hand(hand)
    @hand = hand
  end

  def get_choice
    puts "Would you like to call, bet or fold? (use c, b or f)"
    choice = gets.chomp
    case choice
      when 'c' then :call
      when 'b' then :bet
      when 'f' then :fold
      else
        puts 'You must respond with c, b or f'
        get_choice
      end
  end

  def ask_for_bet
    puts "How much would you like to bet? (Bank: #{bank})"
    bet_input = gets.chomp.to_i
    raise 'not enough money' if bet_input > bank
    bet_input 
  end

  def ask_for_discard
    puts "Select which cards you'd like to discard (1,2,3 etc.)"
    input = gets.chomp.split(", ").map(&:to_i)
    if input == ""
      []
    else
      cards = input.map do |index|
        hand.cards[index-1]
      end
    end
    cards
  end

  def discard_cards(old_cards, new_cards)
    hand.exchange_cards(old_cards, new_cards)
  end

  def call
    place_bet(0)
  end

  def return_cards
    cards = hand.cards
    @hand = nil
    cards
  end

  def place_bet(bet)
    total = bet - @current_bet
    raise 'not enough money' if total > bank
    @current_bet = bet
    @bank -= total
    total
  end

  def folded?
    @folded
  end

  def fold
    @folded = true
  end

  def reset_fold
    @folded = false
  end

  def reset_current_bet
    @current_bet = 0
  end

  def collect_winnings(total)
    @bank += total
  end
    
  def <=>(other_player)
    self.hand <=> other_player.hand
  end

end
