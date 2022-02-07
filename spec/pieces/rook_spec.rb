# frozen_string_literal: true

require_relative '../../lib/piece'
require_relative '../../lib/pieces/rook'

describe Rook do
  subject(:rook) { described_class.new(color: 'black') }
  describe '#moves_up?' do
    it 'returns true' do
      expect(rook.moves_up?).to be(true)
    end
  end

  describe '#moves_down?' do
    it 'returns true' do
      expect(rook.moves_down?).to be(true)
    end
  end

  describe '#moves_horizontally?' do
    it 'returns true' do
      expect(rook.moves_horizontally?).to be(true)
    end
  end

  describe '#line_moves?' do
    it 'returns true' do
      expect(rook.line_moves?).to be(true)
    end
  end
end
