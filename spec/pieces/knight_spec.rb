# frozen_string_literal: true

require_relative '../../lib/piece'
require_relative '../../lib/pieces/knight'

describe Knight do
  subject(:knight) { described_class.new(color: 'black') }
  describe '#implemented_moves' do
    it 'returns an array with :knight_moves?' do
      moveset = :knight_moves?
      expect(knight.implemented_moves).to contain_exactly(moveset)
    end
  end
end
