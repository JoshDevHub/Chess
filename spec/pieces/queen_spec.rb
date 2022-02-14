# frozen_string_literal: true

require_relative '../../lib/piece'
require_relative '../../lib/pieces/queen'

describe Queen do
  subject(:queen) { described_class.new(color: 'white') }
  describe '#implemented_moves' do
    it 'returns an array with :moves_up?, :moves_down?, :moves_horizontally?, and :moves_diagonally?' do
      moveset = %i[moves_up? moves_down? moves_horizontally? moves_diagonally?]
      expect(queen.implemented_moves).to contain_exactly(*moveset)
    end
  end

  describe '#line_moves?' do
    it 'returns true' do
      expect(queen.line_moves?).to be(true)
    end
  end
end
