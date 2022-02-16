# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/board'
require_relative '../../lib/piece'
require_relative '../../lib/pieces/white_pawn'

describe WhitePawn do
  let(:board) { instance_double(Board, square_empty?: true) }
  subject(:white_pawn) { described_class.new(color: 'white', position: square) }
  describe '#generate_moves' do
    context 'when the @moved instance var has been set true' do
      context 'when no friendly piece is blocking' do
        context 'when the square is H2' do
          let(:square) { 'H2' }
          it 'returns a list containing H3' do
            white_pawn.piece_moved
            expect(white_pawn.generate_moves(board)).to contain_exactly('H3')
          end
        end

        context 'when the square is C5' do
          let(:square) { 'C5' }
          it 'returns a list containing C6' do
            white_pawn.piece_moved
            expect(white_pawn.generate_moves(board)).to contain_exactly('C6')
          end
        end
      end

      context 'when a friendly piece is blocking' do
        let(:blocking_piece) { instance_double(Piece, color: 'white') }
        context 'when the square is E2 and E3 is blocked' do
          let(:square) { 'E2' }
          before do
            allow(board).to receive(:square_empty?).with('E3').and_return(false)
            allow(board).to receive(:piece_at).with('E3').and_return(blocking_piece)
          end

          it 'returns an empty array' do
            white_pawn.piece_moved
            expect(white_pawn.generate_moves(board)).to be_empty
          end
        end
      end
    end

    context 'when the @moved instance var is false' do
      context 'when no friendly piece is blocking' do
        context 'when the square is D2' do
          let(:square) { 'D2' }
          it 'returns a list containing D3 and D4' do
            moves = %w[D3 D4]
            expect(white_pawn.generate_moves(board)).to contain_exactly(*moves)
          end
        end
      end

      context 'when a friendly piece is blocking' do
        let(:blocking_piece) { instance_double(Piece, color: 'white') }
        context 'when the square is B2 and B4 is blocked' do
          let(:square) { 'B2' }
          before do
            allow(board).to receive(:square_empty?).with('B4').and_return(false)
            allow(board).to receive(:piece_at).with('B4').and_return(blocking_piece)
          end
          it 'returns a list containing B3' do
            expect(white_pawn.generate_moves(board)).to contain_exactly('B3')
          end
        end

        context 'when the square is C2 and C3 is blocked' do
          let(:square) { 'C2' }
          before do
            allow(board).to receive(:square_empty?).with('C3').and_return(false)
            allow(board).to receive(:piece_at).with('C3').and_return(blocking_piece)
          end
          it 'returns an empty list' do
            expect(white_pawn.generate_moves(board)).to be_empty
          end
        end
      end
    end
  end
end
