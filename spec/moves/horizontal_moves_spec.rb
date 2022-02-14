# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/move'
require_relative '../../lib/moves/horizontal_move'
require_relative '../../lib/piece'
require_relative '../../lib/board'

describe HorizontalMove do
  describe '#generate_moves' do
    context 'when the piece can only move one square' do
      let(:piece) { instance_double(Piece, line_moves?: false, color: 'black') }
      context 'when no square is blocked' do
        let(:board) { instance_double(Board, square_empty?: true) }
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

      context 'when square(s) is blocked' do
        let(:board) { instance_double(Board, square_empty?: true) }
        let(:blocking_piece) { instance_double(Piece, color: 'black') }
        subject(:move_with_blocks) { described_class.new(board: board, piece: piece) }
        context 'when the starting square is B6 with a blocking piece on C6' do
          let(:square) { 'B6' }
          before do
            allow(board).to receive(:square_empty?).with('C6').and_return(false)
            allow(board).to receive(:piece_at).with('C6').and_return(blocking_piece)
          end

          it 'returns a list with A6' do
            moves = %w[A6]
            expect(move_with_blocks.generate_moves(square)).to contain_exactly(*moves)
          end
        end

        context 'when the starting square is F3 with blocking pieces on G3 and E3' do
          let(:square) { 'F3' }
          before do
            allow(board).to receive(:square_empty?).with('G3').and_return(false)
            allow(board).to receive(:square_empty?).with('E3').and_return(false)
            allow(board).to receive(:piece_at).with('G3').and_return(blocking_piece)
            allow(board).to receive(:piece_at).with('E3').and_return(blocking_piece)
          end

          it 'returns an empty array' do
            expect(move_with_blocks.generate_moves(square)).to be_empty
          end
        end
      end
    end

    context 'when the piece can move in lines' do
      let(:piece) { instance_double(Piece, line_moves?: true) }
      context 'when no square is blocked' do
        let(:board) { instance_double(Board, square_empty?: true) }
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
