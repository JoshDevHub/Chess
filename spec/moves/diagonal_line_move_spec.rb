# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/board'
require_relative '../../lib/move'
require_relative '../../lib/moves/diagonal_line_move'

describe DiagonalLineMove do
  describe '#generate_moves' do
    let(:board) { instance_double(Board, square_empty?: true, color_at: nil) }
    subject(:diagonal_moves) { described_class.new(origin: origin, color: 'white', board: board) }
    context 'when no piece is blocking' do
      context 'when the origin square is D4' do
        let(:origin) { 'D4' }
        it 'returns a list containing C3, B2, A1, C5, B6, A7, E5, F6, G7, H8, E3, F2, and G1' do
          moves = %w[C3 B2 A1 C5 B6 A7 E5 F6 G7 H8 E3 F2 G1]
          expect(diagonal_moves.generate_moves).to contain_exactly(*moves)
        end
      end

      context 'when the origin square is H1' do
        let(:origin) { 'H1' }
        it 'returns a list containing G2, F3, E4, D5, C6, B7, and A8' do
          moves = %w[G2 F3 E4 D5 C6 B7 A8]
          expect(diagonal_moves.generate_moves).to contain_exactly(*moves)
        end
      end
    end

    context 'when potential moves are blocked' do
      let(:block_color) { 'white' }
      context 'when the origin square is B4 with a blocking piece on C5' do
        let(:origin) { 'B4' }
        before do
          allow(board).to receive(:square_empty?).with('C5').and_return(false)
          allow(board).to receive(:color_at).with('C5').and_return(block_color)
        end

        it 'returns a list containing A5, A3, C3, D2, and E1' do
          moves = %w[A5 A3 C3 D2 E1]
          expect(diagonal_moves.generate_moves).to contain_exactly(*moves)
        end
      end

      context 'when the origin square is H8 with a blocking piece on E5' do
        let(:origin) { 'H8' }
        before do
          allow(board).to receive(:square_empty?).with('E5').and_return(false)
          allow(board).to receive(:color_at).with('E5').and_return(block_color)
        end

        it 'returns a list containing G7 and F6' do
          moves = %w[G7 F6]
          expect(diagonal_moves.generate_moves).to contain_exactly(*moves)
        end
      end
    end

    context 'when a piece is available for capture' do
      let(:capture_color) { 'black' }
      context 'when the origin square is C3 and an enemy piece is on E5' do
        let(:origin) { 'C3' }
        before do
          allow(board).to receive(:square_empty?).with('E5').and_return(false)
          allow(board).to receive(:color_at).with('E5').and_return(capture_color)
        end

        it 'returns a list containing B2, A1, D2, E1, D4, E5, B4, and A5' do
          moves = %w[B2 A1 D2 E1 D4 E5 B4 A5]
          expect(diagonal_moves.generate_moves).to contain_exactly(*moves)
        end
      end
    end
  end
end
