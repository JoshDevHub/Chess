# frozen_string_literal: true

require_relative '../lib/coordinate'
require_relative '../lib/piece'
Dir[File.join(__dir__, '../lib/pieces', '*.rb')].sort.each { |file| require file }

describe Piece do
  describe '#self.from_fen' do
    context 'when the piece is a white king' do
      it 'creates a King subclass' do
        piece_fen = 'K'
        square = 'E1'
        subclass = described_class.from_fen(piece_fen, square)
        expect(subclass).to be_a(King)
      end
    end

    context 'when the piece is a black rook' do
      it 'creates a Rook subclass' do
        piece_fen = 'r'
        square = 'H8'
        subclass = described_class.from_fen(piece_fen, square)
        expect(subclass).to be_a(Rook)
      end
    end

    context 'when a piece is a black pawn' do
      it 'creates a BlackPawn subclass' do
        piece_fen = 'p'
        square = 'G7'
        subclass = described_class.from_fen(piece_fen, square)
        expect(subclass).to be_a(BlackPawn)
      end
    end

    context 'when the piece does not exist' do
      it 'raises a NotImplementedError' do
        piece_fen = 'Z'
        square = 'D1'
        expect { described_class.from_fen(piece_fen, square) }.to raise_error(NotImplementedError)
      end
    end
  end

  describe '#initialize' do
    context 'when the color is a valid color' do
      it 'does not raise an error' do
        color = 'white'
        square = 'B1'
        expect { described_class.new(color: color, position: square) }.to_not raise_error
      end
    end

    context 'when the color is an invalid color' do
      it 'raises a NotImplementedError' do
        color = 'yellow'
        square = 'H6'
        expect { described_class.new(color: color, position: square) }.to raise_error(NotImplementedError)
      end
    end
  end

  describe '#opponent_color' do
    let(:square) { 'A1' }
    context 'when the piece is white' do
      subject(:white_piece) { described_class.new(color: 'white', position: square) }
      it "returns 'black'" do
        opponent = 'black'
        expect(white_piece.opponent_color).to eq(opponent)
      end
    end

    context 'when the piece is black' do
      subject(:black_piece) { described_class.new(color: 'black', position: square) }
      it "returns 'white'" do
        opponent = 'white'
        expect(black_piece.opponent_color).to eq(opponent)
      end
    end
  end
end
