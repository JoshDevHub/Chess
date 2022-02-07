# frozen_string_literal: true

require_relative '../../lib/piece'
require_relative '../../lib/pieces/pawn'

describe Pawn do
  subject(:white_pawn) { described_class.new(color: 'white') }
  subject(:black_pawn) { described_class.new(color: 'black') }
  describe '#moves_up?' do
    context 'when the pawn is a white colored pawn' do
      it 'returns true' do
        expect(white_pawn.moves_up?).to be(true)
      end
    end

    context 'when the pawn is a black colored pawn' do
      it 'returns false' do
        expect(black_pawn.moves_up?).to be(false)
      end
    end
  end

  describe '#moves_down?' do
    context 'when the pawn is a white colored pawn' do
      it 'returns false' do
        expect(white_pawn.moves_down?).to be(false)
      end
    end

    context 'when the pawn is a black colored pawn' do
      it 'returns true' do
        expect(black_pawn.moves_down?).to be(true)
      end
    end
  end
end
