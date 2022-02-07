# frozen_string_literal: true

require_relative '../../lib/piece'
require_relative '../../lib/pieces/bishop'

describe Bishop do
  subject(:bishop) { described_class.new(color: 'white') }
  describe '#moves_diagonally?' do
    it 'returns true' do
      expect(bishop.moves_diagonally?).to be(true)
    end
  end

  describe '#line_moves?' do
    it 'returns true' do
      expect(bishop.line_moves?).to be(true)
    end
  end
end
