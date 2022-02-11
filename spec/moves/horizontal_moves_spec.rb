# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/move'
require_relative '../../lib/moves/horizontal_moves'

describe HorizontalMoves do
  describe '#generate_moves' do
    context 'when the piece can only move one square' do
      let(:piece) { double(line_moves?: false) }
      context 'when no square is blocked' do
        let(:board) { double(square_empty?: true) }
        subject(:one_mover) { described_class.new(board: board, piece: piece) }
        context 'when the starting square is C3' do
          let(:square) { 'C3' }
          it 'returns a list containing D4 and B4' do
            moves = %w[D3 B3]
            expect(one_mover.generate_moves(square)).to contain_exactly(*moves)
          end
        end

        context 'when the starting square is H1' do
          let(:square) { 'H1' }
          it 'returns a list containing G1' do
            moves = %w[G1]
            expect(one_mover.generate_moves(square)).to contain_exactly(*moves)
          end
        end
      end
    end
  end
end
