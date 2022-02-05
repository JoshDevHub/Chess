# frozen_string_literal: true

require_relative '../lib/piece'
Dir[File.join(__dir__, '../lib/pieces', '*.rb')].sort.each { |file| require file }

describe Piece do
  describe '#self.from_fen' do
    context 'when the piece is a white king' do
      it 'creates a King subclass' do
        piece_fen = 'K'
        subclass = described_class.from_fen(piece_fen)
        expect(subclass).to be_a(King)
      end
    end

    context 'when the piece is a black rook' do
      it 'creates a Rook subclass' do
        piece_fen = 'r'
        subclass = described_class.from_fen(piece_fen)
        expect(subclass).to be_a(Rook)
      end
    end
  end
end
