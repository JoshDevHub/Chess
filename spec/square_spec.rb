# frozen_string_literal: true

require_relative '../lib/square'

describe Square do
  let(:piece) { double('piece') }
  describe '#empty?' do
    context 'when the square is empty' do
      subject(:empty_square) { described_class.new(name: 'name') }
      it 'returns true' do
        expect(empty_square.empty?).to be(true)
      end
    end

    context 'when the square holds a piece' do
      subject(:occupied_square) { described_class.new(name: 'name', piece: piece) }
      it 'returns false' do
        expect(occupied_square.empty?).to be(false)
      end
    end
  end

  describe '#add_piece' do
    context 'when the square is empty' do
      subject(:empty_square) { described_class.new(name: 'name') }
      it 'adds the piece to the square' do
        expect { empty_square.add_piece(piece) }.to change { empty_square.piece }.to(piece)
      end
    end

    context 'when the square is already occupied' do
      subject(:occupied_square) { described_class.new(name: 'name', piece: piece) }
      let(:piece_two) { double('piece two') }
      it 'add the piece to the square' do
        expect { occupied_square.add_piece(piece_two) }.to change { occupied_square.piece }.to(piece_two)
      end
    end
  end

  describe '#remove_piece' do
    context 'when the square is empty' do
      subject(:empty_square) { described_class.new(name: 'name') }
      it 'has no effect' do
        expect { empty_square.remove_piece }.not_to change { empty_square.piece }
      end
    end

    context 'when the square is occupied' do
      subject(:occupied_square) { described_class.new(name: 'name', piece: piece) }
      it 'removes the piece from the square' do
        expect { occupied_square.remove_piece }.to change { occupied_square.piece }.to(nil)
      end
    end
  end
end
