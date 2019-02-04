require 'rspec'
require 'player'

describe Player do
  subject(:player) { Player.new}
  
  let(:new_hand) do
    Hand.new([
      Card.new(:king, :hearts),
      Card.new(:king, :diamonds),
      Card.new(:queen, :spades),
      Card.new(:ten, :clubs),
      Card.new(:ten, :spades)
    ])
  end
  let(:card1) {Card.new(:four, :hearts)}
  let(:card2) {Card.new(:five, :diamonds)}
  
  describe '#initialized' do
    it "initializes with $100 by default" do
      expect(player.bank).to eq(100)
    end
  end

  describe '#deal_hand' do
    it 'deals the player a new hand' do
      player.deal_hand(new_hand)
      expect(player.hand).to eq(new_hand)
    end
  end
  
  describe '#return_cards' do
    let(:hand) { double('hand') }
    let(:cards) { double('cards') }

    before(:each) do
      player.deal_hand(hand)
      allow(hand).to receive(:cards).and_return(cards)
    end

    it 'should return the players cards' do
      expect(player.return_cards).to eq(cards)
    end
    
    it 'should set the players hand to nil' do
      player.return_cards
      expect(player.hand).to be(nil)
    end

  end


  describe '#call' do
    it 'places a bet of 0' do
      player.place_bet(0)
      expect(player.bank).to eq(100)
    end
  end

  describe '#folded?' do
    it 'takes the player out of the current round' do
      player.fold
      expect(player.folded?).to eq(true)
    end

    it 'resets the fold' do
      player.reset_fold
      expect(player.folded?).to eq(false)
    end 
  end

  describe '#place_bet' do
    it 'subtracts bet from bank input' do
      player.place_bet(50)
      expect(player.bank).to eq(50)
    end
  end

end