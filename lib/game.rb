require_relative 'player'
require_relative 'deck'
class Game
  
attr_reader :players, :pot, :deck
  
  def initialize
    @pot = 0
    @deck = Deck.new
    @players = [] 
  end  

  def play
    play_round until game_over?
    "Game over!"
  end

  def play_round
    deck.shuffle_deck
    ready_players
    deal_cards
    take_bets
    trade_cards
    take_bets
    round_end
  end

  def add_players(n, buy_in)
    n.times { |player| @players << Player.buy_in(buy_in) }
  end

  def deal_cards
    players.each do |player|
      next if player.bank <= 0 
      player.deal_hand(deck.deal_hand) 
    end
  end

  def trade_cards
    players.each_with_index do |player, i|
      next if player.folded?
      print "Player #{i + 1}, which cards do you want to trade: "
      puts player.hand
      cards = player.ask_for_discard
      deck.return_cards(cards)
      player.discard_cards(cards, deck.take(cards.count))
    end
  end

  def ready_players
    players.each(&:reset_fold)
  end

  def round_over?
    players.count { |player| !player.folded? } <= 1
  end
  
  def game_over?
    players.count { |player| player.bank > 0} <= 1
  end

  def add_to_pot(amount)
    @pot += amount
  end

  def show_display(index, high_bet)
    puts "Pot: #{@pot}"
    puts "High bet: #{high_bet}"

    players.each_with_index do |player, i|
      puts "Player #{i + 1} has #{player.bank}"
    end

    puts
    puts "Current player: #{index + 1}"
    puts "Player #{index + 1} has bet: $#{players[index].current_bet}"
    puts "The bet is at $#{high_bet}"
    puts "Player #{index + 1}'s hand: #{players[index].hand}"
  end

  def take_bets
    players.each(&:reset_current_bet)

    high_bet = 0
    no_raises = true
    most_recent_better = nil

    until no_raises
      players.each_with_index do |player, i|
        break if most_recent_better == player || round_over?

        show_display(i, high_bet)

        begin
          choice = player.get_choice
          case choice
          when :call
           add_to_pot(player.place_bet(high_bet))
          when :bet
            raise 'not enough money' unless player.bank >= high_bet
            no_raises = false
            most_recent_better = player
            bet = player.ask_for_bet
            raise "Bet must be at least $#{high_bet}" unless bet >= high_bet
            high_bet = bet
            raise_bet = player.place_bet(bet)
            add_to_pot(raise_bet)
          when :fold
            player.fold
          end
        rescue => e
          puts "#{e.message}"
          retry
        end
      end
    end
  end

  def reveal_hands
    players.each do |player|
      next if player.folded?
      puts "#{player.hand} #{Hand::POSSIBLE_HANDS[player.hand.best_hand]}"
    end
  end

  def round_end(pos)
    reveal_hands
    puts "winner is #{winner.hand} winning $#{pot} with a #{Hand::POSSIBLE_HANDS[winner.hand.best_hand]}"
    winner.collect_winnings(@pot)
    @pot = 0
  end

  def winner
    players.max
  end

end

if $PROGRAM_NAME == __FILE__
  new_game = Game.new
  new_game.add_players(3, 100)
  new_game.play

end