# frozen_string_literal: true

require_relative '../lib/piece'
Dir[File.join(__dir__, '../lib/pieces', '*.rb')].sort.each { |file| require file }

describe Piece do
  describe '#self.new_piece' do
    context 'when the piece is a white king' do
      it 'creates a King subclass' do
        piece_name = :king
        color = 'white'
        subclass = described_class.new_piece(piece: piece_name, color: color)
        expect(subclass).to be_a(King)
      end
    end

    context 'when the piece is a black rook' do
      it 'creates a Rook subclass' do
        piece_name = :rook
        color = 'black'
        subclass = described_class.new_piece(piece: piece_name, color: color)
        expect(subclass).to be_a(Rook)
      end
    end

    context 'when the piece is not implemented' do
      it 'raises a NotImplemented Error' do
        invalid_piece = :duke
        color = 'white'
        expect { described_class.new_piece(piece: invalid_piece, color: color) }.to raise_error(NotImplementedError)
      end
    end

    context 'when the given color is not implemented' do
      it 'raises a NotImplemented Error' do
        piece_name = :pawn
        invalid_color = 'yellow'
        expect { described_class.new_piece(piece: piece_name, color: invalid_color) }.to raise_error(NotImplementedError)
      end
    end
  end
end
