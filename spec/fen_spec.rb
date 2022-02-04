# frozen_string_literal: true

require_relative '../lib/fen'

describe FEN do
  describe '#piece_info' do
    context 'when the board is the starting board' do
      let(:starting_fen) { 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1' }
      subject(:starting_board) { described_class.new(starting_fen) }
      xit 'returns a black rook when the given square is A8' do
        square = 'A8'
        piece = { piece: :rook, color: 'black' }
        expect(starting_board.piece_info(square)).to eq(piece)
      end

      xit 'retruns a white pawn when the given square is E2' do
        square = 'E2'
        piece = { piece: :pawn, color: 'white' }
        expect(starting_board.piece_info(square)).to eq(piece)
      end

      xit 'returns nil when the given square is D4' do
        square = 'D4'
        expect(starting_board.piece_info(square)).to be(nil)
      end
    end
  end
end
