# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/board'
require_relative '../../lib/move'
require_relative '../../lib/moves/white_pawn_advance'

describe WhitePawnAdvance do
  let(:board) { instance_double(Board, square_empty?: true) }
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
        before do
          allow(board).to receive(:square_empty?).with('E3').and_return(false)
        end

        it 'returns an empty list' do
          expect(up_move.generate_moves).to be_empty
        end
      end
    end
  end
end
