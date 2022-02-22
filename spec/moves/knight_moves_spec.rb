# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/board'
require_relative '../../lib/move'
require_relative '../../lib/moves/knight_moves'

describe KnightMoves do
  let(:board) { instance_double(Board, square_empty?: true) }
  subject(:knight_moves) { described_class.new(origin: origin, board: board, color: 'black') }
  describe '#generate_moves' do
    context 'when the board is empty' do
      context 'when the starting square is E4' do
        let(:origin) { 'E4' }

        it 'will return a list that contains D6, F6, D2, F2, C5, G5, C3, and G3' do
          moves = %w[D6 F6 D2 F2 C5 G5 C3 G3]
          expect(knight_moves.generate_moves).to contain_exactly(*moves)
        end
      end

      context 'when the starting square is A8' do
        let(:origin) { 'A8' }

        it 'will return a list that contains B6 and C7' do
          moves = %w[B6 C7]
          expect(knight_moves.generate_moves).to contain_exactly(*moves)
        end
      end

      context 'when the starting square is B1' do
        let(:origin) { 'B1' }

        it 'will return a list that contains A3, D2, and C3' do
          moves = %w[A3 D2 C3]
          expect(knight_moves.generate_moves).to contain_exactly(*moves)
        end
      end
    end

    context 'when a same-color piece blocks one of the move squares' do
      let(:block_color) { 'black' }
      context 'when the starting square is F5 and G7 is blocked' do
        let(:origin) { 'F5' }

        before do
          allow(board).to receive(:square_empty?).with('G7').and_return(false)
          allow(board).to receive(:color_at).with('G7').and_return(block_color)
        end

        it 'will return a list that contains H6, E7, D6, D4, E3, G3, and H4' do
          moves = %w[H6 E7 D6 D4 E3 G3 H4]
          expect(knight_moves.generate_moves).to contain_exactly(*moves)
        end
      end
    end
  end
end
