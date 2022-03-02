# frozen_string_literal: true

require_relative '../lib/coordinate'
require_relative '../lib/square'
require_relative '../lib/piece'

describe Square do
  let(:piece) { instance_double(Piece) }
  describe '#unoccupied?' do
    context 'when the square is empty' do
      subject(:square) { described_class.new(name: 'A1') }
      it 'returns true' do
        expect(square.unoccupied?).to be(true)
      end
    end

    context 'when the square is occupied' do
      subject(:square) { described_class.new(name: 'A1', piece: piece) }
      it 'returns false' do
        expect(square.unoccupied?).to be(false)
      end
    end
  end

  describe '#add_piece' do
    context 'when the square is unoccupied' do
      subject(:square) { described_class.new(name: 'A1') }
      it 'changes @piece from nil to the given piece' do
        expect { square.add_piece(piece) }.to change { square.piece }.from(nil).to(piece)
      end
    end

    context 'when the square is occupied' do
      subject(:square) { described_class.new(name: 'A1', piece: piece) }
      let(:new_piece) { instance_double(Piece) }
      it 'changes @piece from the current piece to the given piece' do
        expect { square.add_piece(new_piece) }.to change { square.piece }.from(piece).to(new_piece)
      end
    end
  end

  describe '#remove_piece' do
    context 'when the square is unoccupied' do
      subject(:square) { described_class.new(name: 'A1') }
      it 'returns nil' do
        expect(square.remove_piece).to be(nil)
      end

      it 'does not change the value held at @piece' do
        expect { square.remove_piece }.to_not change { square.piece }
        square.remove_piece
      end
    end

    context 'when the square is occupied' do
      subject(:square) { described_class.new(name: 'A1', piece: piece) }
      it 'returns the removed piece' do
        expect(square.remove_piece).to eq(piece)
      end

      it 'changes @piece from piece to nil' do
        expect { square.remove_piece }.to change { square.piece }.from(piece).to(nil)
      end
    end
  end
end
