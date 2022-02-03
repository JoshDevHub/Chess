# frozen_string_literal: true

require_relative '../lib/board'

describe ChessBoard do
  describe '#game_board' do
    let(:square) { double('square') }
    subject(:board) { described_class.new(square) }
    before do
      allow(square).to receive(:new)
    end

    it 'returns a 2d array with an outer size of 8' do
      expect(board.game_board.size).to eq(8)
    end

    it 'returns a 2d array with an inner size of 8' do
      expect(board.game_board.all? { |inner| inner.size == 8 }).to be(true)
    end

    it 'returns a structure with 64 objects' do
      square_count = board.game_board.flatten.size
      expect(square_count).to eq(64)
    end
  end
end
