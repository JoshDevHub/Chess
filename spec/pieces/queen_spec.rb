# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/board'
require_relative '../../lib/piece'
require_relative '../../lib/pieces/queen'

describe Queen do
  let(:board) { instance_double(Board, square_empty?: true) }
  subject(:queen) { described_class.new(color: 'white', position: square) }
  describe '#generate_moves' do
    context 'when there is no friendly piece blocking' do
      context 'when the starting square is D1' do
        let(:square) { 'D1' }
        it 'returns a list containing A1, B1, C1, E1, F1, G1, H1, D2, D3, D4, D5
          D6, D7, D8, E2, F3, G4, H5, C2, C3, and C4' do
          moves = %w[A1 B1 C1 E1 F1 G1 H1 D2 D3 D4 D5 D6 D7 D8 E2 F3 G4 H5 C2 B3 A4]
          expect(queen.generate_moves(board)).to contain_exactly(*moves)
        end
      end
    end

    context 'when a friendly piece is blocking' do
      let(:block_color) { 'white' }
      context 'when the starting square is E4 and F5 and E6 are blocked' do
        let(:square) { 'E4' }
        before do
          allow(board).to receive(:square_empty?).with('F5').and_return(false)
          allow(board).to receive(:color_at).with('F5').and_return(block_color)

          allow(board).to receive(:square_empty?).with('E6').and_return(false)
          allow(board).to receive(:color_at).with('E6').and_return(block_color)
        end
        it 'returns a list containing E3 E2 E1 F3 G2 H1 D3 C2 B1 D4 C4 B4 A4 F4
          G4 H4 E5 D5 C6 B7 and A8' do
          moves = %w[E3 E2 E1 F3 G2 H1 D3 C2 B1 D4 C4 B4 A4 F4 G4 H4 E5 D5 C6 B7 A8]
          expect(queen.generate_moves(board)).to contain_exactly(*moves)
        end
      end
    end
  end
end
