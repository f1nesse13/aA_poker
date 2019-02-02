require 'rspec'
require 'player'

describe Player do
  subject(:player) {Player.new}
  describe '#initialized' do
    it "initializes with $100 by default" do
      expect(player.bank).to eq(100)
    end
  end

  describe '#discard_cards' do
    it 'discards selected cards and receives new ones' do
      initial = player
      subject.discard_cards(1, 3)
      expect(player.hand).to_not match_array(initial) 
    end
  end

  describe '#call' do
    it 'places a bet of 0' do
      player.bet(0)
      expect(player.bank).to eq(100)
    end
  end

  describe '#fold' do
    it 'takes the player out of the current round' do
      player.fold
      expect(player.folded).to eq(true)
    end
  end

  describe '#place_bet' do
    player.bet(50)
    it 'subtracts bet from bank input' do
      expect(player.bank).to eq(50)
    end
  end

end