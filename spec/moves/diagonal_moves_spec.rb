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

      context 'when the origin square is H8 and no target is blocked' do
        let(:square) { 'H8' }
        it 'returns a list containing G7' do
          moves = %w[G7]
          expect(one_diagonal.generate_moves(square)).to contain_exactly(*moves)
        end
      end

      context 'when the origin square is F1 and no target is blocked' do
        let(:square) { 'F1' }
        it 'returns a list containing E2 and G2' do
          moves = %w[E2 G2]
          expect(one_diagonal.generate_moves(square)).to contain_exactly(*moves)
        end
      end

      context 'when the origin square is B5 and C6 is blocked' do
        let(:piece) { double(line_moves?: false, color: 'white') }
        let(:blocking_piece) { double(color: 'white') }
        let(:square) { 'B5' }
        before do
          allow(board).to receive(:square_empty?).with('C6').and_return(false)
          allow(board).to receive(:piece_at).with('C6').and_return(blocking_piece)
        end

        it 'returns a list containing A6, A4, and C4' do
          moves = %w[A6 A4 C4]
          expect(one_diagonal.generate_moves(square)).to contain_exactly(*moves)
        end
      end
    end

    context 'when the piece is a line piece' do
      let(:piece) { double(line_moves?: true) }
      let(:board) { double(square_empty?: true) }
      subject(:line_mover) { described_class.new(board: board, piece: piece) }
      context 'when the origin square is D4 and no target is blocked' do
        let(:square) { 'D4' }
        it 'returns a list containing C3, B2, A1, C5, B6, A7, E5, F6, G7, H8, E3, F2, and G1' do
          moves = %w[C3 B2 A1 C5 B6 A7 E5 F6 G7 H8 E3 F2 G1]
          expect(line_mover.generate_moves(square)).to contain_exactly(*moves)
        end
      end
      context 'when the origin square is H1 and no target is blocked' do
        let(:square) { 'H1' }
        it 'returns a list containing G2, F3, E4, D5, C6, B7, and A8' do
          moves = %w[G2 F3 E4 D5 C6 B7 A8]
          expect(line_mover.generate_moves(square)).to contain_exactly(*moves)
        end
      end
    end
  end
end
