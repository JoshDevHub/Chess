# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/move'
require_relative '../../lib/moves/move_up'
require_relative '../../lib/piece'
require_relative '../../lib/board'

describe MoveUp do
  describe '#generate_moves' do
    let(:board) { instance_double(Board, square_empty?: true) }
    context 'when the piece can only move one square' do
      let(:piece) { instance_double(Piece, line_moves?: false, color: 'white') }
      subject(:one_mover) { described_class.new(board: board, piece: piece) }
      context 'when no square is blocked' do
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

      context 'when the starting square is B7 and B8 is blocked' do
        let(:square) { 'B7' }
        let(:blocking_piece) { instance_double(Piece, color: 'white') }
        before do
          allow(board).to receive(:square_empty?).with('B8').and_return(false)
          allow(board).to receive(:piece_at).with('B8').and_return(blocking_piece)
        end
        it 'returns an empty array' do
          expect(one_mover.generate_moves(square)).to be_empty
        end
      end
    end

    context 'when the piece can move multiple squares' do
      let(:piece) { instance_double(Piece, line_moves?: true, color: 'black') }
      subject(:line_mover) { described_class.new(board: board, piece: piece) }
      context 'when no square is blocked' do
        context 'when the starting square is F4' do
          let(:square) { 'F4' }
          it 'returns a list containing F5, F6, F7, and F8' do
            moves = %w[F5 F6 F7 F8]
            expect(line_mover.generate_moves(square)).to contain_exactly(*moves)
          end
        end
      end

      context 'when a square is blocked' do
        let(:blocking_piece) { instance_double(Piece, color: 'black') }
        context 'when the starting square is C5 and C8 is blocked' do
          let(:square) { 'C5' }
          before do
            allow(board).to receive(:square_empty?).with('C8').and_return(false)
            allow(board).to receive(:piece_at).with('C8').and_return(blocking_piece)
          end

          it 'returns a list containing C6 and C7' do
            moves = %w[C6 C7]
            expect(line_mover.generate_moves(square)).to contain_exactly(*moves)
          end
        end
      end
    end
  end
end
