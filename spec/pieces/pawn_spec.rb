# frozen_string_literal: true

require_relative '../../lib/piece'
require_relative '../../lib/pieces/pawn'

describe Pawn do
  describe '#moves_up?' do
    context 'when the pawn is a white colored pawn' do
      subject(:white_pawn) { described_class.new(color: 'white') }
      it 'returns true' do
        expect(white_pawn.moves_up?).to be(true)
      end
    end

    context 'when the pawn is a black colored pawn' do
      subject(:black_pawn) { described_class.new(color: 'black') }
      it 'returns false' do
        expect(black_pawn.moves_up?).to be(false)
      end
    end
  end
end
