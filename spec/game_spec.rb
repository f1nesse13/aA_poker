require 'rspec'
require 'game'

describe Game do
  let(:name1) {Player.new}
  let(:name2) {Player.new}
  subject(:game) { Game.new }
  before(:each) { game.add_player(3, 100)}
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

end