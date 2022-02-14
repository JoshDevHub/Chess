# frozen_string_literal: true

require_relative '../../lib/piece'
require_relative '../../lib/pieces/rook'

describe Rook do
  subject(:rook) { described_class.new(color: 'black') }
  describe '#implemented_moves' do
    it 'returns an array with :moves_up?, :moves_down?, and :moves_horizontally?' do
      moveset = %i[moves_up? moves_down? moves_horizontally?]
      expect(rook.implemented_moves).to contain_exactly(*moveset)
    end
  end

  describe '#line_moves?' do
    it 'returns true' do
      expect(rook.line_moves?).to be(true)
    end
  end
end
