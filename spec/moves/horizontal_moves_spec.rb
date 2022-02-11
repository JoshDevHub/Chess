# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/move'
require_relative '../../lib/moves/horizontal_moves'

describe HorizontalMoves do
  describe '#generate_moves' do
    context 'when the piece can only move one square' do
      let(:piece) { double(line_moves?: false) }
      context 'when no square is blocked' do
        let(:board) { double(square_empty?: true) }
        subject(:one_mover) { described_class.new(board: board, piece: piece) }
        context 'when the starting square is C3' do
          let(:square) { 'C3' }
          it 'returns a list containing D4 and B4' do
            moves = %w[D3 B3]
            expect(one_mover.generate_moves(square)).to contain_exactly(*moves)
          end
        end

        context 'when the starting square is H1' do
          let(:square) { 'H1' }
          it 'returns a list containing G1' do
            moves = %w[G1]
            expect(one_mover.generate_moves(square)).to contain_exactly(*moves)
          end
        end
      end
    end

    context 'when the piece can move in lines' do
      let(:piece) { double(line_moves?: true) }
      context 'when no square is blocked' do
        let(:board) { double(square_empty?: true) }
        subject(:line_mover) { described_class.new(board: board, piece: piece) }
        context 'when the starting square is A1' do
          let(:square) { 'A1' }
          it 'returns a list containing B1, C1, D1, E1, F1, G1, and H1' do
            moves = %w[B1 C1 D1 E1 F1 G1 H1]
            expect(line_mover.generate_moves(square)).to contain_exactly(*moves)
          end
        end

        context 'when the starting square is G6' do
          let(:square) { 'G6' }
          it 'returns a list containing H6, F6, E6, D6, C6, B6, and A6' do
            moves = %w[H6 F6 E6 D6 C6 B6 A6]
            expect(line_mover.generate_moves(square)).to contain_exactly(*moves)
          end
        end
      end
    end
  end
end
