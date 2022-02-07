# frozen_string_literal: true

require_relative '../../lib/piece'
require_relative '../../lib/pieces/queen'

describe Queen do
  subject(:queen) { described_class.new(color: 'white') }
  describe '#moves_diagonally?' do
    it 'returns true' do
      expect(queen.moves_diagonally?).to be(true)
    end
  end

  describe '#moves_horizontally?' do
    it 'returns true' do
      expect(queen.moves_horizontally?).to be(true)
    end
  end

  describe '#moves_up?' do
    it 'returns true' do
      expect(queen.moves_up?).to be(true)
    end
  end

  describe '#moves_down?' do
    it 'returns true' do
      expect(queen.moves_down?).to be(true)
    end
  end

  describe '#line_moves?' do
    it 'returns true' do
      expect(queen.line_moves?).to be(true)
    end
  end
end
