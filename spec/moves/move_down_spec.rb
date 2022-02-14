# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/move'
require_relative '../../lib/moves/move_down'
require_relative '../../lib/board'
require_relative '../../lib/piece'

describe MoveDown do
  let(:board) { instance_double(Board, square_empty?: true) }
  context 'when the piece only moves one square' do
    let(:piece) { instance_double(Piece, line_moves?: false, color: 'black') }
    subject(:one_mover) { described_class.new(board: board, piece: piece) }
    context 'when the piece is unblocked by another piece' do
      context 'when the square is H4' do
        let(:square) { 'H4' }
        it 'returns a list containing H3' do
          moves = %w[H3]
          expect(one_mover.generate_moves(square)).to contain_exactly(*moves)
        end
      end
    end

    context 'when the piece is blocked by another piece' do
      let(:blocking_piece) { instance_double(Piece, color: 'black') }
      context 'when the piece is on D3 and D2 is blocked' do
        let(:square) { 'D3' }
        before do
          allow(board).to receive(:square_empty?).with('D2').and_return(false)
          allow(board).to receive(:piece_at).with('D2').and_return(blocking_piece)
        end

        it 'returns an empty list' do
          expect(one_mover.generate_moves(square)).to be_empty
        end
      end
    end
  end

  context 'when the piece moves multiple squares' do
    let(:piece) { instance_double(Piece, line_moves?: true, color: 'white') }
    subject(:line_mover) { described_class.new(board: board, piece: piece) }
    context 'when the piece is unblocked by other pieces' do
      context 'when the square is B7' do
        let(:square) { 'B7' }
        it 'returns a list containing B6, B5, B4, B3, B2, and B1' do
          moves = %w[B6 B5 B4 B3 B2 B1]
          expect(line_mover.generate_moves(square)).to contain_exactly(*moves)
        end
      end
    end

    context 'when the piece is blocked by other pieces' do
      let(:blocking_piece) { instance_double(Piece, color: 'white') }
      context 'when the piece is on F6 and F3 is blocked' do
        let(:square) { 'F6' }
        before do
          allow(board).to receive(:square_empty?).with('F3').and_return(false)
          allow(board).to receive(:piece_at).with('F3').and_return(blocking_piece)
        end

        it 'returns a list containing F5 and F4' do
          moves = %w[F5 F4]
          expect(line_mover.generate_moves(square)).to contain_exactly(*moves)
        end
      end
    end
  end
end
