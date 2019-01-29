require 'rspec'
require 'card'

describe Card do
  subject(:card) { Card.new(4, 'S') }
  describe '#initialize' do

    it 'initializes with a value' do
      expect(card.value).to eq(4)
    end
    
    it 'initializes with a suit' do
      expect(card.suit).to eq('S')
    end
  end
end