# frozen_string_literal: true

describe Piece do
  describe '#self.create' do
    context 'when the piece is a king' do
      xit 'creates a King subclass' do
        piece_name = :king
        expect(rook_subclass).to receive(:new).with(:color)
        described_class.create(piece_name)
      end
    end
  end
end
