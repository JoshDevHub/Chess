# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/board'
require_relative '../../lib/piece'
require_relative '../../lib/pieces/black_pawn'

describe BlackPawn do
  let(:board) { instance_double(Board, square_empty?: true) }
  subject(:black_pawn) { described_class.new(color: 'black', position: square) }
  describe '#generate_moves' do
    context 'when no friendly piece is blocking' do
      context 'when the square is H2' do
        let(:square) { 'H2' }
        it 'returns a list containing H1' do
          expect(black_pawn.generate_moves(board)).to contain_exactly('H1')
        end
      end

      context 'when the square is G7' do
        let(:square) { 'G7' }
        it 'returns a list containing G6' do
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
          expect(black_pawn.generate_moves(board)).to be_empty
        end
      end
    end
  end
end
