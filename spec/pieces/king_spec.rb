# frozen_string_literal: true

require_relative '../../lib/piece'
require_relative '../../lib/pieces/king'

describe King do
  subject(:king) { described_class.new(color: 'black') }
  describe '#moves_diagonally?' do
    it 'returns true' do
      expect(king.moves_diagonally?).to be(true)
    end
  end

  describe '#moves_horizontally?' do
    it 'returns true' do
      expect(king.moves_horizontally?).to be(true)
    end
  end

  describe '#moves_up?' do
    it 'returns true' do
      expect(king.moves_up?).to be(true)
    end
  end

  describe '#moves_down?' do
    it 'returns true' do
      expect(king.moves_down?).to be(true)
    end
  end
end
