# frozen_string_literal: true

require_relative '../lib/coordinate'
require_relative '../lib/board'

describe ChessBoard do
  describe '#initialize' do
    let(:fen_data) { double('fen_data') }
    let(:piece) { double('piece') }
    before do
      allow(fen_data).to receive(:square_info)
      allow(piece).to receive(:from_fen)
    end

    it 'creates a 2d array board with an outer size of 8' do
      board_instance = described_class.new(fen_data: fen_data, piece: piece)
      outer_size = board_instance.game_board.size
      expect(outer_size).to eq(8)
    end

    it 'creates a 2d array board with an inner size of 8' do
      board_instance = described_class.new(fen_data: fen_data, piece: piece)
      expect(board_instance.game_board.all? { |inner| inner.size == 8 }).to be(true)
    end

    it 'creates structure with 64 positions' do
      board_instance = described_class.new(fen_data: fen_data, piece: piece)
      expect(board_instance.game_board.flatten.size).to eq(64)
    end
  end

  describe '#valid_square?' do
    let(:piece) { double('piece') }
    let(:fen_data) { double('fen_data') }
    subject(:board_to_check) { described_class.new(fen_data: fen_data, piece: piece) }
    context 'when the given square_name exists on the board' do
      before do
        allow(fen_data).to receive(:square_info)
        allow(piece).to receive(:from_fen)
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
        allow(piece).to receive(:from_fen)
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

  describe '#piece_at' do
    context 'when there is a piece at the board position' do
      let(:piece) { double('piece') }
      let(:fen_data) { double('fen_data') }
      subject(:searchable_board) { described_class.new(fen_data: fen_data, piece: piece) }
      before do
        square_to_check = 'A8'
        allow(piece).to receive(:from_fen).and_return(piece)
        allow(fen_data).to receive(:square_info).and_return(square_to_check)
      end
      it 'returns the object at that position' do
        expect(searchable_board.piece_at('A8')).to be(piece)
      end
    end
    context 'when there is no piece at the board position' do
      let(:piece) { double('piece') }
      let(:fen_data) { double('fen_data') }
      subject(:searchable_board) { described_class.new(fen_data: fen_data, piece: piece) }
      before do
        square_to_check = 'C6'
        allow(piece).to receive(:from_fen).and_return(nil)
        allow(fen_data).to receive(:square_info).and_return(square_to_check)
      end
      it 'returns nil for that position' do
        expect(searchable_board.piece_at('C6')).to be(nil)
      end
    end
  end
end
