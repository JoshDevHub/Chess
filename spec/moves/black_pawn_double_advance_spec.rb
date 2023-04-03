# frozen_string_literal: true

RSpec.describe BlackPawnDoubleAdvance do
  subject(:double_down) { described_class.new(origin: origin, color: 'black', board: board) }

  let(:board) { instance_double(Board, access_square: square) }
  let(:square) { instance_double(Square, unoccupied?: true) }

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
      let(:block_square) { instance_double(Square, unoccupied?: false) }

      context 'when the origin is H7 and H5 is blocked' do
        let(:origin) { 'H7' }

        before do
          allow(board).to receive(:access_square).with('H5').and_return(block_square)
        end

        it 'returns an empty list' do
          expect(double_down.generate_moves).to be_empty
        end
      end
    end

    context 'when the square above the target is blocked' do
      let(:block_square) { instance_double(Square, unoccupied?: false) }

      context 'when the origin is F7 and F6 is blocked' do
        let(:origin) { 'F7' }

        before do
          allow(board).to receive(:access_square).with('F6').and_return(block_square)
        end

        it 'returns an empty list' do
          expect(double_down.generate_moves).to be_empty
        end
      end
    end
  end
end
