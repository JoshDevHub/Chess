# frozen_string_literal: true

require_relative '../lib/coordinate'

describe Coordinate do
  subject(:coordinate_includer) { Class.new { extend Coordinate } }
  describe '#to_square_notation' do
    context 'when the coordinate is [0, 0]' do
      it 'returns A8' do
        coordinate = [0, 0]
        square = 'A8'
        expect(coordinate_includer.to_square_notation(coordinate)).to eq(square)
      end
    end
    context 'when the coordinate is [5, 3]' do
      it 'returns F5' do
        coordinate = [5, 3]
        square = 'F5'
        expect(coordinate_includer.to_square_notation(coordinate)).to eq(square)
      end
    end
    context 'when the coordinate is [2, 7]' do
      it 'returns C1' do
        coordinate = [2, 7]
        square = 'C1'
        expect(coordinate_includer.to_square_notation(coordinate)).to eq(square)
      end
    end
  end
end
