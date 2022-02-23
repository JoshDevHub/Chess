# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/board'
require_relative '../../lib/move'
require_relative '../../lib/moves/double_down_move'

describe DoubleDownMove do
  let(:board) { instance_double(Board, square_empty?: true) }
  subject(:double_down) { described_class.new(origin: origin, color: 'black', board: board) }
  describe '#generate_moves' do
    context 'when the target square is not blocked' do
      context 'when the origin is B7' do
        let(:origin) { 'B7' }
        it 'returns a list containing B5' do
          expect(double_down.generate_moves).to contain_exactly('B5')
        end
      end

      context 'when the origin is C7' do
        let(:origin) { 'C7' }
        it 'returns a list containing C5' do
          expect(double_down.generate_moves).to contain_exactly('C5')
        end
      end
    end

    context 'when the target square is blocked' do
      context 'when the origin is H7 and H5 is blocked' do
        let(:origin) { 'H7' }
        before do
          allow(board).to receive(:square_empty?).with('H5').and_return(false)
        end

        it 'returns an empty list' do
          expect(double_down.generate_moves).to be_empty
        end
      end
    end

    context 'when the square above the target is blocked' do
      context 'when the origin is F7 and F6 is blocked' do
        let(:origin) { 'F7' }
        before do
          allow(board).to receive(:square_empty?).with('F6').and_return(false)
        end

        it 'returns an empty list' do
          expect(double_down.generate_moves).to be_empty
        end
      end
    end
  end
end
