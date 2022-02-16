# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/board'
require_relative '../../lib/piece'
require_relative '../../lib/pieces/bishop'

describe Bishop do
  describe '#generate_moves' do
    let(:board) { instance_double(Board, square_empty?: true) }
    subject(:bishop) { described_class.new(color: 'white', position: square) }
    context 'when no piece is blocking' do
      context 'when the origin square is D4' do
        let(:square) { 'D4' }
        it 'returns a list containing C3, B2, A1, C5, B6, A7, E5, F6, G7, H8, E3, F2, and G1' do
          moves = %w[C3 B2 A1 C5 B6 A7 E5 F6 G7 H8 E3 F2 G1]
          expect(bishop.generate_moves(board)).to contain_exactly(*moves)
        end
      end

      context 'when the origin square is H1' do
        let(:square) { 'H1' }
        it 'returns a list containing G2, F3, E4, D5, C6, B7, and A8' do
          moves = %w[G2 F3 E4 D5 C6 B7 A8]
          expect(bishop.generate_moves(board)).to contain_exactly(*moves)
        end
      end
    end

    context 'when potential moves are blocked' do
      let(:blocking_piece) { instance_double(Piece, color: 'white') }
      context 'when the origin square is B4 with a blocking piece on C5' do
        let(:square) { 'B4' }
        before do
          allow(board).to receive(:square_empty?).with('C5').and_return(false)
          allow(board).to receive(:piece_at).with('C5').and_return(blocking_piece)
        end

        it 'returns a list containing A5, A3, C3, D2, and E1' do
          moves = %w[A5 A3 C3 D2 E1]
          expect(bishop.generate_moves(board)).to contain_exactly(*moves)
        end
      end

      context 'when the origin square is H8 with a blocking piece on E5' do
        let(:square) { 'H8' }
        before do
          allow(board).to receive(:square_empty?).with('E5').and_return(false)
          allow(board).to receive(:piece_at).with('E5').and_return(blocking_piece)
        end

        it 'returns a list containing G7 and F6' do
          moves = %w[G7 F6]
          expect(bishop.generate_moves(board)).to contain_exactly(*moves)
        end
      end
    end
  end
end
