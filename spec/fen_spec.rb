# frozen_string_literal: true

require_relative '../lib/coordinate'
require_relative '../lib/fen'

describe FEN do
  describe '#square_info' do
    context 'when the board is the starting board' do
      let(:starting_fen) { 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1' }
      subject(:starting_board) { described_class.new(starting_fen) }
      it 'returns a lowercase r when the given square is A8' do
        square = 'A8'
        fen_char = 'r'
        expect(starting_board.square_info(square)).to eq(fen_char)
      end

      it 'retruns a white pawn when the given square is E2' do
        square = 'E2'
        fen_char = 'P'
        expect(starting_board.square_info(square)).to eq(fen_char)
      end

      it 'returns nil when the given square is D4' do
        square = 'D4'
        expect(starting_board.square_info(square)).to be(nil)
      end
    end
  end
end
