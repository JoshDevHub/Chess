# frozen_string_literal: true

RSpec.describe BlackPawnAdvance do
  let(:board) { instance_double(Board, access_square: square) }
  let(:square) { instance_double(Square, unoccupied?: true) }
  subject(:down_move) { described_class.new(color: 'black', origin: origin, board: board) }
  describe '#generate_moves' do
    context 'when the target square is unblocked' do
      context 'when the origin is H2' do
        let(:origin) { 'H2' }
        it 'returns a list containing H1' do
          expect(down_move.generate_moves).to contain_exactly('H1')
        end
      end

      context 'when the origin is G6' do
        let(:origin) { 'G6' }
        it 'returns a list containing G5' do
          expect(down_move.generate_moves).to contain_exactly('G5')
        end
      end
    end

    context 'when the target square is blocked' do
      context 'when the origin is F6 and F5 is blocked' do
        let(:origin) { 'F6' }
        let(:block_square) { instance_double(Square, unoccupied?: false) }
        before do
          allow(board).to receive(:access_square).with('F5').and_return(block_square)
        end

        it 'returns an empty list' do
          expect(down_move.generate_moves).to be_empty
        end
      end
    end
  end
end
