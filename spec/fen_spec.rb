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

    context 'when the fen string is random' do
      let(:random_fen) { '5b2/7P/r1p5/3bnP1Q/1kP1p3/3r4/4BP1K/2R5 w - - 0 1' }
      subject(:fen_data) { described_class.new(random_fen, piece) }

      before do
        allow(piece).to receive(:from_fen)
      end

      it 'sends Piece #from_fen exactly 16 times' do
        expect(piece).to receive(:from_fen).exactly(16).times
        fen_data.piece_info
      end

      it 'sends Piece #from_fen with R and C1' do
        expect(piece).to receive(:from_fen).with('R', 'C1')
        fen_data.piece_info
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

  describe '#en_passant_target' do
    context 'when the target is empty' do
      let(:fen_string) { 'rnbqkbnr/pp1ppppp/8/2p5/4P3/5N2/PPPP1PPP/RNBQKB1R b KQkq - 1 2' }
      subject(:no_en_passant) { described_class.new(fen_string, piece) }
      it 'returns nil' do
        expect(no_en_passant.en_passant_target).to be(nil)
      end
    end

    context 'when the target is defined' do
      let(:fen_string) { 'rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq e3 0 1' }
      subject(:fen_with_en_passant) { described_class.new(fen_string, piece) }
      it 'returns the en passant target square' do
        target = 'E3'
        expect(fen_with_en_passant.en_passant_target).to eq(target)
      end
    end
  end
end
