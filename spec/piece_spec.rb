# frozen_string_literal: true

RSpec.describe Piece do
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

  describe '#define_en_passant_square' do
    subject(:generic_piece) { described_class.new(color: 'white', position: 'F5') }
    it 'returns nil' do
      pending_move = 'F7'
      expect(generic_piece.define_en_passant_square(pending_move)).to be(nil)
    end
  end

  describe '#capture_en_passant?' do
    subject(:generic_piece) { described_class.new(color: 'white', position: 'E4') }
    it 'returns false' do
      target_square = 'E5'
      expect(generic_piece.capture_en_passant?(target_square)).to be(false)
    end
  end

  describe '#can_promote?' do
    subject(:generic_piece) { described_class.new(color: 'white', position: 'E4') }
    it 'returns false' do
      expect(generic_piece.can_promote?).to be(false)
    end
  end

  describe '#involved_in_castling?' do
    subject(:generic_piece) { described_class.new(color: 'black', position: 'A1') }
    it 'returns false' do
      expect(generic_piece.involved_in_castling?).to be(false)
    end
  end

  describe '#castle_move?' do
    subject(:generic_piece) { described_class.new(color: 'black', position: 'A1') }
    it 'returns false' do
      placeholder_arg = 'A1'
      expect(generic_piece.castle_move?(placeholder_arg)).to be(false)
    end
  end

  describe '#disable_castle_rights' do
    subject(:generic_piece) { described_class.new(color: 'white', position: 'A1') }
    it 'returns nil' do
      dummy_castler = 'castle_manager'
      expect(generic_piece.disable_castle_rights(dummy_castler)).to be(nil)
    end
  end

  describe '#move_resets_clock?' do
    subject(:generic_piece) { described_class.new(color: 'white', position: 'A1') }
    it 'returns false' do
      expect(generic_piece.move_resets_clock?).to be(false)
    end
  end

  describe '#to_fen' do
    subject(:generic_piece) { described_class.new(color: 'white', position: 'A1') }
    it 'returns nil' do
      expect(generic_piece.to_fen).to be(nil)
    end
  end
end
