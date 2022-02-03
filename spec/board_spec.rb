# frozen_string_literal: true

require_relative '../lib/board'

describe ChessBoard do
  describe '#initialize' do
    let(:square) { double('square') }
    before do
      allow(square).to receive(:new)
    end

    it 'creates a 2d array board with an outer size of 8' do
      board_instance = described_class.new(square)
      outer_size = board_instance.game_board.size
      expect(outer_size).to eq(8)
    end

    it 'creates a 2d array board with an inner size of 8' do
      board_instance = described_class.new(square)
      expect(board_instance.game_board.all? { |inner| inner.size == 8 }).to be(true)
    end

    it 'creates 64 new squares' do
      expect(square).to receive(:new).exactly(64).times
      described_class.new(square)
    end
  end
end
