# frozen_string_literal: true

RSpec.describe WhitePawnAdvance do
  let(:board) { instance_double(Board, access_square: square) }
  let(:square) { instance_double(Square, unoccupied?: true, piece_color: nil) }
  subject(:up_move) { described_class.new(origin: origin, color: 'white', board: board) }
  describe '#generate_moves' do
    context 'when no piece occupies the target square' do
      context 'when the origin is H3' do
        let(:origin) { 'H3' }
        it 'returns a list containing H4' do
          expect(up_move.generate_moves).to contain_exactly('H4')
        end
      end

      context 'when the origin is C5' do
        let(:origin) { 'C5' }
        it 'returns a list containing C6' do
          expect(up_move.generate_moves).to contain_exactly('C6')
        end
      end
    end

    context 'when a piece occupies the target square' do
      context 'when the origin is E2 and E3 is blocked' do
        let(:origin) { 'E2' }
        let(:block_square) { instance_double(Square, unoccupied?: false, piece_color: nil) }
        before do
          allow(board).to receive(:access_square).with('E3').and_return(block_square)
        end

        it 'returns an empty list' do
          expect(up_move.generate_moves).to be_empty
        end
      end
    end
  end
end
