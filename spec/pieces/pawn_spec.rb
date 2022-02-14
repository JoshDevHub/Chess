# frozen_string_literal: true

require_relative '../../lib/piece'
require_relative '../../lib/pieces/pawn'

describe Pawn do
  subject(:white_pawn) { described_class.new(color: 'white') }
  subject(:black_pawn) { described_class.new(color: 'black') }

  describe '#implemented_moves' do
    context 'when the pawn is a white colored pawn' do
      it 'returns an array with :moves_up?' do
        moveset = :moves_up?
        expect(white_pawn.implemented_moves).to contain_exactly(moveset)
      end
    end

    context 'when the pawn is a black colored pawn' do
      it 'returns an array with :moves_down?' do
        moveset = :moves_down?
        expect(black_pawn.implemented_moves).to contain_exactly(moveset)
      end
    end
  end
end
