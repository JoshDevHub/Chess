# frozen_string_literal: true

require_relative '../../lib/piece'
require_relative '../../lib/pieces/bishop'

describe Bishop do
  subject(:bishop) { described_class.new(color: 'white') }
  describe '#implemented_moves' do
    it 'returns an array with :moves_diagonally?' do
      moveset = :moves_diagonally?
      expect(bishop.implemented_moves).to contain_exactly(moveset)
    end
  end

  describe '#line_moves?' do
    it 'returns true' do
      expect(bishop.line_moves?).to be(true)
    end
  end
end
