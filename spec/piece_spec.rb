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

    context 'when the piece does not exist' do
      it 'raises a NotImplementedError' do
        piece_fen = 'Z'
        expect { described_class.from_fen(piece_fen) }.to raise_error(NotImplementedError)
      end
    end
  end

  describe '#initialize' do
    context 'when the color is a valid color' do
      it 'does not raise an error' do
        color = 'white'
        expect { described_class.new(color: color) }.to_not raise_error(NotImplementedError)
      end
    end

    context 'when the color is an invalid color' do
      it 'raises a NotImplementedError' do
        color = 'yellow'
        expect { described_class.new(color: color) }.to raise_error(NotImplementedError)
      end
    end
  end

  describe '#opponent_color' do
    context 'when the piece is white' do
      subject(:white_piece) { described_class.new(color: 'white') }
      it "returns 'black'" do
        opponent = 'black'
        expect(white_piece.opponent_color).to eq(opponent)
      end
    end

    context 'when the piece is black' do
      subject(:black_piece) { described_class.new(color: 'black') }
      it "returns 'white'" do
        opponent = 'white'
        expect(black_piece.opponent_color).to eq(opponent)
      end
    end
  end

  subject(:generic_piece) { described_class.new(color: 'white') }
  describe '#implemented_moves' do
    it 'returns an empty array' do
      expect(generic_piece.implemented_moves).to be_empty
    end
  end

  describe '#piece_moved' do
    it 'changes @moved to true' do
      expect { generic_piece.piece_moved }.to change { generic_piece.moved }.to(true)
    end
  end

  describe '#line_moves?' do
    it 'returns false' do
      expect(generic_piece.line_moves?).to be(false)
    end
  end
end
