# frozen_string_literal: true

require_relative '../lib/square'

describe Square do
  let(:piece) { double('piece') }
  describe '#empty?' do
    context 'when the square is empty' do
      subject(:empty_square) { described_class.new(name: 'name') }
      xit 'returns true' do
        expect(empty_square.empty?).to be(true)
      end
    end

    context 'when the square holds a piece' do
      subject(:occupied_square) { described_class.new(name: 'name', occupant: piece) }
      xit 'returns false' do
        expect(occupied_square.empty?).to be(false)
      end
    end
  end
end
