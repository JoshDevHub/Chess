# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/move'
require_relative '../../lib/moves/diagonal_moves'

describe DiagonalMoves do
  describe '#generate_moves' do
    context 'when the piece can only move in one step' do
      let(:piece) { double(line_moves?: false) }
      let(:board) { double(square_empty?: true) }
      subject(:one_diagonal) { described_class.new(board: board, piece: piece) }
      context 'when the origin square is C4 and no target is blocked' do
        let(:square) { 'C4' }
        it 'returns a list containing D3, B3, B5, and D5' do
          moves = %w[D3 B3 B5 D5]
          expect(one_diagonal.generate_moves(square)).to contain_exactly(*moves)
        end
      end
    end
  end
end
