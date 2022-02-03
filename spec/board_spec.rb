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

  describe '#in_range?' do
    let(:square) { double('square') }
    subject(:board_to_check) { described_class.new(square) }
    context 'when the given coordinate exists on the board' do
      xit 'returns true' do
        coordinate = 'A5'
        expect(board_to_check.in_range?(coordinate)).to be(true)
      end

      xit 'returns true' do
        coordinate = 'F8'
        expect(board_to_check.in_range?(coordinate)).to be(true)
      end

      xit 'returns true' do
        coordinate = 'C2'
        expect(board_to_check.in_range?(coordinate)).to be(true)
      end
    end

    context 'when the given coordinate does not exist on the board' do
      xit 'returns false' do
        coordinate = 'Z7'
        expect(board_to_check.in_range?(coordinate)).to be(false)
      end

      xit 'returns false' do
        coordinate = 'A23'
        expect(board_to_check.in_range?(coordinate)).to be(false)
      end
    end
  end
end
