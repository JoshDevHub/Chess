# frozen_string_literal: true

require_relative '../lib/coordinate'
require_relative '../lib/board'

describe ChessBoard do
  describe '#initialize' do
    let(:square) { double('square') }
    let(:fen_data) { double('fen_data') }
    before do
      allow(square).to receive(:new)
      allow(fen_data).to receive(:square_info)
    end

    it 'creates a 2d array board with an outer size of 8' do
      board_instance = described_class.new(square: square, fen_data: fen_data)
      outer_size = board_instance.game_board.size
      expect(outer_size).to eq(8)
    end

    it 'creates a 2d array board with an inner size of 8' do
      board_instance = described_class.new(square: square, fen_data: fen_data)
      expect(board_instance.game_board.all? { |inner| inner.size == 8 }).to be(true)
    end

    it 'creates 64 new squares' do
      expect(square).to receive(:new).exactly(64).times
      described_class.new(square: square, fen_data: fen_data)
    end
  end

  describe '#valid_square?' do
    let(:square) { double('square') }
    let(:fen_data) { double('fen_data') }
    subject(:board_to_check) { described_class.new(square: square, fen_data: fen_data) }
    context 'when the given square_name exists on the board' do
      before do
        allow(square).to receive(:new)
        allow(fen_data).to receive(:square_info)
      end

      it 'returns true' do
        square_name = 'A5'
        expect(board_to_check.valid_square?(square_name)).to be(true)
      end

      it 'returns true' do
        square_name = 'F8'
        expect(board_to_check.valid_square?(square_name)).to be(true)
      end

      it 'returns true' do
        square_name = 'C2'
        expect(board_to_check.valid_square?(square_name)).to be(true)
      end
    end

    context 'when the given square_name does not exist on the board' do
      before do
        allow(square).to receive(:new)
        allow(fen_data).to receive(:square_info)
      end

      it 'returns false' do
        square_name = 'Z7'
        expect(board_to_check.valid_square?(square_name)).to be(false)
      end

      it 'returns false' do
        square_name = 'A23'
        expect(board_to_check.valid_square?(square_name)).to be(false)
      end

      it 'returns false' do
        square_name = '3C'
        expect(board_to_check.valid_square?(square_name)).to be(false)
      end
    end
  end
end
