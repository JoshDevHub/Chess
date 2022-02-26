# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/board'
require_relative '../../lib/move'
require_relative '../../lib/moves/black_pawn_advance'

describe BlackPawnAdvance do
  let(:board) { instance_double(Board, square_empty?: true) }
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
        before do
          allow(board).to receive(:square_empty?).with('F5').and_return(false)
        end

        it 'returns an empty list' do
          expect(down_move.generate_moves).to be_empty
        end
      end
    end
  end
end
