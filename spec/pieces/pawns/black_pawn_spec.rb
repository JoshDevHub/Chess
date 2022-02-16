# frozen_string_literal: true

require_relative '../../../lib/coordinate'
require_relative '../../../lib/board'
require_relative '../../../lib/piece'
require_relative '../../../lib/pieces/pawn'
require_relative '../../../lib/pieces/pawns/black_pawn'

describe BlackPawn do
  let(:board) { instance_double(Board, square_empty?: true, piece_at: nil, color_at: nil) }
  subject(:black_pawn) { described_class.new(color: 'black', position: square) }
  describe '#generate_moves' do
    context 'when the piece has been moved' do
      context 'when no friendly piece is blocking' do
        context 'when the square is H2' do
          let(:square) { 'H2' }
          it 'returns a list containing H1' do
            black_pawn.piece_moved
            expect(black_pawn.generate_moves(board)).to contain_exactly('H1')
          end
        end

        context 'when the square is G7' do
          let(:square) { 'G7' }
          it 'returns a list containing G6' do
            black_pawn.piece_moved
            expect(black_pawn.generate_moves(board)).to contain_exactly('G6')
          end
        end
      end

      context 'when a friendly piece is blocking' do
        let(:blocking_piece) { instance_double(Piece, color: 'black') }
        context 'when the square is F6 and F5 is blocked' do
          let(:square) { 'F6' }
          before do
            allow(board).to receive(:square_empty?).with('F5').and_return(false)
            allow(board).to receive(:piece_at).with('F5').and_return(blocking_piece)
          end

          it 'returns an empty array' do
            black_pawn.piece_moved
            expect(black_pawn.generate_moves(board)).to be_empty
          end
        end
      end
    end

    context 'when the piece has not moved' do
      context 'when no friendly piece is blocking' do
        context 'when the square is B7' do
          let(:square) { 'B7' }
          it 'returns a list containing B6 and B5' do
            moves = %w[B6 B5]
            expect(black_pawn.generate_moves(board)).to contain_exactly(*moves)
          end
        end
      end

      context 'when squares are blocked' do
        let(:blocking_piece) { instance_double(Piece, color: 'black') }
        context 'when the square is A7 and A5 is blocked' do
          let(:square) { 'A7' }
          before do
            allow(board).to receive(:square_empty?).with('A5').and_return(false)
            allow(board).to receive(:piece_at).with('A5').and_return(blocking_piece)
          end
          it 'returns a list containing A6' do
            expect(black_pawn.generate_moves(board)).to contain_exactly('A6')
          end
        end

        context 'when the square is F7 and F6 is blocked' do
          let(:square) { 'F7' }
        end
      end
    end

    context 'when a piece is available for capture' do
      let(:opponent_color) { 'white' }
      context 'when the square is B5 and a white piece is on C4' do
        let(:square) { 'B5' }
        before do
          allow(board).to receive(:square_empty?).with('C4').and_return(false)
          allow(board).to receive(:color_at).with('C4').and_return(opponent_color)
        end
        it 'returns a list containing B4 and C4' do
          moves = %w[B4 C4]
          black_pawn.piece_moved
          expect(black_pawn.generate_moves(board)).to contain_exactly(*moves)
        end
      end
    end
  end
end
