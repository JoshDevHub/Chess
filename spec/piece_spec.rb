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

  subject(:generic_piece) { described_class.new(color: 'white') }
  describe '#moves_diagonally?' do
    it 'returns false' do
      expect(generic_piece.moves_diagonally?).to be(false)
    end
  end

  describe '#moves_horizontally?' do
    it 'returns false' do
      expect(generic_piece.moves_horizontally?).to be(false)
    end
  end

  describe '#knight_moves?' do
    it 'returns false' do
      expect(generic_piece.knight_moves?).to be(false)
    end
  end

  describe '#moves_up?' do
    it 'returns false' do
      expect(generic_piece.moves_up?).to be(false)
    end
  end

  describe '#moves_down' do
    it 'returns false' do
      expect(generic_piece.moves_down?).to be(false)
    end
  end

  describe '#line_moves' do
    it 'returns false' do
      expect(generic_piece.line_moves?).to be(false)
    end
  end
end
