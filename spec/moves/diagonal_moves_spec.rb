# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/move'
require_relative '../../lib/moves/diagonal_move'
require_relative '../../lib/piece'
require_relative '../../lib/board'

describe DiagonalMove do
  describe '#generate_moves' do
    context 'when the piece can only move in one step' do
      let(:piece) { instance_double(Piece, line_moves?: false, color: 'white') }
      let(:board) { instance_double(Board, square_empty?: true) }
      subject(:one_diagonal) { described_class.new(board: board, piece: piece) }
      context 'when no square is blocked' do
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
      end

      context 'when the one or more moves are blocked' do
        context 'when the origin square is B5 and C6 is blocked' do
          let(:blocking_piece) { instance_double(Piece, color: 'white') }
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
    end

    context 'when the piece is a line piece' do
      let(:piece) { instance_double(Piece, line_moves?: true, color: 'white') }
      let(:board) { instance_double(Board, square_empty?: true) }
      subject(:line_mover) { described_class.new(board: board, piece: piece) }
      context 'when no piece is blocking' do
        context 'when the origin square is D4' do
          let(:square) { 'D4' }
          it 'returns a list containing C3, B2, A1, C5, B6, A7, E5, F6, G7, H8, E3, F2, and G1' do
            moves = %w[C3 B2 A1 C5 B6 A7 E5 F6 G7 H8 E3 F2 G1]
            expect(line_mover.generate_moves(square)).to contain_exactly(*moves)
          end
        end

        context 'when the origin square is H1' do
          let(:square) { 'H1' }
          it 'returns a list containing G2, F3, E4, D5, C6, B7, and A8' do
            moves = %w[G2 F3 E4 D5 C6 B7 A8]
            expect(line_mover.generate_moves(square)).to contain_exactly(*moves)
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
            expect(line_mover.generate_moves(square)).to contain_exactly(*moves)
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
            expect(line_mover.generate_moves(square)).to contain_exactly(*moves)
          end
        end
      end
    end
  end
end
