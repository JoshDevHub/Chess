# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/board'
require_relative '../../lib/move'
require_relative '../../lib/moves/double_up_move'

describe DoubleUpMove do
  let(:board) { instance_double(Board, square_empty?: true) }
  subject(:double_up) { described_class.new(origin: origin, color: 'white', board: board) }
  describe '#generate_moves' do
    context 'when the target square is not blocked' do
      context 'when the origin is D2' do
        let(:origin) { 'D2' }
        it 'returns a list containing D4' do
          expect(double_up.generate_moves).to contain_exactly('D4')
        end
      end

      context 'when the origin is H2' do
        let(:origin) { 'H2' }
        it 'returns a list containing H4' do
          expect(double_up.generate_moves).to contain_exactly('H4')
        end
      end
    end

    context 'when the target square is blocked' do
      context 'when the origin is B2 and B4 is blocked' do
        let(:origin) { 'B2' }
        before do
          allow(board).to receive(:square_empty?).with('B4').and_return(false)
        end

        it 'returns an empty list' do
          expect(double_up.generate_moves).to be_empty
        end
      end
    end

    context 'when the square below the target is blocked' do
      context 'when the origin is F2 and F3 is blocked' do
        let(:origin) { 'F2' }
        before do
          allow(board).to receive(:square_empty?).with('F3').and_return(false)
        end

        it 'returns an empty list' do
          expect(double_up.generate_moves).to be_empty
        end
      end
    end
  end
end
