require 'rspec'
require 'hand'
require 'card'

describe Hand do
  let(:cards) {[
    Card.new(:two, :diamonds),
    Card.new(:two, :hearts),
    Card.new(:five, :hearts ),
    Card.new(:ten, :spades),
    Card.new(:ace, :hearts)
  ]}
  subject(:hand) { Hand.new(cards) }
  
  describe '#initialize' do
    it 'receives cards correctly' do
      expect(hand.cards).to match_array(cards)
    end
    it 'contains 5 cards' do
      expect(hand.cards.count).to eq(5)
    end
    it 'throws a error if not 5 cards' do
      expect do
        Hand.new(cards[0..1])
    end.to raise_error("must contain 5 cards")
  end
end

  describe '#exchange_cards' do
    let!(:old_cards) { hand.cards[0..1] }
    let!(:new_cards) { [Card.new(:spades, :five), Card.new(:clubs, :three)] }
    before(:each) {
      hand.exchange_cards(old_cards, new_cards)
    }
    it 'discards specified cards' do
      expect(hand.cards).to_not include(*old_cards)
    end

    it 'takes specific cards' do
      expect(hand.cards).to include(*new_cards)
    end
  end

  describe 'possible hands' do
    let(:royal_flush) do
      Hand.new([
        Card.new(:ace, :spades),
        Card.new(:king, :spades),
        Card.new(:queen, :spades),
        Card.new(:jack, :spades),
        Card.new(:ten, :spades)
      ])
    end

    let(:straight_flush) do
      Hand.new([
        Card.new(:eight, :spades),
        Card.new(:seven, :spades),
        Card.new(:six, :spades),
        Card.new(:five, :spades),
        Card.new(:four, :spades)
      ])
    end

    let(:four_of_a_kind) do
      Hand.new([
        Card.new(:ace, :spades),
        Card.new(:ace, :hearts),
        Card.new(:ace, :diamonds),
        Card.new(:ace, :clubs),
        Card.new(:ten, :spades)
      ])
    end

    let(:full_house) do
      Hand.new([
        Card.new(:ace, :spades),
        Card.new(:ace, :clubs),
        Card.new(:king, :spades),
        Card.new(:king, :hearts),
        Card.new(:king, :diamonds)
      ])
    end

    let(:flush) do
      Hand.new([
        Card.new(:four, :spades),
        Card.new(:seven, :spades),
        Card.new(:ace, :spades),
        Card.new(:two, :spades),
        Card.new(:eight, :spades)
      ])
    end

    let(:straight_no_ace) do
      Hand.new([
        Card.new(:king, :hearts),
        Card.new(:queen, :hearts),
        Card.new(:jack, :diamonds),
        Card.new(:ten, :clubs),
        Card.new(:nine, :spades)
      ])
    end

    let(:straight_with_ace) do
      Hand.new([
        Card.new(:two, :hearts),
        Card.new(:three, :hearts),
        Card.new(:four, :diamonds),
        Card.new(:five, :clubs),
        Card.new(:ace, :spades)
      ])
    end

    let(:three_of_a_kind) do
      Hand.new([
        Card.new(:three, :spades),
        Card.new(:three, :diamonds),
        Card.new(:three, :hearts),
        Card.new(:jack, :spades),
        Card.new(:ten, :spades)
      ])
    end

    let(:two_pair) do
      Hand.new([
        Card.new(:king, :hearts),
        Card.new(:king, :diamonds),
        Card.new(:queen, :spades),
        Card.new(:ten, :clubs),
        Card.new(:ten, :spades)
      ])
    end

    let(:one_pair) do
      Hand.new([
        Card.new(:ace, :spades),
        Card.new(:ace, :clubs),
        Card.new(:queen, :hearts),
        Card.new(:jack, :diamonds),
        Card.new(:ten, :hearts)
      ])
    end

    let(:high_card) do
      Hand.new([
        Card.new(:two, :spades),
        Card.new(:four, :hearts),
        Card.new(:six, :diamonds),
        Card.new(:nine, :spades),
        Card.new(:ten, :spades)
      ])
    end
    let(:hand_points) do
      [
        :royal_flush,
        :straight_flush,
        :four_of_a_kind,
        :full_house,
        :flush,
        :straight,
        :three_of_a_kind,
        :two_pair,
        :one_pair
      ]
    end
    
    describe '#one_pair' do
      it 'identifies a pair' do
        expect(one_pair.one_pair?).to eq(true)
      end
    end
    describe '#two_pair' do
      it 'identifies two-pair' do
        expect(two_pair.two_pair?).to eq(true)
      end
    end

    describe 'three_of_a_kind' do
      it 'identifies three of a kind' do
        expect(three_of_a_kind.three_of_a_kind?).to eq(true)
      end
    end
    
    describe '#straight' do
      it 'identifies a straight w/o ace' do
        expect(straight_no_ace.straight?).to eq(true)
      end
    
      it 'identifies a straight with ace' do
        expect(straight_with_ace.straight?).to eq(true)
      end
    end

    describe '#flush' do 
      it 'identifies a flush' do
        expect(flush.flush?).to eq(true)
      end
    end

    describe '#full_house' do
      it 'identifies a full house' do
        expect(full_house.full_house?).to eq(true)
      end
    end

    describe '#four_of_a_kind' do
      it 'identifies four of a kind' do
        expect(four_of_a_kind.four_of_a_kind?).to eq(true)
      end
    end

    describe '#straight_flush' do
      it 'identifies a straight flush' do
        expect(straight_flush.straight_flush?).to eq(true)
      end
    end

    describe '#royal_flush' do
      it 'identifies a royal flush' do
        expect(royal_flush.royal_flush?).to eq(true)
      end
    end

    describe '#best_hand' do
      it 'returns the index of the best hand' do
        expect(flush.best_hand).to eq(4)
      end
    end

  end

end