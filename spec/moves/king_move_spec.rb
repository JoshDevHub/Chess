# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/board'
require_relative '../../lib/move'
require_relative '../../lib/moves/king_move'

describe KingMove do
  subject(:king_move) { described_class.new(color: 'black', origin: origin, board: board) }
  describe '#generate_moves' do
    let(:board) { instance_double(Board, square_empty?: true) }
    context 'when no squares are blocked by friendly pieces' do
      context 'when the starting square is E7' do
        let(:origin) { 'E7' }
        it 'returns a list containg E8, F8, F7, F6, E6, D6, D7, and D8' do
          moves = %w[E8 F8 F7 F6 E6 D6 D7 D8]
          expect(king_move.generate_moves).to contain_exactly(*moves)
        end
      end

      context 'when the square is C8' do
        let(:origin) { 'C8' }
        it 'returns a list containing D8, D7, C7, B7, and B8' do
          moves = %w[D8 D7 C7 B7 B8]
          expect(king_move.generate_moves).to contain_exactly(*moves)
        end
      end
    end

    context 'when a square is blocked by a friendly piece' do
      let(:block_color) { 'black' }
      context 'when the starting square is B6 and C7 is blocked' do
        let(:origin) { 'B6' }
        before do
          allow(board).to receive(:square_empty?).with('C7').and_return(false)
          allow(board).to receive(:color_at).with('C7').and_return(block_color)
        end
        it 'returns a list containing B7, C6, C5, B5, A5, A6, and A7' do
          moves = %w[B7 C6 C5 B5 A5 A6 A7]
          expect(king_move.generate_moves).to contain_exactly(*moves)
        end
      end
    end
  end
end
