# frozen_string_literal: true

describe Piece do
  describe '#self.create' do
    context 'when the piece is a rook' do
      xit 'creates a Rook subclass' do
        piece_name = 'R'
        expect(rook_subclass).to receive(:new).with(:color)
        described_class.create(piece_name)
      end
    end
  end
end
