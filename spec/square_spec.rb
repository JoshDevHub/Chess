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
      subject(:occupied_square) { described_class.new(name: 'name', occupant: piece) }
      it 'returns false' do
        expect(occupied_square.empty?).to be(false)
      end
    end
  end

  describe '#add_occupant' do
    context 'when the square is empty' do
      subject(:empty_square) { described_class.new(name: 'name') }
      it 'adds the piece to the square' do
        expect { empty_square.add_occupant(piece) }.to change { empty_square.occupant }.to(piece)
      end
    end

    context 'when the square is already occupied' do
      subject(:occupied_square) { described_class.new(name: 'name', occupant: piece) }
      let(:piece_two) { double('piece two') }
      it 'add the piece to the square' do
        expect { occupied_square.add_occupant(piece_two) }.to change { occupied_square.occupant }.to(piece_two)
      end
    end
  end
end
