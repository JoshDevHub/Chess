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
end
