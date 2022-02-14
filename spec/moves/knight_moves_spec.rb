# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/move'
require_relative '../../lib/moves/knight_move'
require_relative '../../lib/board'
require_relative '../../lib/piece'

describe KnightMove do
  subject(:knight_list) { described_class.new(board: board, piece: piece) }
  context 'when the board is empty do' do
    let(:board) { instance_double(Board, square_empty?: true) }
    let(:piece) { instance_double(Piece, 'piece') }
    context 'when the starting square is E4' do
      let(:square) { 'E4' }
      it 'will return a list that contains D6, F6, D2, F2, C5, G5, C3, and G3' do
        moves = %w[D6 F6 D2 F2 C5 G5 C3 G3]
        expect(knight_list.generate_moves(square)).to contain_exactly(*moves)
      end
    end

    context 'when the piece is on A8 on an empty board' do
      let(:square) { 'A8' }
      it 'will return a list that contains B6 and C7' do
        moves = %w[B6 C7]
        expect(knight_list.generate_moves(square)).to contain_exactly(*moves)
      end
    end

    context 'when the piece is on B1 on an empty board' do
      let(:square) { 'B1' }
      it 'will return a list that contains A3, D2, and C3' do
        moves = %w[A3 D2 C3]
        expect(knight_list.generate_moves(square)).to contain_exactly(*moves)
      end
    end
  end

  context 'when a same-color piece blocks one of the moves squares' do
    let(:board) { instance_double(Board, square_empty?: true) }
    let(:blocking_piece) { instance_double(Piece, color: 'white') }
    let(:piece) { instance_double(Piece, 'piece', color: 'white') }
    context 'when the starting square is F5' do
      let(:square) { 'F5' }
      context 'when a piece blocks the move to G7' do
        before do
          allow(board).to receive(:square_empty?).with('G7').and_return(false)
          allow(board).to receive(:piece_at).with('G7').and_return(blocking_piece)
        end
        it 'will return a list that contains H6, E7, D6, D4, E3, G3, and H4' do
          moves = %w[H6 E7 D6 D4 E3 G3 H4]
          expect(knight_list.generate_moves(square)).to contain_exactly(*moves)
        end
      end
    end
  end
end
