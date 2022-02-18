# frozen_string_literal: true

require_relative '../lib/coordinate'
require_relative '../lib/piece'
require_relative '../lib/fen'

describe FEN do
  let(:piece) { class_double(Piece) }
  describe '#piece_info' do
    context 'when the board is the starting board' do
      let(:starting_string) { 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1' }
      subject(:starting_board) { described_class.new(starting_string, piece) }

      before do
        allow(piece).to receive(:from_fen)
      end

      it 'sends Piece #from_fen exactly 32 times' do
        expect(piece).to receive(:from_fen).exactly(32).times
        starting_board.piece_info
      end

      it 'sends Piece #from_fen with r and A8' do
        expect(piece).to receive(:from_fen).with('r', 'A8')
        starting_board.piece_info
      end

      it 'sends Piece #from_fen with K and D1' do
        expect(piece).to receive(:from_fen).with('K', 'E1')
        starting_board.piece_info
      end

      it 'does not send Piece #from_fen with p and G4' do
        expect(piece).not_to receive(:from_fen).with('p', 'G4')
        starting_board.piece_info
      end
    end
  end

  describe '#active_color' do
    context 'when white is the active color' do
      let(:starting_string) { 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1' }
      subject(:starting_board) { described_class.new(starting_string, piece) }
      it 'returns white' do
        expected_color = 'white'
        expect(starting_board.active_color).to eq(expected_color)
      end
    end

    context 'when black is the active color' do
      let(:random_fen) { '8/R4KP1/5p2/1p6/4pPR1/P6k/pPb4P/3N2b1 b - - 0 1' }
      subject(:fen_info) { described_class.new(random_fen, piece) }
      it 'returns black' do
        expected_color = 'black'
        expect(fen_info.active_color).to eq(expected_color)
      end
    end
  end
end
