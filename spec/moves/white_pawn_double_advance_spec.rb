# frozen_string_literal: true

RSpec.describe WhitePawnDoubleAdvance do
  subject(:double_up) { described_class.new(origin: origin, color: 'white', board: board) }

  let(:board) { instance_double(Board, access_square: square) }
  let(:square) { instance_double(Square, unoccupied?: true) }

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
      let(:block_square) { instance_double(Square, unoccupied?: false) }

      context 'when the origin is B2 and B4 is blocked' do
        let(:origin) { 'B2' }

        before do
          allow(board).to receive(:access_square).with('B4').and_return(block_square)
        end

        it 'returns an empty list' do
          expect(double_up.generate_moves).to be_empty
        end
      end
    end

    context 'when the square below the target is blocked' do
      let(:block_square) { instance_double(Square, unoccupied?: false) }

      context 'when the origin is F2 and F3 is blocked' do
        let(:origin) { 'F2' }

        before do
          allow(board).to receive(:access_square).with('F3').and_return(block_square)
        end

        it 'returns an empty list' do
          expect(double_up.generate_moves).to be_empty
        end
      end
    end
  end
end
