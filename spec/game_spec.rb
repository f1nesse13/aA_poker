require 'rspec'
require 'game'

describe Game do
  let(:name1) {Player.new}
  let(:name2) {Player.new}
  subject(:game) { Game.new }
  before(:each) { game.add_players(3, 100)}
  
  describe '#initialize' do
    it 'adds all players to the player array' do
      expect(game.players).to_not be_empty
    end
  end

  describe '#deal_cards' do
    it 'deals each player 5 cards' do
      game.deal_cards
      # checks that the first and last players have 5 cards
      expect(game.players[0].hand.cards.count).to eq(5)
      expect(game.players[1].hand.cards.count).to eq(5)
    end
  end

  describe '#add_players' do
    it 'should create  number of players' do
      expect(game.players.count).to eq(3)
    end

    it 'should create players' do
      expect(game.players.first).to be_a(Player)
    end

    it 'should set the players bank' do
      expect(
        game.players.all? { |player| player.bank == 100 }
      ).to be(true)
    end
  end

  describe '#game_over' do
    it 'returns true if theres only one player with money' do
      game.players[0].bank = 0
      game.players[1].bank = 0
      expect(game.game_over?).to eq(true)
    end
  end

end