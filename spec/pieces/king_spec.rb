# frozen_string_literal: true

require_relative '../../lib/piece'
require_relative '../../lib/pieces/king'

describe King do
  subject(:king) { described_class.new(color: 'black') }
  describe '#implemented_moves' do
    it 'returns an array with :moves_diagonally?, :moves_up?, :moves_down?, and moves_horizontally?' do
      moveset = %i[moves_diagonally? moves_up? moves_down? moves_horizontally?]
      expect(king.implemented_moves).to contain_exactly(*moveset)
    end
  end
end
