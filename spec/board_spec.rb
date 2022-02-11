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

  describe '#square_empty?' do
    context 'when there is a piece at the board positions' do
      let(:piece) { double('piece') }
      let(:fen_data) { double('fen_data') }
      subject(:game_board) { described_class.new(fen_data: fen_data, piece: piece) }
      before do
        square_to_check = 'E4'
        allow(piece).to receive(:from_fen).and_return(piece)
        allow(fen_data).to receive(:square_info).and_return(square_to_check)
      end
      it 'returns false' do
        expect(game_board.square_empty?('E4')).to be(false)
      end
    end

    context 'when there is no piece at the board position' do
      let(:piece) { double('piece') }
      let(:fen_data) { double('fen_data') }
      subject(:game_board) { described_class.new(fen_data: fen_data, piece: piece) }
      before do
        allow(piece).to receive(:from_fen)
        allow(fen_data).to receive(:square_info)
      end
      it 'returns true' do
        expect(game_board.square_empty?('B3')).to be(true)
      end
    end
  end
end
