# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/board'
require_relative '../../lib/piece'
require_relative '../../lib/pieces/rook'

describe Rook do
  subject(:rook) { described_class.new(color: 'black', position: square) }
  let(:board) { instance_double(Board, square_empty?: true) }
  describe '#generate_moves' do
    context 'when no friendly piece is blocking any squares' do
      context 'when the starting square is A8' do
        let(:square) { 'A8' }
        it 'returns a list containing A7, A6, A5, A4, A3, A2, A1, B8, C8, D8, E8,
          F8, G8, and H8' do
          moves = %w[A7 A6 A5 A4 A3 A2 A1 B8 C8 D8 E8 F8 G8 H8]
          expect(rook.generate_moves(board)).to contain_exactly(*moves)
        end
      end
    end

    context 'when friendly pieces are blocking squares' do
      let(:block_color) { 'black' }
      context 'when the starting square is C6 and B6 and D6 are blocked' do
        let(:square) { 'C6' }
        before do
          allow(board).to receive(:square_empty?).with('B6').and_return(false)
          allow(board).to receive(:color_at).with('B6').and_return(block_color)

          allow(board).to receive(:square_empty?).with('D6').and_return(false)
          allow(board).to receive(:color_at).with('D6').and_return(block_color)
        end

        it 'returns a list containing C7, C8, C5, C4, C3, C2, and C1' do
          moves = %w[C7 C8 C5 C4 C3 C2 C1]
          expect(rook.generate_moves(board)).to contain_exactly(*moves)
        end
      end
    end

    context 'when the rook is completely boxed in by friendly pieces' do
      let(:block_color) { 'black' }
      context 'when the starting square is H8 and H7 and G8 are blocked' do
        let(:square) { 'H8' }
        before do
          allow(board).to receive(:square_empty?).with('H7').and_return(false)
          allow(board).to receive(:color_at).with('H7').and_return(block_color)

          allow(board).to receive(:square_empty?).with('G8').and_return(false)
          allow(board).to receive(:color_at).with('G8').and_return(block_color)
        end

        it 'returns an empty array' do
          expect(rook.generate_moves(board)).to be_empty
        end
      end
    end
  end
end
