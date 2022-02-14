# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/move'
require_relative '../../lib/moves/move_up'
require_relative '../../lib/piece'
require_relative '../../lib/board'

describe MoveUp do
  describe '#generate_moves' do
    context 'when the piece can only move one square' do
      let(:piece) { instance_double(Piece, line_moves?: false, color: 'white') }
      context 'when no square is blocked' do
        let(:board) { instance_double(Board, square_empty?: true) }
        subject(:one_mover) { described_class.new(board: board, piece: piece) }
        context 'when the starting square is G2' do
          let(:square) { 'G2' }
          it 'returns a list with G3' do
            moves = %w[G3]
            expect(one_mover.generate_moves(square)).to contain_exactly(*moves)
          end
        end

        context 'when the starting square is H8' do
          let(:square) { 'H8' }
          it 'returns an empty array' do
            expect(one_mover.generate_moves(square)).to be_empty
          end
        end
      end
    end
  end
end
